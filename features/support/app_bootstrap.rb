# features/support/app_bootstrap.rb
# frozen_string_literal: true

ANDROID_APP_PACKAGE  = 'com.mercadolibre'
ANDROID_APP_ACTIVITY = 'com.mercadolibre.splash.SplashActivity'

def core_driver
  # Devuelve el Selenium::WebDriver activo
  if defined?($driver) && $driver && $driver.driver
    return $driver.driver
  end

  # Si llegas aquí, no hay sesión activa
  raise 'Appium driver not started. Call $driver.start_driver first.'
end

def close_app_if_open!
  begin
    core_driver.terminate_app(ANDROID_APP_PACKAGE)
  rescue => e
    warn "terminate_app warn: #{e.message}"
  end
end

def open_app!
  begin
    core_driver.start_activity(
      app_package: ANDROID_APP_PACKAGE,
      app_activity: ANDROID_APP_ACTIVITY
    )
  rescue => e
    warn "start_activity fallback (#{e.message})"
    begin
      core_driver.activate_app(ANDROID_APP_PACKAGE)
    rescue => e2
      warn "activate_app fallback (#{e2.message}), trying launch_app..."
      core_driver.launch_app
    end
  end
end

def wait_for_activity(expected_activity, timeout: 20, interval: 0.5)
  deadline = Time.now + timeout
  expected_tail = expected_activity.split('.').last

  loop do
    current = nil
    begin
      current = core_driver.current_activity
    rescue
      # Ignora mientras la app inicia
    end
    return true if current &&
                   (current == expected_activity ||
                    current.end_with?(expected_activity) ||
                    current.include?(expected_tail))

    break if Time.now > deadline
    sleep interval
  end
  warn "wait_for_activity: no apareció #{expected_activity} en #{timeout}s"
  false
end

def restart_app!
  close_app_if_open!
  sleep 1
  open_app!
  wait_for_activity(ANDROID_APP_ACTIVITY, timeout: 20)
end


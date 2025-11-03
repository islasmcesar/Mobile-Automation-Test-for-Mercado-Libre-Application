require 'base64'

Before do
    # 1) Asegura la sesión Appium
    $driver.start_driver unless ($driver && $driver.driver)

    # 2) Reinicia la app (cierra si está abierta y vuelve a abrir)
    restart_app!

    # 3) Contexto nativo (por si la app abre en webview)
    begin
        ctx = driver.current_context
        $driver.context('NATIVE_APP') unless ctx == 'NATIVE_APP'
    rescue => e
        warn "WARN context switch: #{e.message}"
    end

    # 4) Lo tuyo
    @step_idx = 0
end

AfterStep do |*args|
    @step_idx += 1
    test_step = args[1] rescue nil

    step_text =
        if test_step&.respond_to?(:text) && test_step.text
        test_step.text
        elsif test_step&.respond_to?(:source)
        src = test_step.source
        node = src.respond_to?(:last) ? src.last : src
        node.respond_to?(:text) ? node.text : node.to_s
        else
        "Step #{@step_idx}"
        end

    begin
        png_raw = Base64.decode64(driver.screenshot_as(:base64))
        attach(png_raw, 'image/png', "##{@step_idx} #{step_text}")
    rescue => e
        warn "WARN AfterStep screenshot: #{e.message}"
    end
end

After do |scenario|
    $driver.driver_quit
    next unless scenario.failed?
    png_b64 = driver.screenshot_as(:base64) # Appium en Ruby
    attach(png_b64, 'image/png;base64', 'Screenshot (failure)')
end
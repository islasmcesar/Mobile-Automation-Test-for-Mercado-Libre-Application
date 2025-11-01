require "appium_lib"

def caps
    {
      caps: {
        platformName: "Android",
        automationName: "UiAutomator2",
        deviceName: "a52q",
        appPackage: "com.mercadolibre",
        appActivity: "com.mercadolibre.splash.SplashActivity",
        noReset: true,
        newCommandTimeout: 3600,
        appWaitActivity: "com.mercadolibre.*, com.google.android.gms.*",
        appWaitDuration: 20000
      }
    }
end

$driver = Appium::Driver.new(caps,true)
Appium.promote_appium_methods Object
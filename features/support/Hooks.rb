Before do
    $driver.start_driver
    ctx = driver.current_context
    $driver.context('NATIVE_APP') unless ctx == 'NATIVE_APP'
end

After do
    $driver.driver_quit
end
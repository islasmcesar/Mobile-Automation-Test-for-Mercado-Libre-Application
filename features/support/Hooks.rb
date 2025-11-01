Before do
    $driver.start_driver
    puts "se inicio el driver"
end

After do
    $driver.driver_quit
end
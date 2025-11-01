class BasePage
    attr_accessor :timeout
    
    def initialize(timeout = 10)
            @timeout = timeout
    end
    
    def wait()
            Selenium::WebDriver::Wait.new(timeout: @timeout, interval: 0.5)
    end

    def by(element)
            element.first
    end

    def find(locator)
            by, value = by(locator)
            wait().until { $driver.find_element(by, value) } 
    end

    def click(locator)
            find(locator).click
    end


end
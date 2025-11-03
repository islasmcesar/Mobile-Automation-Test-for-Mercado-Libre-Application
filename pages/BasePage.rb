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
            find(locator).click()
    end

    def sendKeys(locatos,txt)
            find(locatos).send_keys(txt)  
    end

    def switchToNative()
            ctx = driver.current_context
            driver.context('NATIVE_APP') unless ctx == 'NATIVE_APP'
    end

    #direction: "down", "up", "left", "rigth"
    #percent: 0.0 -> 1
    def scrollIn(containerLocator,direction: "down",percent: 1.0)
            container = find(containerLocator)
            scrollable = container.rect # => {:x,:y,:width,:height}
            $driver.execute_script(
            'mobile: scrollGesture',
            {
                left: scrollable[:x],
                top: scrollable[:y],
                width: scrollable[:width],
                height: scrollable[:height],
                direction: direction,
                percent: percent
            }
        )  
    end

    def findContainedElement(container, locator)
            by, value = by(locator)
            $driver.find_element(by, value)
      
    end

    #direction: "down", "up", "left", "rigth"
    def scrollUntilVisibleIn(container_locator, target_locator, direction , max_swipes: 10)
            container = find(container_locator)
            max_swipes.times do
                        begin
                                return findContainedElement(container, target_locator)
                        rescue
                                scrollIn(container_locator, direction: direction)
                        end  
            end
            begin
                return findContainedElement(container, target_locator)
            rescue Selenium::WebDriver::Error::NoSuchElementError
                raise "No se encontró el elemento #{target_locator.inspect} dentro del contenedor tras #{max_swipes} scrolls"
            end
    end

    def scrollToInto(container,objetivo)
            txtContainer = container.first()[1]
            txtObjetivo = objetivo.first()[1]
            $driver.find_element(:android_uiautomator,
            %Q(new UiScrollable(new UiSelector().resourceId("#{txtContainer}")).scrollIntoView(new UiSelector().textContains("#{txtObjetivo}"))))  
    end

    KEYCODES_DIGITS = { '0'=>7,'1'=>8,'2'=>9,'3'=>10,'4'=>11,'5'=>12,'6'=>13,'7'=>14,'8'=>15,'9'=>16 }
    def android_type_digits_via_keycodes(digits)
            5.times do
                $driver.press_keycode(112)  
            end
            digits.to_s.each_char do |ch|
                code = KEYCODES_DIGITS[ch] or raise "No es dígito: #{ch}"
                $driver.press_keycode(code)
            end
    end

    def android_type_via_adb(text)
            escaped = text.gsub(' ', '%s')
            $driver.execute_script('mobile: shell', { command: 'input', args: ['text', escaped] })
    end

    def findContainedElement(container_el, locator)
            by, value = locator.first
            container_el.find_element(by, value)
    end

    def scroll(n)
            n.times do
                driver.execute_script('mobile: scrollGesture', {
                    left: 500, top: 1000, width: 500, height: 1000,
                    direction: 'down', percent: 0.6
                })
            end  
    end

end
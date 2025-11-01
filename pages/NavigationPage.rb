class NavigationPage < BasePage
    

    def initialize(timeout = 10)
            super(timeout)
            @elements = ENavigation
    end

    def clickNavBar()
            click(@elements::NAV_BAR)
    end

    def searchPlaystation5()
            
    end

end
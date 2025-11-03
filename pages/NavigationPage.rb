class NavigationPage < BasePage
    

    def initialize(timeout = 10)
            super(timeout)
            @elements = ENavigation
    end

    def clickNavBar()
            click(@elements::NAV_BAR)
    end

    def clickContinuarComoInvitado()
            begin
                click(@elements::TXT_CONTINUAR_COMO_INVITADO)
            rescue
            end

    end

    def searchPlaystation5()
            clickNavBar()
            sendKeys(@elements::INPUT_SEARCH,"Playstation 5")
            $driver.execute_script('mobile: performEditorAction', { action: "search" })
    end

    def clickFiltros()
            click(@elements::TXT_FILTROS)  
    end

    def applyFiltroNuevos()
            #clickFiltros()
            #scrollUntilVisibleIn(@elements::CONTAINER_FILTROS,@elements::FILTRO_NUEVO,"down")
            #click(@elements::VER_RESULTADOS)
    end

    def ingresarCP()
            click(@elements::TXT_INGRESAR_CP) 
            android_type_digits_via_keycodes("16029")
            click(@elements::BTN_USAR_CP)
            begin
                begin
                    sleep(1)
                    click(@elements::CLOSE_ELIGE_UNA_CUENTA)
                rescue
                end
                sleep(3)
                find(@elements::BTN_CONTINUAR)
                click(@elements::ARROW_BACK)
            rescue
            end
    end

    def applyFiltroMayorPrecio()
            
    end

    def printProductCardPLP(i)
            container = find({xpath: "(//android.view.View[@resource-id=\"polycard_component\"])[#{i}]"})
            labels = container.find_elements(:class_name,@elements::TXT_CONTAINER_CLASS.first()[1])
            texts = labels.map { |e| e.attribute('text') }
            txtProducto = texts[0]
            if (txtProducto.eql?("RECOMENDADO") || txtProducto.eql?("MÁS VENDIDO"))
                txtProducto = texts[1]
                txtPrecio = texts[5]
            else
                txtPrecio = texts[4]
            end
            puts(txtProducto)
            puts("Precio: " + txtPrecio)
            puts("\n")  
    end

    def printFirstNProductsPLP(n)
            puts("\n\nPrimeros #{n} productos:\n\n")
            if(n >= 1)
                printProductCardPLP(1)
            end
            if(n >= 2)
                printProductCardPLP(2)
            end
            if(n >= 3)
                i = 3
                while i <= n
                        mod = i%2
                        if(mod != 0)    
                                scroll(2)
                        end
                        printProductCardPLP(4 - mod)
                        i += 1
                end
            end
    end

    def obtainTheNameAndPriceOfTheFirstFiveProducts()
            printFirstNProductsPLP(5)
    end

end
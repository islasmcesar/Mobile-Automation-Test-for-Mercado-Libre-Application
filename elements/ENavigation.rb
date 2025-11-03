class ENavigation
    NAV_BAR = {id: 'com.mercadolibre:id/ui_components_toolbar_search_field' }
    INPUT_SEARCH = {id: 'com.mercadolibre:id/autosuggest_input_search' }
    TXT_FILTROS = {xpath: "(//android.widget.LinearLayout[@resource-id=\"com.mercadolibre:id/appbar_content_layout\"])[1]/android.widget.LinearLayout" }
    CONTAINER_FILTROS = {xpath: "//android.view.View[@resource-id=\"root-app\"]/android.view.View[1]"}
    FILTRO_NUEVO ={xpath: "//android.widget.ToggleButton[@text='Nuevo']"}
    FILTROS_CONDICION = {accessibility_id: "Condición"}
    CERRAR_FILTROS = {id: "com.mercadolibre:id/andes_bottom_sheet_outside_dismiss_button"}
    VER_RESULTADOS = {id: ":r3:"}
    TXT_INGRESAR_CP = {id: "com.mercadolibre:id/destination"}
    INPUT_INGRESAR_CP ={xpath: "//android.view.View[@resource-id=\":Rk9ke:\"]/android.view.View[1]/android.view.View[2]"}
    BTN_USAR_CP = {class: "android.widget.Button"}
    ARROW_BACK = {class: "android.widget.ImageButton"}
    BTN_CONTINUAR = {xpath: "(//android.widget.FrameLayout[@resource-id=\"com.mercadolibre:id/andes_button_progress_determinate_container\"])[1]"}
    CONTENEDOR_LISTA_PRODUCTOS = {accessibility_id: "search_content"}
    PRODUCT_CONTAINER = {xpath: "(//android.view.View[@resource-id=\"polycard_component\"])[1]"}
    TXT_CONTAINER_CLASS = {class: "android.widget.TextView"}
    RESULTS_CONTAINER = { xpath: %q(//android.view.View[@resource-id="root-app"]/android.view.View[1]) }
    PRODUCT_CARD_REL  = %q(.//android.view.View[contains(@resource-id,'polycard_component')])
    RESULTS_CONTAINER = { xpath: %q(//android.view.View[@resource-id="root-app"]/android.view.View[1]) }
    PRODUCT_CARD_REL  = %q(.//android.view.View[contains(@resource-id,'polycard_component')])
    TXT_CONTINUAR_COMO_INVITADO = {xpath: "//android.widget.TextView[@resource-id=\"com.mercadolibre:id/andes_button_text\" and @text=\"Continuar como visitante\"]"}
    CLOSE_ELIGE_UNA_CUENTA = {id: "com.google.android.gms:id/cancel"}
end
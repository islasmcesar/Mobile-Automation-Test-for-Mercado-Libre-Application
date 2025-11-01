Feature: Navigation

    Scenario: Functionality to Test: Validate a search flow and filter functionality in the Mercado Libre mobile application.
        Given Open the Mercado Libre mobile application installed on the Android device.
        Then Search for the term playstation five in the search bar.
        Then Apply the filter for condition Nuevos.
        Then Apply the filter for location CDMX.
        Then Order the results by mayor a menor precio.
        Then Obtain the name and the price of the first five products displayed in the results.
        Then Print these products name and price in the console.
require_relative '../../elements/EBase'
require_relative '../../pages/BasePage'
require_relative '../../elements/ENavigation'
require_relative '../../pages/NavigationPage'

np = NavigationPage.new()

Given('Open the Mercado Libre mobile application installed on the Android device.') do
    np.clickNavBar
end

Then('Search for the term playstation five in the search bar.') do

end

Then('Apply the filter for condition Nuevos.') do
  
end

Then('Apply the filter for location CDMX.') do
  
end

Then('Order the results by mayor a menor precio.') do
  
end

Then('Obtain the name and the price of the first five products displayed in the results.') do
  
end

Then('Print these products name and price in the console.') do
  
end
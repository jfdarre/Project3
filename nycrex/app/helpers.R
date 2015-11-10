plot_map = function(option, region){
  
  
  if (option == 'Number of listings') {
    data = group_by(listings, zip) %>% summarise(n())
    title_name = 'NUMBER OF LISTINGS PER ZIP CODE'
    leg_name = 'Number of Listings'
  }
  
  
  if (option == 'Average number of beds') {
    data = group_by(listings, zip) %>% summarise(mean(new_bed))
    title_name = 'AVERAGE NUMBER OF BEDS PER ZIP CODE'
    leg_name = 'Number of beds'
  }
  
  
  if (option == 'Average price per sqft') {
    data = group_by(listings, zip) %>% summarise(mean(ppsf[ppsf != 0]))
    title_name = 'AVERAGE PRICE PER SQFT PER ZIP CODE'
    leg_name = 'Price per sqft'
  }
  
  
  if (option == 'Average price per bedroom') {
    data = group_by(listings, zip) %>% summarise(mean(price/ifelse(new_bed == 0, 1, new_bed)))
    title_name = 'AVERAGE PRICE PER BEDROOM PER ZIP CODE'
    leg_name = 'Price per bedroom'
  }
  
  
  if (option == 'Average size of listings') {
    data = group_by(listings, zip) %>% summarise(mean(sqft))
    title_name = 'AVERAGE SIZE OF LISTINGS PER ZIP CODE'
    leg_name = 'Size of the listings'
  }
  
  
  if (option == 'Average size per bedroom') {
    data = group_by(listings, zip) %>% summarise(mean(sqft/ifelse(new_bed == 0, 1, new_bed)))
    title_name = 'AVERAGE SIZE PER BEDROOM PER ZIP CODE'
    leg_name = 'Size per bedroom'
  }
  
  
  nyc_fips = c()
  if ('STATEN-ISLAND' %in% region) { nyc_fips = append(nyc_fips, 36085) }
  if ('MANHATTAN'     %in% region) { nyc_fips = append(nyc_fips, 36061) }
  if ('BROOKLYN'      %in% region) { nyc_fips = append(nyc_fips, 36047) }
  if ('BRONX'         %in% region) { nyc_fips = append(nyc_fips, 36005) }
  if ('QUEENS'        %in% region) { nyc_fips = append(nyc_fips, 36081) }
  if (length(region)   ==       0) { nyc_fips = c(36085, 36061, 36047, 36005, 36081) }
  
  
  names(data) = c('region','value')
  data = merge(data, all_zip, all=T)
  data$value[is.na(data$value)] = 0
  data = filter(data, region != 11249)
  data$region = as.character(data$region)
  
  
  p = zip_choropleth(data,
                     county_zoom=nyc_fips,
                     title=title_name,
                     legend=leg_name)
  return(p)
}
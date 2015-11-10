library(shiny)
library(shinythemes)
library(leaflet)
library(RColorBrewer)
library(scales)
library(lattice)
library(dplyr)
library(choroplethr)
library(choroplethrZip)
library(ggplot2)

source("helpers.R")



shinyServer(
  function(input, output, session) {
    
    map_view = reactive({
      a = c(0,0)
      b = c(0,0)
      c = c(0,0)
      d = c(0,0)
      e = c(0,0)
      
      if (length(input$boro) == 0) {
        return(c(-73.820731,40.7456378,12))
      }
      
      if ('MANHATTAN' %in% input$boro) {
        a = c(-73.9028608,40.771812)
      } 
      
      if ('BROOKLYN' %in% input$boro) {
        b = c(-73.9017405,40.6432039)
      }
      
      if ('QUEENS' %in% input$boro) {
        c = c(-73.7960108,40.7205094)
      }
      
      if ('BRONX' %in% input$boro) {
        d = c(-73.8218746,40.8561418)
      }
      
      if ('STATEN-ISLAND' %in% input$boro) {
        e = c(-74.1057931,40.5756029)
      }
      
      if (length(input$boro) == 1) {
        return(c(a+b+c+d+e,13))
      }
      
      if (length(input$boro) > 1) {
        return(c((a+b+c+d+e)/length(input$boro),12))
      }
      
    })
    
    
    
    output$map <- renderLeaflet({
      leaflet() %>%
        addTiles() %>%
        setView(lng = map_view()[1], lat = map_view()[2], zoom = map_view()[3]) %>%
        addProviderTiles("CartoDB.Positron")
    })
    
    
    
    my_data = reactive({
      filter(listings,
             new_bed %in% input$bed,
             new_bath >= input$bath[1],
             new_bath <= input$bath[2],
             price >= input$price[1],
             price <= ifelse(input$price[2] == max_price, 1e9, input$price[2]),
             ppsf >= input$ppsf[1],
             ppsf <= ifelse(input$ppsf[2] == max_ppsf, 1e9, input$ppsf[2]),
             sqft >= input$sqft[1],
             sqft <= ifelse(input$sqft[2] == max_sqft, 1e9, input$sqft[2]),
             boro %in% input$boro,
             lAm_balcony >= ifelse('lAm_balcony' %in% input$lam, 2, 1),
             lAm_basement >= ifelse('lAm_basement' %in% input$lam, 2, 1),
             lAm_bikeRm >= ifelse('lAm_bikeRm' %in% input$lam, 2, 1),
             lAm_brdApRq >= ifelse('lAm_brdApRq' %in% input$lam, 2, 1),
             lAm_centAC >= ifelse('lAm_centAC' %in% input$lam, 2, 1),
             lAm_childPlay >= ifelse('lAm_childPlay' %in% input$lam, 2, 1),
             lAm_concier >= ifelse('lAm_concier' %in% input$lam, 2, 1),
             lAm_courtyard >= ifelse('lAm_courtyard' %in% input$lam, 2, 1),
             lAm_dishwasher >= ifelse('lAm_dishwasher' %in% input$lam, 2, 1),
             lAm_doorman >= ifelse('lAm_doorman' %in% input$lam, 2, 1),
             lAm_elevator >= ifelse('lAm_elevator' %in% input$lam, 2, 1),
             lAm_fios >= ifelse('lAm_fios' %in% input$lam, 2, 1),
             lAm_fireplace >= ifelse('lAm_fireplace' %in% input$lam, 2, 1),
             lAm_furnished >= ifelse('lAm_furnished' %in% input$lam, 2, 1),
             lAm_garage >= ifelse('lAm_garage' %in% input$lam, 2, 1),
             lAm_garden >= ifelse('lAm_garden' %in% input$lam, 2, 1),
             lAm_gatedCom >= ifelse('lAm_gatedCom' %in% input$lam, 2, 1),
             lAm_golf >= ifelse('lAm_golf' %in% input$lam, 2, 1),
             lAm_guarantorOK >= ifelse('lAm_guarantorOK' %in% input$lam, 2, 1),
             lAm_gym >= ifelse('lAm_gym' %in% input$lam, 2, 1),
             lAm_laundry >= ifelse('lAm_laundry' %in% input$lam, 2, 1),
             lAm_liveInSuper >= ifelse('lAm_liveInSuper' %in% input$lam, 2, 1),
             lAm_loft >= ifelse('lAm_loft' %in% input$lam, 2, 1),
             lAm_lounge >= ifelse('lAm_lounge' %in% input$lam, 2, 1),
             lAm_mediaRm >= ifelse('lAm_mediaRm' %in% input$lam, 2, 1),
             lAm_packageRm >= ifelse('lAm_packageRm' %in% input$lam, 2, 1),
             lAm_parking >= ifelse('lAm_parking' %in% input$lam, 2, 1),
             lAm_patio >= ifelse('lAm_patio' %in% input$lam, 2, 1),
             lAm_pets >= ifelse('lAm_pets' %in% input$lam, 2, 1),
             lAm_pool >= ifelse('lAm_pool' %in% input$lam, 2, 1),
             lAm_recFac >= ifelse('lAm_recFac' %in% input$lam, 2, 1),
             lAm_roofDeck >= ifelse('lAm_roofDeck' %in% input$lam, 2, 1),
             lAm_smokeFree >= ifelse('lAm_smokeFree' %in% input$lam, 2, 1),
             lAm_storage >= ifelse('lAm_storage' %in% input$lam, 2, 1),
             lAm_sublet >= ifelse('lAm_sublet' %in% input$lam, 2, 1),
             lAm_tennis >= ifelse('lAm_tennis' %in% input$lam, 2, 1),
             lAm_terrace >= ifelse('lAm_terrace' %in% input$lam, 2, 1),
             lAm_washerDryer >= ifelse('lAm_washerDryer' %in% input$lam, 2, 1)
             )
    })
    
    
    
    observeEvent(input$submit, {
      leafletProxy("map", data=my_data()) %>%
        addCircleMarkers(
          ~lon,
          ~lat,
          radius = 5,
          color = '#df691a',
          stroke = FALSE,
          fillOpacity = 0.5,
          popup = paste0('<p>', 'Bed = ', my_data()$new_bed, '<br>',
                         'Bath = ', my_data()$new_bath, '<br>', 
                         'Price = ', my_data()$price, '</p>',
                         '<a href=', my_data()$url, '>', 'Link', '</a>'))
    })
    
    
    
    observe({
      if ('ALL' %in% input$boro) {
        updateCheckboxGroupInput(
          session,
          'boro',
          selected = c('MANHATTAN','BROOKLYN','QUEENS','BRONX','STATEN-ISLAND')
        )
      }
    })
    
    
    
    output$remaining = renderText({ 
      paste0("Remaining listings: ", prettyNum(nrow(my_data()), big.mark = ",")) 
    })
    
    
    
    output$explore_plot = renderPlot(
      plot_map(input$map_input, input$map_boro),
      height = 580*1.85,
      width = 740*1.85
    )
    
    
    
    observe({
      if ('ALL' %in% input$map_boro) {
        updateCheckboxGroupInput(
          session, 
          'boro', 
          selected = c('MANHATTAN','BROOKLYN','QUEENS','BRONX','STATEN-ISLAND')
        )
      }
    })
  }
)
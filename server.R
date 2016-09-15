# Load in the set-up file
source("set-up.R")

# Start of Shiny Server Code
shinyServer(function(input, output) {
#Render Map
  output$map <- renderLeaflet({
    leaflet() %>%
      # set centre and extent of map to london
      setView(lng = -0.1, lat = 51.5, zoom = 9) %>%
      # set base map
      addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) 

  })
  
  observeEvent(input$map_bounds, { #Update the map when the location changes
    # Get map bounds
    #mapbounds <- input$map_bounds
    #mapzoom <- input$map_zoom
    #Get the appropiate zones for the map
    #answer_zone <- delay(1000,askDBzones(mapbounds,mapzoom))
    answer_zone <- askDBzones(input$map_bounds,input$map_zoom)
    # plot map
    proxy <- leafletProxy("map")
    # remove old layers
    proxy %>% clearShapes()
    #render new layers
    proxy %>% addPolygons(data = answer_zone,
                          color = "black", 
                          stroke = TRUE, 
                          fillOpacity = 0.5)
    
    
  #if(!is.null(answer_centroid) ){ #Only plot centroids if centroids are aviaible   & exists("answer_centroid")
 # proxy %>% addCircleMarkers(data = answer_centroid, 
  #                          color = "red", 
  #                        radius = 3, 
  #                          stroke = FALSE, 
   #                        fillOpacity = 0.7)
  #    }
    }) 
  
})


library(shiny)
library(leaflet)
source("set-up.R")
source("connect.R")

# Start of Shiny Server Code
shinyServer(function(input, output) {

#Render Map
  output$mymap <- renderLeaflet({
    leaflet() %>%
      # set centre and extent of map to london
      setView(lng = -0.1, lat = 51.5, zoom = 14) %>%
      # set base map
      addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) 

  })

  #Watch the bounds of the map as the user scrolls around
  #the query the server for the MSOA that are within view
  observe({
    mapbounds <- input$mymap_bounds
    if(is.null(input$mymap_bounds)){
        # no map bounds so do defult query
        query <- "SELECT id, geom, code, name FROM msoa84 WHERE geom && ST_MakeEnvelope(-0.11, 51.4, -0.09, 51.5, 4326)"
        answer <- askDB(query)
      } else {

        # have bounds so query the database
        query2 <- paste0("SELECT id, geom, code, name FROM msoa84 WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer <- askDB(query2)
    }
    # plot msoa
    proxy <- leafletProxy("mymap")
      # remove old msoa layer
      proxy %>% clearShapes()
      #render new msoa layer
      proxy %>%addPolygons(data = answer)
  })
  
})

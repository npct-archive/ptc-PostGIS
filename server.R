library(shiny)
library(leaflet)
source("connect.R")

# Start of Shiny Server Code
shinyServer(function(input, output) {
#colours
#qpal <- colorQuantile("Blues", answer_zone$bicycle, n = 7)
#Render Map
  output$mymap <- renderLeaflet({
    leaflet() %>%
      # set centre and extent of map to london
      setView(lng = -0.1, lat = 51.5, zoom = 14) %>%
      # set base map
      addProviderTiles("Stamen.TonerLite", options = providerTileOptions(noWrap = TRUE)) 

  })

  #Watch the bounds of the map as the user scrolls around
  #the query_zone the server for the MSOA that are within view
  observe({
    mapbounds <- input$mymap_bounds
    mapzoom <- input$mymap_zoom
    if(is.null(input$mymap_bounds)){
        # no map bounds so do defult query_zone
        query_zone <- "SELECT id, geom, code FROM msoa84 WHERE geom && ST_MakeEnvelope(-0.11, 51.45, -0.09, 51.5, 4326)"
        answer_zone <- askDB(query_zone)
        # also get centroids
        query_centroid <- paste0("SELECT id, geom, code FROM msoa_centroid WHERE geom && ST_MakeEnvelope(-0.11, 51.45, -0.09, 51.5 ,4326)")
        answer_centroid <- askDB(query_centroid)
    } 
    else if(mapzoom >= 11 & mapzoom <= 13){
        # Zomed out so show MSOA
        query_zone <- paste0("SELECT id, geom, code FROM msoa84 WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer_zone <- askDB(query_zone)
        # also get centroids
        query_centroid <- paste0("SELECT id, geom, code FROM msoa_centroid WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer_centroid <- askDB(query_centroid)
    }
    else if(mapzoom >= 14 & mapzoom <= 16){
        # Zomed in so show LSOA
        query_zone <- paste0("SELECT id, geom, code FROM lsoa WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer_zone <- askDB(query_zone)
        # also get centroids
        query_centroid <- paste0("SELECT id, geom, code FROM lsoa_centroid WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer_centroid <- askDB(query_centroid)
    }
    else if(mapzoom >= 17){
        # Zomed really in so show OA
        query_zone <- paste0("SELECT id, geom, code FROM oa WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer_zone <- askDB(query_zone)
        # also get centroids
        query_centroid <- paste0("SELECT id, geom, code FROM oa_centroid WHERE geom && ST_MakeEnvelope(",mapbounds$west,",",mapbounds$south,",",mapbounds$east,",",mapbounds$north,",4326)")
        answer_centroid <- askDB(query_centroid)
    }
    else
        # really zoomed out so render nothing
        # no map bounds so do defult query_zone
        query_zone <- "SELECT id, geom, code FROM msoa84 WHERE geom && ST_MakeEnvelope(-0.11, 51.45, -0.09, 51.5, 4326)"
        answer_zone <- askDB(query_zone)
        # also get centroids
        query_centroid <- paste0("SELECT id, geom, code FROM msoa_centroid WHERE geom && ST_MakeEnvelope(-0.11, 51.45, -0.09, 51.5 ,4326)")
        answer_centroid <- askDB(query_centroid)
    
    # plot map
    proxy <- leafletProxy("mymap")
      # remove old layers
      proxy %>% clearShapes()
      #render new layers
      proxy %>% addPolygons(data = answer_zone,
                            color = "black", 
                            stroke = TRUE, 
                            fillOpacity = 0.5)
      proxy %>% addCircleMarkers(data = answer_centroid, 
                                 color = "red", 
                                 radius = 3, 
                                 stroke = FALSE, 
                                 fillOpacity = 0.7)
  })
  
})

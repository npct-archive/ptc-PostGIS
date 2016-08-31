# Set Up the packages and connect to the database
source("set-up.R")
source("connect.R")
library(leaflet)
library(shiny)

#query the database

query <- "SELECT id, geom, code, name FROM msoa84 WHERE geom && ST_MakeEnvelope(-0.18, 51.45, -0.05, 51.5, 4326)"
answer <- askDB_o(query) #testing the open query

query2 <- "SELECT id, geom, code, name FROM lsoa_centroid WHERE geom && ST_MakeEnvelope(-0.18, 51.45, -0.05, 51.5, 4326)"
answer2 <- askDB(query2) #testing the open query

askDB_c() # disconnect from db

# change co-ordinate system to WGS84
#answer84 <- spTransform(answer, CRS("+init=epsg:4326"))

#plot the results
leaflet() %>%
    addTiles() %>%
    addPolygons(data = answer)
    addMarkers(data = answer2)

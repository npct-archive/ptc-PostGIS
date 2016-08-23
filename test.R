# Set Up the packages and connect to the database
source("set-up.R")
source("connect.R")
library(leaflet)
library(shiny)

#query the database

query <- "SELECT id, geom, code, name FROM msoa84 WHERE geom && ST_MakeEnvelope(-0.18, 51.4, -0.05, 51.5, 4326)"
answer <- askDB(query)

# change co-ordinate system to WGS84
#answer84 <- spTransform(answer, CRS("+init=epsg:4326"))

#plot the results
leaflet() %>%
    addTiles() %>%
    addPolygons(data = answer)





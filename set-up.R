# Prerequisites if neeeded

# install.packages("devtools")
# install.packages("RPostgreSQL")
# install.packages("postGIStools")
# devtools::install_github("SESYNC-ci/postGIStools")
# devtools::install_github("rstats-db/RPostgres")

#Basic Prerequisites for Shiny and Leaflet
library(shiny)
library(leaflet)
library(shinyjs)

#Basic Prerequisites for DB connection
library(RPostgreSQL)
library(postGIStools)
library(rgeos)
library(sp)
library(DBI)

#Basic Prereques for loading new data

library(ggmap)
library(e1071) # tmap dependency
library(tmap)
library(foreign) # loads external data
library(rgdal)   # for loading and saving geo* data
library(dplyr)  # for manipulating data rapidly
library(rgeos) # GIS functionality
library(raster) # GIS functions
library(maptools) # GIS functions
library(stplanr) # Sustainable transport planning with R
library(tidyr)# tidies up your data!
library(readr) # reads your data fast
library(knitr) # for knitting it all together
library(geojsonio)
library(rmapshaper) # To simplify rnet

# Prerquities files 
source("db.R")
source("connect.R")

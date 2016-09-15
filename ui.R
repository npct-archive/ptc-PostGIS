library(shiny)
library(leaflet)
library(RColorBrewer)

# Define UI for application
shinyUI(fluidPage(
  
  # Application title
  titlePanel("PCT using PostGIS"),
  
  # Show a plot of the generated distribution
  mainPanel(
      leafletOutput("map", width = 800, height = 600)
  )
))
# Prerequisites if neeeded

# install.packages("devtools")
# install.packages("RPostgreSQL")
# install.packages("postGIStools")
# devtools::install_github("SESYNC-ci/postGIStools")
# devtools::install_github("rstats-db/RPostgres")

#Basic Prerequisites for DB connection
library(RPostgreSQL)
library(postGIStools)
library(rgeos)
library(sp)
library(DBI)

#Connecto to the Database
source("connect.R")

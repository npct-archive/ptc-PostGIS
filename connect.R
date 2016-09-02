# contains a function which connects to the database
# runs SQL query and disconnects
# this is to keep the SQL code a clean as possbile
# in the rest of the code. I alos makes sure that the
# DB is not overloaded with unclosed connections

# get libraries and passwords
source("set-up.R")


#askDB_all - connect get info then disconnect - a basic function for connecting to the DB
askDB_all <- function (sql){
  
  # Connect to Database
  con <- dbConnect(dbDriver("PostgreSQL"), dbname = dbname, user = user, host = host, password = password)

  # Query the database
  result <- get_postgis_query(con, sql, geom_name = "geom", hstore_name = NA_character_)

  #disconnect from the database
  dbDisconnect(con)

  #Return the result
  return(result)
}

conDB <- function(){
  #Connect to Database
  con <- dbConnect(dbDriver("PostgreSQL"), dbname = dbname, user = user, host = host, password = password)
}

#askDB - connect get info but don't disconnect - for when you are asking several things at once
askDB <- function (sql){
  # Connect to Database
  con <- dbConnect(dbDriver("PostgreSQL"), dbname = dbname, user = user, host = host, password = password)
  
  # Query the database
  result <- get_postgis_query(con, sql, geom_name = "geom", hstore_name = NA_character_)
  
  #disconnect from the database
  dbDisconnect(con)
  
  #Return the result
  return(result)
}

#disDB - disconnect tfrom DB
disDB <- function (){

  #disconnect from the database
  dbDisconnect(con)
}
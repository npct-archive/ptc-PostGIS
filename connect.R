# contains a function which connects to the database
# runs SQL query and disconnects
# this is to keep the SQL code a clean as possbile
# in the rest of the code. I alos makes sure that the
# DB is not overloaded with unclosed connections

#function 
askDB <- function (sql){
  
# Variables for Database connection
dbname <- ""
host <- ""
user <- ""
port <- ""
password <- ""

# Connect to Database
con <- dbConnect(dbDriver("PostgreSQL"), dbname = dbname, user = user, host = host, password = password)

# Query the database

result <- get_postgis_query(con, sql, geom_name = "geom", hstore_name = NA_character_)

#disconnect from the database
dbDisconnect(con)

#Return the result
return(result)
}
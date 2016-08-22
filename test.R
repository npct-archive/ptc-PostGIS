# Set Up the packages and connect to the database
source("set-up.R")

#query the database

query <- get_postgis_query(con, "SELECT id, geom, msoa11cd, msoa11nm FROM msoa WHERE id < 10",
                               geom_name = "geom", hstore_name = NA_character_)

#disconnect from the database
dbDisconnect(con)


#plot the results
plot(query)
box()
axis(1)
axis(2)
grid()





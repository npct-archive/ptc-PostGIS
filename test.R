library(RPostgreSQL)
library(postGIStools)

con <- dbConnect(PostgreSQL(), dbname = "d2u06to89nuqei", user = "mzcwtmyzmgalae",
                 host = "ec2-107-22-246-250.compute-1.amazonaws.com",
                 password = "UTv2BuwJUPuruhDqJthcngyyvO")

countries <- get_postgis_query(con, "SELECT name, iso2, capital, population,
                               translations, geom FROM country 
                               WHERE population > 1000000",
                               geom_name = "geom", hstore_name = "translations")

class(countries)
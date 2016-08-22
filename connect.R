# Variables for Database connection
dbname <- "dbname"
host <- "host"
user <- "user"
port <- 5432
password <- "password"
# Connect to Database
con <- dbConnect(PostgreSQL(), dbname = dbname, user = user,
                 host = host,
                 password = password)
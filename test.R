# Set Up the packages and connect to the database
source("set-up.R")
source("connect.R")

#query the database

query <- "SELECT id, geom, msoa11cd, msoa11nm FROM msoa WHERE id < 10"
answer <- askDB(query)

#plot the results
plot(answer)






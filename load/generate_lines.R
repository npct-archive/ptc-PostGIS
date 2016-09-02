# Aim: find and re-add 'missing lines'
source("set-up.R")
cents = geojsonio::geojson_read("../pct-bigdata/cents-scenarios.geojson", what = "sp")
# load OD data - source http://wicid.ukdataservice.ac.uk/
unzip("../pct-bigdata/wu03ew_msoa.zip")
flow_cens = readr::read_csv("wu03ew_msoa.csv")
file.remove("wu03ew_msoa.csv")
nrow(flow_cens) # 2.4 m

# subset the centroids for testing (comment to generate national data)
cents = cents[grep(pattern = "Camb", x = cents$geo_label),]
plot(cents)
o <- flow_cens$`Area of residence` %in% cents$geo_code
d <- flow_cens$`Area of workplace` %in% cents$geo_code
flow <- flow_cens[o & d, ] # subset OD pairs with o and d in study area

omatch = match(flow$`Area of residence`, cents$geo_code)
dmatch = match(flow$`Area of workplace`, cents$geo_code)

cents_o = cents@coords[omatch,]
cents_d = cents@coords[dmatch,]
summary(is.na(cents_o)) # check how many origins don't match
summary(is.na(cents_d))
geodist = geosphere::distHaversine(p1 = cents_o, p2 = cents_d) / 1000 # assign euclidean distanct to lines (could be a function in stplanr)
summary(is.na(geodist))

hist(geodist, breaks = 0:800)
flow$dist = geodist
flow = flow[!is.na(flow$dist),] # there are 36k destinations with no matching cents - remove
flow = flow[flow$dist < 5,] # subset based on euclidean distance
names(flow) = gsub(pattern = " ", "_", names(flow))
flow_twoway = flow
flow = onewayid(flow, attrib = 3:14)
flow[1:2] = cbind(pmin(flow[[1]], flow[[2]]), pmax(flow[[1]], flow[[2]]))
nrow(flow) # down to 0.9m, removed majority of lines
lines = od2line2(flow = flow, zones = cents)
plot(lines)
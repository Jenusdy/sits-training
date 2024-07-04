# Create a data cube object based on the information about the files
library(sits) 

sinop <- sits_cube(
  source = "BDC",
  collection = "MOD13Q1-6",
  data_dir = system.file("extdata/sinop", package = "sitsdata"),
  parse_info = c("satellite", "sensor", "tile", "band", "date")
)
# select bands NDVI and EVI
sinop_2bands <- sits_select(sinop, bands = c("NDVI", "EVI"))
# Plot the NDVI for the first date (2013-09-14)
plot(sinop_2bands,
     band = "NDVI",
     dates = "2013-09-14",
     palette = "RdYlGn"
)

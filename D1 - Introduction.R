# Create a data cube object based on the information about the files
sinop <- sits_cube(
  source = "BDC",
  collection = "MOD13Q1-6",
  data_dir = system.file("extdata/sinop", package = "sitsdata"),
  parse_info = c("satellite", "sensor", "tile", "band", "date")
)

## Get path from the data index 1
sinop$file_info[[1]]$path[[1]]

# Show timeline data
sits_timeline(sinop)

# select bands NDVI and EVI
sinop_2bands <- sits_select(sinop, bands = c("NDVI", "EVI"))

# Plot the NDVI for the first date (2013-09-14)
plot(sinop_2bands,
     band = "NDVI",
     dates = "2013-09-14",
     palette = "RdYlGn",
     scale = 0.6
)

## Time series tibble

# Load the MODIS samples for Mato Grosso from the "sitsdata" package
library(tibble)
library(sitsdata)
data("samples_matogrosso_mod13q1", package = "sitsdata")
samples_matogrosso_mod13q1[1, ]$time_series

samples_2bands <- sits_select(samples_matogrosso_mod13q1, bands = c("NDVI", "EVI"))

# Train a random forest model
rf_model <- sits_train(
  samples = samples_2bands,
  ml_method = sits_rfor()
)
# Plot the most important variables of the model

# Classify the raster image
sinop_probs <- sits_classify(
  data = sinop_2bands,
  ml_model = rf_model,
  multicores = 2,
  memsize = 8,
  output_dir = tempdir()
)
# Plot the probability cube for class Forest
plot(sinop_probs, labels = "Forest", palette = "YlGnBu")
plot(sinop_probs, labels = "Soy_Corn", palette = "Greens")


# Label the probability file
sinop_map1 <- sits_label_classification(
  cube = sinop_probs,
  output_dir = tempdir()
)

plot(sinop_map1, title = "Sinop Classification Map")

# Perform spatial smoothing
sinop_bayes <- sits_smooth(
  cube = sinop_probs,
  multicores = 2,
  memsize = 8,
  output_dir = tempdir()
)

plot(sinop_bayes, labels = "Forest", palette = "YlGnBu")

sinop_map2 <- sits_label_classification(
  cube = sinop_bayes,
  output_dir = tempdir(),
  version = "smooth"
)

sits_view(sinop_map2)

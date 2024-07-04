# Set seed
set.seed(20240203)

# Libraries
library(sits)

# Set configurations variable for SNAP
Sys.setenv(
  "SITS_CONFIG_USER_FILE" = "/data/config_bps.yaml"
)

# Load configurations for SNAP
sits_config()

# Load cube
cube <- sits_cube(
  source     = "BPS",
  collection = "SENTINEL-1-RTC",
  data_dir   = "/data/indonesia/cube/"
)

samples <- readr::read_csv("/data/indonesia/samples/obs_14.csv")

cube_obs14 <- sits_select(
  cube, 
  start_date = as.Date("2022-03-01"),
  end_date = as.Date("2023-03-01"),
  bands = c("VV", "VH")
)

samples_ts <- sits_get_data(
  cube = cube,
  samples = samples,
  multicores = 16
)

som_cianjur <- sits_som_map(
  data = samples_ts,
  grid_xdim = 10,
  grid_ydim = 10,
  alpha = 1.0,
  distance = "dtw",
  mode = "pbatch"
)

# Plot the SOM map
plot(som_cianjur)

# Produce a tibble with a summary of the mixed labels
som_cianjur_eval <- sits_som_evaluate_cluster(som_cianjur)
# Show the result
plot(som_cianjur_eval)

new_samples_ts <- sits_som_clean_samples(
  som_map = som_cianjur
)

summary(new_samples_ts)

sits_view(samples_ts)

# Get the summary of the sampel
summary(samples_ts)

# List of bands
sits_bands(samples_ts)

# Plot of data samples
plot(samples_ts)

# Sits Plot 
plot(sits_patterns(samples_ts))

valid_1y <- sits_kfold_validate(samples_ts, folds = 5, ml_method = sits_rfor())

smap <- sits_som_map(samples_ts)
plot(smap)

som_eval <- sits_som_evaluate_cluster(smap)
plot(som_eval)

new_samples <- sits_som_clean_samples(
  som_map = smap,
  prior_threshold = 0.6,
  posterior_threshold = 0.6,
  keep = c("clean", "analyze")
)

sits_kfold_validate(new_samples, folds = 5, ml_method = sits_rfor())



# ===== Oktober
samples_ts_nov <- sits_select(
  samples_ts, 
  start_date = as.Date("2022-11-09"),
  end_date = as.Date("2023-03-01"),
  bands = c("VV", "VH")
)

plot(sits_patterns(samples_ts_nov))

valid_4m  <- sits_kfold_validate(samples_ts_nov, folds = 5, ml_method = sits_rfor())



# Read data culombia
samples_colombia <- readRDS("/data/colombia/samples/Casanare_VH_VV.rds")

sits_view(samples_colombia)

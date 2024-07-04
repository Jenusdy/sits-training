#
# Set seed
#
set.seed(777)

#
# Libraries
#
library(sits)

#
# Set configurations variable for SNAP
#
Sys.setenv(
  "SITS_CONFIG_USER_FILE" = "/data/config_bps.yaml"
)

#
# Load configurations for SNAP
#
sits_config()

#
# Load cube
#
cube <- sits_cube(
  source     = "BPS",
  collection = "SENTINEL-1-RTC",
  data_dir   = "/data/indonesia/cube/"
)

#
# Plot cube
#
plot(
  cube,
  tile = "48MYT",
  band    = "VV",
  palette = "Greys",
  scale = 0.6
)

sits_timeline(cube)

plot(cube, band = "VV", tile = "48MYT", dates = c("2022-05-01", "2022-04-07", "2022-01-01"))

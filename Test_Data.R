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
  "SITS_CONFIG_USER_FILE" = "/data/config_snap.yaml"
)

#
# Load configurations for SNAP
#
sits_config()

#
# Load cube
#
cube <- sits_cube(
  source     = "SNAP",
  collection = "SENTINEL-1-GRD",
  data_dir   = "/data/indonesia/cube/"
)

#
# Plot cube
#
plot(
  cube,
  band    = "VV",
  palette = "Greys"
)
sits_timeline(cube)

plot(cube, band = "VV", tile = "48MYT", dates = c("2022-01-01", "2022-01-13", "2022-01-25"))


data_dir <- "/data/indonesia/s2_cube"

s2_cube <- sits_cube(
  source     = "BPS",
  collection = "SENTINEL-1-RTC",
  data_dir   = data_dir
)

# Calculate NDVI index using bands B08 and B04
s2_cube_ndvi <- sits_apply(
  data = s2_cube,
  NDVI = (B8A - B04) / (B8A + B04),
  output_dir = "/data/fawcet/"
)

sits_band
s2_cube$file_info[[1]]$cloud_cover

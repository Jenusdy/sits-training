s2_cube <- sits_cube(
  source     = "MPC",
  collection = "SENTINEL-2-L2A",
  bands = c("B02", "B03", "B04", "B8A", "B11", "B12", "CLOUD"),
  tiles = "48MYT",
  start_date = "2022-03-01",
  end_date = "2022-05-01"
)

sits_timeline(s2_cube)

files <- s2_cube$file_info[[1]]$cloud_cover
min(files)

plot(s2_cube, red = "B11", green = "B8A", blue = "B02", date = "2022-04-14")
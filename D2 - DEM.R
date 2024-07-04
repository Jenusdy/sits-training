# DEM Cube
dem_cube <- sits_cube(
  source = "MPC",
  collection = "COP-DEM-GLO-30",
  tiles = "48MYT"
)

sits_timeline(dem_cube)

plot(dem_cube, band="ELEVATION", scale = 0.4, palette="Greens")
sits_view(dem_cube)

dem_cube_48MYT <- sits_regularize(
  cube = dem_cube,
  tiles = "48MYT",
  res = 100,
  output_dir = "/data/fawcet"
)


plot(dem_cube_48MYT, band="ELEVATION", scale = 0.4)

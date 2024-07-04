sits_list_collections()


# Create a data cube covering an area in Brazil
s2_50MRB_cube <- sits_cube(
  source = "AWS",
  collection = "SENTINEL-2-L2A",
  tiles = "50MRB",
  bands = c("B02", "B8A", "B11", "CLOUD"),
  start_date = "2018-01-01",
  end_date = "2018-12-31"
)

sits_timeline(s2_50MRB_cube)

plot(s2_23MMU_cube,
     red = "B11",
     blue = "B02",
     green = "B8A",
     data = "2018-07-14"
)

# =============

s1_cube <- sits_cube(
  source = "MPC",
  collection = "SENTINEL-1-GRD",
  tiles = "48MYT",
  start_date = "2022-01-01",
  end_date = "2023-12-31",
  orbit = "descending"
)

sits_bands(s1_cube)

sits_timeline(s1_cube)

plot(
  s1_cube, band = "VV", palette = "Greys"
)

s1_cube_grd_reg <- sits_regularize(
  cube = s1_cube,
  tiles = "48MYT",
  res = 200,
  period = "P14D",
  output_dir = "/data/fawcet"
)

plot(
  s1_cube_grd_reg, band = "VV", dates = c(
    "2022-01-23", 
    "2022-04-17", 
    "2023-09-03",
    "2023-12-10")
)
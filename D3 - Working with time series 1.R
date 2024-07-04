# Get data sampel using matagrosso Modis Q1
data("samples_matogrosso_mod13q1")
samples_matogrosso_mod13q1[1:4, ]

# View of the images of the data
sits_view(samples_cerrado_mod13q1)

# Get the summary of the data
summary(samples_matogrosso_mod13q1)

# Sample labels
samples_new_labels <- samples_matogrosso_mod13q1

# Show the current labels
sits_labels(samples_new_labels)

# Update the labels
sits_labels(samples_new_labels) <- c(
  "Cerrado", "Forest",
  "Pasture", "Croplands",
  "Croplands", "Croplands",
  "Croplands"
)

summary(samples_new_labels)

# Select NVDI Band from the Data
samples_ndvi <- sits_select(
  samples_matogrosso_mod13q1,
  bands = "NDVI"
)


# Select only samples with Cerrado label
samples_cerrado <- dplyr::filter(
  samples_ndvi,
  label == "Cerrado"
)

# Plot the first 12 samples
plot(samples_cerrado[1:12, ])
plot(samples_cerrado)

sits_view(samples_matogrosso_mod13q1)

# Estimate the patterns for each class and plot them
samples_matogrosso_mod13q1 |> 
  sits_patterns() |>
  plot()


# Quantitave estimate of validation
valid <- sits_kfold_validate(
  samples = samples_matogrosso_mod13q1,
  folds = 5,
  ml_method = sits_rfor(),
)

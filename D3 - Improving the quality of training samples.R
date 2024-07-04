library(sits)
library(sitsdata)
# Take only the NDVI and EVI bands
samples_cerrado_mod13q1_2bands <- sits_select(
  data = samples_cerrado_mod13q1,
  bands = c("NDVI", "EVI")
)

# Show the summary of the samples
summary(samples_cerrado_mod13q1_2bands)

sits_view(samples_cerrado_mod13q1_2bands)

rfor_validate <- sits_kfold_validate(
  samples = samples_cerrado_mod13q1_2bands,
  folds = 5,
  ml_method = sits_xgboost(),
  multicores = 5
)

rfor_validate

library('sits')
# Clustering time series using SOM
som_cluster <- sits_som_map(
  samples_cerrado_mod13q1_2bands,
  grid_xdim = 15,
  grid_ydim = 15,
  alpha = 1.0,
  distance = "dtw",
  rlen = 20,
  mode = "pbatch"
)

# Plot the SOM map
plot(som_cluster)

# Produce a tibble with a summary of the mixed labels
som_eval <- sits_som_evaluate_cluster(som_cluster)
# Show the result
som_eval

new_samples <- sits_som_clean_samples(
  som_map = som_cluster,
  prior_threshold = 0.6,
  posterior_threshold = 0.6,
  keep = c("clean", "analyze")
)
# Print the new sample distribution
summary(new_samples)

# Clustering time series using SOM
som_cluster_new <- sits_som_map(
  new_samples,
  grid_xdim = 15,
  grid_ydim = 15,
  alpha = 1.0,
  distance = "dtw",
  mode = "pbatch"
)

# Plot the SOM map
plot(som_cluster_new)

# Produce a tibble with a summary of the mixed labels
som_eval_new <- sits_som_evaluate_cluster(som_cluster_new)
# Show the result
plot(som_eval_new)


# ======== DTW
library(sits)
library(sitsdata)
# Take only the NDVI and EVI bands
samples_cerrado_mod13q1_2bands <- sits_select(
  data = samples_cerrado_mod13q1,
  bands = c("NDVI", "EVI")
)

# Show the summary of the samples
summary(samples_cerrado_mod13q1_2bands)

clusters <- sits_cluster_dendro(
  samples = cerrado_2classes,
  bands = c("NDVI", "EVI"),
  dist_method = "dtw_basic",
  linkage = "ward.D2"
)

sits_cluster_frequency(clusters)

# Remove cluster 3 from the samples
clusters_new <- dplyr::filter(clusters, cluster != 3)
# Clear clusters, leaving only the majority label
clean <- sits_cluster_clean(clusters_new)
# Show clusters samples frequency
sits_cluster_frequency(clean)

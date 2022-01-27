library(magmavizR)
library(dplyr)

# sample cars data
sample_data <- dplyr::tibble(
    'brand' = c("toyota", "hyundai", "volkswagen",
                "toyota", "hyundai", "volkswagen",
                "toyota", "hyundai", "volkswagen"),
    'year' = c(2017, 2017, 2017,
               2016, 2016, 2016,
               2015, 2015, 2015),
    'no_of_cars' = c(10466051, 7218391, 10382334,
                     10213486, 7889538, 10126281,
                     10083831, 7988479, 9872424)
)

scatter_default <- scatterplot(sample_data, year, no_of_cars)
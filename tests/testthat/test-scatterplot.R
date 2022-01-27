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

scatter_basic <- scatterplot(sample_data, year, no_of_cars)


test_that('Scatterplot should use geom_point and map x to x-axis, and y to y-axis.', {
    expect_true("GeomPoint" %in% c(class(scatter_basic$layers[[1]]$geom)))
    expect_true("year"  == rlang::get_expr(scatter_basic$mapping$x))
    expect_true("no_of_cars" == rlang::get_expr(scatter_basic$mapping$y))
})
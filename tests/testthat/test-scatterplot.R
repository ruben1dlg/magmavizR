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

# basic scatterplot with df, x and y axis
scatter_basic <- scatterplot(sample_data, year, no_of_cars)

# test_that for basic scatterplot - expected inputs
test_that('Scatterplot (basic) should use geom_point and map x to x-axis, and y to y-axis.', {
    expect_true("GeomPoint" %in% c(class(scatter_basic$layers[[1]]$geom)))
    expect_true("year"  == rlang::get_expr(scatter_basic$mapping$x))
    expect_true("no_of_cars" == rlang::get_expr(scatter_basic$mapping$y))
})

# test_that for basic scatterplot - default not expected inputs
test_that('Scatterplot (basic) must have default values for all parameters except df, x, and y.', {
    expect_null(rlang::get_expr(scatter_basic$mapping$c))
    expect_true(0.5 == rlang::get_expr(scatter_basic$layers[[1]]$aes_params$alpha))
    expect_true(3 == rlang::get_expr(scatter_basic$layers[[1]]$aes_params$size))
})

# advanced scatterplot with all parameters
scatter_advanced <- scatterplot(sample_data, year, no_of_cars, brand,
                                "Total cars produced from 2015 to 2017 by Car brands",
                                0.6, 4, "", "Total Cars", "Car Brand", FALSE, FALSE, TRUE)

# test_that for advanced scatterplot - expected inputs
test_that('Scatterplot (basic) should use geom_point and map x to x-axis, and y to y-axis.', {
    expect_true("GeomPoint" %in% c(class(scatter_advanced$layers[[1]]$geom)))
    expect_true("year"  == rlang::get_expr(scatter_advanced$mapping$x))
    expect_true("no_of_cars" == rlang::get_expr(scatter_advanced$mapping$y))
    expect_true("brand" == rlang::get_expr(scatter_advanced$mapping$colour))
    expect_true("brand" == rlang::get_expr(scatter_advanced$mapping$shape))
    expect_true("Total cars produced from 2015 to 2017 by Car brands" == rlang::get_expr(scatter_advanced$labels$title))
    expect_true("Year" == rlang::get_expr(scatter_advanced$labels$x))
    expect_true("Total Cars" == rlang::get_expr(scatter_advanced$labels$y))
    expect_true("Car Brand" == rlang::get_expr(scatter_advanced$labels$colour))
    expect_true("Car Brand" == rlang::get_expr(scatter_advanced$labels$shape))
    expect_true(0.6 == rlang::get_expr(scatter_advanced$layers[[1]]$aes_params$alpha))
    expect_true(4 == rlang::get_expr(scatter_advanced$layers[[1]]$aes_params$size))
})

# test_that to check if expected errors are being raised
test_that('The check for inputs df, x, or y is failing as they are quoted.', {
    expect_error(scatterplot("sample_data", year, no_of_cars), "Data assigned to 'df' must be a dataframe.")
    expect_error(scatterplot(sample_data, "year", no_of_cars), "Column name assigned to 'x' must not be in quotes.")
    expect_error(scatterplot(sample_data, year, "no_of_cars"), "Column name assigned to 'y' must not be in quotes.")
})
  
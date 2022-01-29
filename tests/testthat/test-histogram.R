library(magmavizR)

# check that erroneous inputs are captured 
#   and useful errors are printed
test_that("The check for inputs df, x, y is failing", {
  expect_error(histogram("df", mpg, "..count.."), "Data assigned to 'df' must be a dataframe.")
  expect_error(histogram(mtcars, "mpg", count), "Column name assigned to 'x' must not be in quotes.")
  expect_error(histogram(mtcars, mpk, count), "Column assigned to 'x' is not found in dataframe.")
  expect_error(histogram(iris, Species, '..density..'), "Column assigned to 'x' is not numeric.")
  expect_error(histogram(iris, Sepal.Length, ..density..), "The aggregation function assigned to 'y' must be in quotes.")
})


# an example plot for testing
plt1 <- histogram(mtcars, mpg, '..count..')

# test_that for the expected inputs
test_that('Histogram should use geom_histogram and map x to x-axis, and y to y-axis.', {
  expect_true("GeomBar" %in% c(class(plt1$layers[[1]]$geom)))
  expect_true("mpg"  == rlang::get_expr(plt1$mapping$x))
  expect_true("..count.." == rlang::get_expr(plt1$mapping$y))
  expect_true("..count.." == rlang::get_expr(plt1$mapping$fill))
})
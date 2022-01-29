# check that erroneous inputs are captured 
#   and useful errors are printed

test_that("The check for input type for x is failing",{
  expect_error(boxplot(df, "origin", miles_per_gallon),
               "x, the column name for x, must be unquoted")
})
plt1 <- histogram(mtcars, mpg, '..count..')

library(magmavizR)


x <- c(18.0, 15.0, 18.0, 16.0, 17.0, 15.0, 14.0, 14.0, 14.0, 15.0)
y <- c("USA",
       "Europe",
       "Europe",
       "Europe",
       "Japan",
       "Japan",
       "Japan",
       "USA",
       "USA",
       "Europe")

df <- tibble('miles_per_gallon' = x,
             'origin' = y)

plot <- boxplot(df,miles_per_gallon,origin,facet=TRUE)


test_that("The check for input type for x is failing",{
    expect_error(boxplot(df,"miles_per_gallon",origin),
                 "x, the column name for x, must be unquoted")
})


test_that("The check for input type for y is failing",{
    expect_error(boxplot(df,miles_per_gallon,"origin",
                    "y, the column name of y, must be unquoted"))
})


test_that("The check for input type for df is failing",{
    expect_error(boxplot(c(1,2),miles_per_gallon,origin,
                         "y, the column name of y, must be unquoted"))
})



test_that("The check for column name for x is failing",{
    expect_error(boxplot(df,miles_per_gallo,origin),
    'x column name not found')
})


test_that("The check for column name for y is failing",{
    expect_error(boxplot(df,miles_per_gallon,origi),
                 'y column name not found')

})






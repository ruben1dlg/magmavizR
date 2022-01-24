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
    expect_error(boxplot(df,"miles_per_gallon",origin))
})

test_that("The check for input type for x is failing",{
    expect_error(boxplot(df,miles_per_gallon,"origin"))
})

#check input types


#test_that('Plot should map x to x-axis and y to y-axis.', {
#    expect_true("miles_per_gallon"  == rlang::get_expr(plot2d$mapping$x))
#    expect_true("origin" == rlang::get_expr(plot2d$mapping$y))
#})


#expect_error()

#expect_is()

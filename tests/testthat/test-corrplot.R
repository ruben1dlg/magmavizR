library(palmerpenguins)
library(ggplot2)
library(GGally)

plot <- corrplot(penguins, print_corr = FALSE, title = "Correlation")

# Testing that an error is shown when df is not a dataframe
test_that("An error should be raised since df is not a dataframe", {
  expect_error(corrplot(c(1), print_corr = FALSE, title = "Correlation"))
})

# Testing that an error is shown when print_corr is not boolean
test_that("An error should be raised since print_corr is not boolean", {
    expect_error(corrplot(penguins, print_corr = 2, title = "Correlation"))
})

# Testing that an error is shown when title is not a string
test_that("An error should be raised since title is not a string", {
    expect_error(corrplot(penguins, print_corr = FALSE, title = 45))
})

# Testing that the title is correct
test_that("Title is not being shown correctly in the plot", {
    expect_equal(plot$labels$title,
                 "Correlation",
                 ignore_attr = TRUE)
})

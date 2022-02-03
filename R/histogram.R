#' Create a histogram with the magma color scheme
#'
#' @param df A dataframe containing the variables for plotting
#' @param x Column name of the numeric variable to be plotted on the x-axis
#' @param y The quoted aggregation function to be plotted on the y-axis
#' and to be used for the fill color.
#' The input needs to be in the form of ..name..,
#' where name can be values from the following list,
#' with explanations in the parenthesis:
#' count (number of points in bin),
#' density (density of points in bin, scaled to integrate to 1),
#' ncount (count, scaled to maximum of 1),
#' ndensity (density, scaled to maximum of 1),
#' width (widths of bins)
#'
#' @return A ggplot object.
#'
#' @export
#'
#' @examples
#' library(palmerpenguins)
#' penguins_data <- penguins
#' histogram(penguins, flipper_length_mm, "..count..")

histogram <- function(df, x, y) {


  aggregation_functions = c("..count..", "..density..",
                            "..ncount..", "..ndensity..",
                            "..width..")

  # check to ensure df is assigned a dataframe
  if (!is.data.frame(df)) {
    stop("Data assigned to 'df' must be a dataframe.")
  }

  # check to ensure x is not in quotes
  if (
    typeof(substitute(x)) !=
    typeof(as.list(quote(symbol))[[1]])
  ) {
    stop("Column name assigned to 'x' must not be in quotes.")
  }

  # check to ensure x is present in the df
  if (!rlang::as_name(ggplot2::vars({{ x }})[[1]]) %in% colnames(df)) {
    stop("Column assigned to 'x' is not found in dataframe.")
  }

  # check to ensure column x is numeric
  if (!is.numeric(dplyr::pull(df, {{x}}))) {
    stop("Column assigned to 'x' is not numeric.")
  }

  # check to ensure y is in quotes
  if (
    typeof(substitute(y)) == typeof(as.list(quote(symbol))[[1]])
  ) {
    stop("The aggregation function assigned to 'y' must be in quotes.")
  }

  # check to ensure y is in the correct format and has the supported value
  if (!is.element(y, aggregation_functions)) {
    stop(paste0("Value assigned to 'y' should be one of [",
                paste(sapply(aggregation_functions, paste, collapse = ""), collapse = " "),
               "].", sep = ' '))
  }

  y <- rlang::sym(y)

  plt <- ggplot2::ggplot(df,
                         ggplot2::aes(
                           x = {{x}},
                           y = !!y,
                           fill = {{y}}
                         )) +
    ggplot2::geom_histogram() +
    viridis::scale_fill_viridis("Legend", option = "magma")

  return(plt)
}


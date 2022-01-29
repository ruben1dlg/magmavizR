#' Create a histogram with the magma color scheme
#'
#' @param df A dataframe containing the variables for plotting
#' @param x Column name of the variable to be plotted on the x-axis
#' @param y The aggregation function to be plotted on the y-axis.
#'            The input needs to be in the form of `..name..`,
#'            where name can be values from the following list,
#'            with explanations in the parenthesis:
#'            [count (number of points in bin),
#'             density (density of points in bin, scaled to integrate to 1),
#'             ncount (count, scaled to maximum of 1),
#'             ndensity (density, scaled to maximum of 1),
#'             width (widths of bins)]
#' @return A ggplot object.
#' @export
#'
#' @examples
#' histogram(mtcars, vs, count)
#' histogram(mtcars, vs, ndensity)

histogram <- function(df, x, y) {
  
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
  if (!as.character(ggplot2::vars({{ x }})[[1]])[2] %in% colnames(df)) {
    stop("Column assigned to 'x' is not found in dataframe.")
  }
  
  # check to ensure y is not in quotes
  if (
    typeof(substitute(y)) !=
    typeof(as.list(quote(symbol))[[1]])
  ) {
    stop("The aggregation function assigned to 'y' must not be in quotes.")
  }
  
  # check to ensure y is in the correct format
  if () {
    stop("Column assigned to 'x' is not found in dataframe.")
  }
  
  plt <- ggplot2::ggplot(df,
                         ggplot2::aes(
                           x = {{x}},
                           y = {{y}}
                         )) +
    ggplot2::geom_histogram() +
    viridis::scale_fill_viridis(option = "magma")
  
  return(plt)
}


#' Create a histogram with the magma color scheme
#'
#' @param df A dataframe containing the variables for plotting
#' @param x Column name of the variable to be plotted on the x-axis
#' @param y An aggregation function in string version to be plotted on the y-axis.
#'            The supported aggregation operations are: ['average', 'count',
#'            'distinct', 'max', 'mean', 'median', 'min', 'missing', 'product',
#'            'q1', 'q3', 'ci0', 'ci1', 'stderr', 'stdev', 'stdevp', 'sum', 
#'            'valid', 'values', 'variance', 'variancep']
#' @return A ggplot object.
#' @export
#'
#' @examples
#' histogram(mtcars, vs, 'min(mpg)')
#' histogram(mtcars, vs, 'count()')
histogram <- function(df, x, y) {
}
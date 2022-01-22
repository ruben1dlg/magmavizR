#' Create a scatterplot using the magma color scheme
#'
#' @param df A dataframe to use for the scatterplot.
#' @param x Column-name of the numerical variable to be plotted on the x-axis
#' @param y Column-name of the numerical variable to be plotted on the y-axis
#' @param c Column-name of the categorical variable to color-code the data points
#'          Default value is blank for cases when there is no categorical column
#' @param t Title of the plot. Default value is blank. 
#'          If not provided, title will be computed based on x, y and/or c
#' @param o Opacity of the data points
#' @param s Size of the data points
#' @param xtitle Title of the x-axis. Default value is blank. 
#'               If not provided, title will be proper case of the x axis column
#' @param ytitle Title of the x-axis. Default value is blank. 
#'               If not provided, title will be proper case of the y axis column
#' @param ctitle Title of the x-axis. Default value is blank. 
#'               If not provided, title will be proper case of the color column
#' @param xzero Scale the x-axis to start from 0 by specifying True
#'              Default value is set to False
#' @param yzero Scale the x-axis to start from 0 by specifying True
#'              Default value is set to False
#' @param shapes Assign the color column to the shape attribute of the plot if True
#'               Default value is set to True
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' >>> scatterplot(iris, sepalLength, sepalWidth, species,
#'                 "Iris Sepal Length vs Sepal Width across Species",
#'                 1.0, 50, "Sepal Length", "Sepal Width", "", False, False, True)

scatterplot <- function(df, x, y, c="", t="", o=0.5, s=50, xtitle="", ytitle="",
                        ctitle="", xzero=False, yzero=False, shapes=True) {
}
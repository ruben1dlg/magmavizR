library(tidyverse)
library(ggplot2)
library(viridis)
library(stringr)
library(rlang)

#' Create a scatterplot using the magma color scheme
#'
#' @param df A dataframe to use for the scatterplot.
#' @param x Column-name of the numerical variable to be plotted on the x-axis
#' @param y Column-name of the numerical variable to be plotted on the y-axis
#' @param c Column-name of the categorical variable to color-code the data points
#'          Default value is blank for cases when there is no categorical column
#' @param t Title of the plot. Default value is blank.
#'          If not provided, title will be computed based on x, y and/or c
#' @param o Opacity of the data points. Number between 0.1 and 1.0 (inclusive)
#' @param s Size of the data points. Number between 1 and 5 (inclusive)
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

scatterplot <- function(df, x, y, c=NULL, t="", o=0.5, s=5, xtitle="", ytitle="", ctitle="") {

    base::missing(c)

    # check to ensure df is assigned a dataframe
    if (!is.data.frame(df) == TRUE) {
        stop("Data assigned to 'df' must be a dataframe.")
    }

    # check to ensure x is not in quotes
    if (
        typeof(substitute(x)) !=
        typeof(as.list(quote(symbol))[[1]])
        ) {
        stop("Column name assigned to 'x' must not be in quotes.")
    }

    # check to ensure y is not in quotes
    if (
        typeof(substitute(y)) !=
        typeof(as.list(quote(symbol))[[1]])
    ) {
        stop("Column name assigned to 'y' must not be in quotes.")
    }

    # check if column x is present in the df
    if (!as.character(ggplot2::vars({{ x }})[[1]])[2] %in% colnames(df)) {
        stop("Column assigned to 'x' not found in dataframe.")
    }

    # check if column y is present in the df
    if (!as.character(ggplot2::vars({{ y }})[[1]])[2] %in% colnames(df)) {
        stop("Column assigned to 'y' not found in dataframe.")
    }

    # check if column has been assigned to color c
    if (!is.null(substitute(c)) == TRUE) {
        # check to ensure c is not in quotes
        if (
            (typeof(rlang::get_expr(ggplot2::vars({{ c }})[[1]])) !=
             typeof(as.list(quote(symbol))[[1]]))
        ) {
            stop("Column name assigned to 'color' must not be in quotes.")
        }

        # check if column c is present in the df
        if (!as.character(ggplot2::vars({{ c }})[[1]])[2] %in% colnames(df)) {
            stop("Column assigned to 'color' not found in dataframe.")
        }
    }

    # check if title is a string
    if (!typeof(substitute(t)) == 'character') {
        stop("Title must be assigned in quotes as a string.")
    }

    if (o < 0.1 | o > 1.0) {
        stop("Opacity (alpha) must be between 0.1 and 1.0 (inclusive).")
    }

    if (s < 1 | s > 5) {
        stop("Size must be between 1 and 5 (inclusive).")
    }

    # check if x axis title is a string
    if (!typeof(substitute(xtitle)) == 'character') {
        stop("Title assigned to x-axis must be a string in quotes.")
    }

    # check if y axis title is a string
    if (!typeof(substitute(ytitle)) == 'character') {
        stop("Title assigned to y-axis must be a string in quotes.")
    }

    # check if color title is a string
    if (!typeof(substitute(ctitle)) == 'character') {
        stop("Title assigned to color legend must be a string in quotes.")
    }

    # renaming x axis if custom x axis title not assigned
    if(xtitle == "") {
        xtitle <- str_to_sentence(str_replace_all(as.character(ggplot2::vars({{ x }})[[1]])[2], "[_!.]", " "))
    }

    # renaming y axis if custom x axis title not assigned
    if(ytitle == "") {
        ytitle <- str_to_sentence(str_replace_all(as.character(ggplot2::vars({{ y }})[[1]])[2], "[_!.]", " "))
    }

    # renaming x axis if custom x axis title not assigned
    if(ctitle == "") {
        ctitle <- str_to_sentence(str_replace_all(as.character(ggplot2::vars({{ c }})[[1]])[2], "[_!.]", " "))
    }

    # defining title based on x, y and/or c names if no title assigned
    if(t == "") {
        # if c is NULL (default) keep only x and y in title if title is blank
        if (is.null(substitute(c)) == TRUE) {
            t <- paste(xtitle, "vs", ytitle, sep = " ")
        } else {
        # add color variable to title along with x and y if title is blank
            t <- paste(xtitle, "vs", ytitle, "by", ctitle, sep = " ")
        }
    }

    splot <- ggplot2::ggplot(df,
        ggplot2::aes(
            x = {{ x }},
            y = {{ y }},
            color = {{ c }}
            )
        ) +
        ggplot2::geom_point(
            alpha = o,
            size = s
        ) +
        scale_colour_viridis_d(
            option = "magma"
        ) +
        labs(
            title = t,
            x = xtitle,
            y = ytitle,
            color = ctitle
        )

return(splot)
}

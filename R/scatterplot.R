library(tidyverse)
library(ggplot2)
library(viridis)
library(stringr)
library(rlang)

#' Create a scatterplot using the magma color scheme
#'
#' @param df A dataframe to use for the scatterplot.
#' @param x Column-name of the numerical or categorical variable to be plotted on the x-axis
#' @param y Column-name of the numerical or categorical variable to be plotted on the y-axis
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
#' @param xzero Scale the x-axis to start from 0 by specifying TRUE
#'              Default value is set to FALSE
#' @param yzero Scale the x-axis to start from 0 by specifying TRUE
#'              Default value is set to FALSE
#' @param shapes Assign the color column to the shape attribute of the plot if TRUE
#'               Default value is set to FALSE
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' > penguins_data <- palmerpenguins::penguins
#' > scatterplot(penguins_data, bill_length_mm, flipper_length_mm, species,
#'               "Bill and Flipper length clusters by Species",
#'               0.5, 2.5, "Bill length (mm)", "Flipper length (mm)", "", FALSE, FALSE, TRUE)

scatterplot <- function(df, x, y, c=NULL, t="", o=0.5, s=3, xtitle="", ytitle="", ctitle="", xzero=FALSE, yzero=FALSE, shapes=FALSE) {

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
    if (!as_name(ggplot2::vars({{ x }})[[1]]) %in% colnames(df)) {
        stop("Column assigned to 'x' not found in dataframe.")
    }

    # check if column y is present in the df
    if (!as_name(ggplot2::vars({{ y }})[[1]]) %in% colnames(df)) {
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
        if (!as_name(ggplot2::vars({{ c }})[[1]]) %in% colnames(df)) {
            stop("Column assigned to 'color' not found in dataframe.")
        }

        # check if column assigned to c is either of type character or factor
        if (!class(df[[as_name(ggplot2::vars({{ c }})[[1]])]]) == "character" &
            !class(df[[as_name(ggplot2::vars({{ c }})[[1]])]]) == "factor") {
            stop("Column assigned to 'color' must be of type 'character' or 'factor'.")
        }
    }

    # check if title is a string
    if (!typeof(substitute(t)) == 'character') {
        stop("Title must be assigned in quotes as a string.")
    }

    # check range of opacity input
    if (o < 0.1 | o > 1.0) {
        stop("Opacity (alpha) must be between 0.1 and 1.0 (inclusive).")
    }

    # check range of size input
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
    if (xtitle == "") {
        xtitle <- stringr::str_to_sentence(stringr::str_replace_all(as_name(ggplot2::vars({{ x }})[[1]]), "[_!.]", " "))
    }

    # renaming y axis if custom x axis title not assigned
    if (ytitle == "") {
        ytitle <- stringr::str_to_sentence(stringr::str_replace_all(as_name(ggplot2::vars({{ y }})[[1]]), "[_!.]", " "))
    }

    # renaming x axis if custom x axis title not assigned
    if (ctitle == "") {
        ctitle <- stringr::str_to_sentence(stringr::str_replace_all(as_name(ggplot2::vars({{ c }})[[1]]), "[_!.]", " "))
    }

    # check if xzero is logical or not
    if (!typeof(substitute(xzero)) == 'logical') {
        print(typeof(substitute(xzero)))
    }

    # check if yzero is logical or not
    if (!typeof(substitute(yzero)) == 'logical') {
        print(typeof(substitute(yzero)))
    }

    # check if shapes is logical or not
    if (!typeof(substitute(shapes)) == 'logical') {
        print(typeof(substitute(shapes)))
    }

    # defining title based on x, y and/or c names if no title assigned
    if (t == "") {
        # if c is NULL (default) keep only x and y in title if title is blank
        if (is.null(substitute(c)) == TRUE) {
            t <- paste(xtitle, "vs", ytitle, sep = " ")
        } else {
        # add color variable to title along with x and y if title is blank
            t <- paste(xtitle, "vs", ytitle, "by", ctitle, sep = " ")
        }
    }

    # scatterplot
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
        ggplot2::scale_colour_viridis_d(
            option = "magma"
        ) +
        ggplot2::labs(
            title = t,
            x = xtitle,
            y = ytitle,
            color = ctitle
        )

    # assign color column to shape if shapes is TRUE
    if (!is.null(substitute(c)) == TRUE & shapes == TRUE) {
        splot <- splot + ggplot2::aes(shape = {{ c }}) +
                         ggplot2::labs(shape = ctitle)
    }

    # set x-axis to begin from zero
    if (xzero == TRUE) {
        splot <- splot + ggplot2::xlim(0, NA)
    }

    # set y-axis to begin from zero
    if (yzero == TRUE) {
        splot <- splot + ggplot2::ylim(0, NA)
    }

return(splot)
}

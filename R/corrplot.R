#' Generates a correlation plot for the numeric variables in a dataframe,
#' and prints the correlation values.
#'
#' @param df The dataframe containing the data to be plotted.
#' @param print_corr Whether or not to print the correlation values between variables
#' @param title Title of the plot
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' corrplot(iris, print_corr = FALSE, title = "Correlation chart")
#library(ggplot2)
corrplot <- function(df, print_corr=FALSE, title="Correlation Plot") {
    # Checking if df is a dataframe
    if (!is.data.frame(df)) {
        stop("Input needs to be a dataframe.")
    }

    # Checking if print_corr is boolean
    if (!is.logical(print_corr)) {
        stop("print_corr needs to be boolean.")
    }

    # Checking if title is string
    if (!is.character(title)) {
        stop("Title needs to be a string")
    }

    # Create the plot
    if(print_corr==TRUE) {
        GGally::ggcorr(df, label = TRUE, label_size = 2) +
            ggplot2::ggtitle(title) +
            ggplot2::scale_fill_viridis_c(option = "magma") +
            ggplot2::theme(plot.title = ggplot2::element_text(size = 20, face = "bold"),
                  axis.text = ggplot2::element_text(size=10),
                  axis.title = ggplot2::element_text(size = 10))
    } else {
        GGally::ggcorr(df) +
            ggplot2::ggtitle(title) +
            ggplot2::scale_fill_viridis_c(option = "magma") +
            ggplot2::theme(plot.title = ggplot2::element_text(size = 20, face = "bold"),
                  axis.text = ggplot2::element_text(size=20),
                  axis.title = ggplot2::element_text(size = 20))
    }
}

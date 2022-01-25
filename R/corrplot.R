#' Generates a correlation plot for the numeric variables in a dataframe,
#' and prints the correlation values.
#'
#' @param df The dataframe containing the data to be plotted.
#' @param print_corr Whether or not to print the correlation values between variables
#'
#' @return A ggplot object.
#' @export
#'
#' @examples
#' corrplot(df, print_corr = FALSE)
library(ggplot2)
corrplot <- function(df, print_corr=FALSE) {
    if(print_corr==TRUE) {
        GGally::ggcorr(df, label = TRUE, label_size = 2) +
            ggtitle("Correlation plot") +
            theme(plot.title = element_text(size = 20, face = "bold"),
                  axis.text = element_text(size=10),
                  axis.title = element_text(size = 10))
    } else {
        GGally::ggcorr(df) +
            ggtitle("Correlation plot") +
            theme(plot.title = element_text(size = 20, face = "bold"),
                  axis.text = element_text(size=10),
                  axis.title = element_text(size = 10))
    }
}

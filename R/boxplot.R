#' Plot a boxplot with the magma color scheme and an option to facet.
#'
#' @param df Dataframe containing the variables for plotting
#' @param x Column name of the numerical variable to view the distribution of
#' @param y Column name containing the categorical variables to assign boxes to
#' @param facet Determines whether separate graphs will be created for each category
#'
#' @return a ggplot object
#'
#'
#'
#' @export
#'
#' @examples
#' function(df, Length, Species, TRUE)
#'
boxplot <- function(df, x, y, facet = FALSE){

library(viridis)
library(stringr)
library(rlang)
library(ggplot2)

### input tests
#check type of x
if ( typeof(rlang::get_expr(ggplot2::vars({{ x }})[[1]])) !=
     typeof(as.list(quote(symbol))[[1]])){
    stop("x, the column name for x, must be unquoted")
}

#check type of y
if ( typeof(rlang::get_expr(ggplot2::vars({{ y }})[[1]])) !=
         typeof(as.list(quote(symbol))[[1]])){
        stop("y, the column name of y, must be unquoted")
}

#check type of df
if ( typeof(df) != 'list' ){
        stop("df must be a dataframe")
}

#check if x exists in df
if ( !(as.character(as.list(
    rlang::get_expr(ggplot2::vars({{ x }})[[1]])
    )))
    %in%
    colnames({{ df }})
){
    stop('x column name not found')
}

#check if y exists in df
if ( !(as.character(as.list(
        rlang::get_expr(ggplot2::vars({{ y }})[[1]])
    )))
    %in%
    colnames({{ df }})
){
    stop('y column name not found')
}




x_title <- str_replace(as.character
                           (as.list(
                               rlang::get_expr(ggplot2::vars({{ x }})[[1]]))),
                           "[_!.]",
                           " ")

y_title <- stringr::str_replace(as.character
                       (as.list(
                           rlang::get_expr(ggplot2::vars({{ y }})[[1]]))),
                           "[_!.]",
                           " ")

plot <- ggplot2::ggplot(df) +
            geom_boxplot(aes(
                x={{ x }},
                y={{ y }},
                fill= {{ x }}),
            ) +
    viridis::scale_fill_viridis(discrete=TRUE, option="magma") +
    labs(x = x_title,
         y = y_title
         )

        if (facet == TRUE){
            return(plot  +
                ggplot2::facet_wrap(ggplot2::vars({{ x }}))
            )
        } else {
            return(plot)
        }
return(plot)
}



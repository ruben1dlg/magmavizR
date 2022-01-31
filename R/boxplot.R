#' Plot a boxplot with the magma color scheme and an option to facet.
#'
#' @param df Dataframe containing the variables for plotting
#' @param x Column name of the categorical variable to view the distribution of
#' @param y Column name containing the numerical variables to assign boxes to
#' @param facet Determines whether separate graphs will be created for each category
#'
#' @return a ggplot object

#' @export
#'
#' @examples
#' boxplot(iris, Species, Sepal.Length, facet = TRUE)
#'
boxplot <- function(df, x, y, facet = FALSE){

#library(viridis)
#library(stringr)
#library(rlang)
#library(ggplot2)
#library(dplyr)

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
if ( (class(df)[1] != "data.frame") &
         (class(df)[1] != "tbl_df")
    ){
        stop("df must be a dataframe or tibble")
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

#check the type for x
if( !(
        is.character((df |> dplyr::select({{ x }}))[[1]]) |
        is.factor((df |> dplyr::select({{ x }}))[[1]]))
    ){
        stop('x needs to have distinct categories')
}

#check the type for y
if(!(
        is.numeric((df |> dplyr::select({{ y }}))[[1]])
    )){
        stop('y needs to be numeric')
}



x_title <- stringr::str_replace(as.character
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
        ggplot2::geom_boxplot(ggplot2::aes(
            x={{ x }},
            y={{ y }},
            fill= {{ x }}),
        ) +
        viridis::scale_fill_viridis(discrete=TRUE, option="magma") +
        ggplot2::labs(x = x_title,
             y = y_title
        ) +
        ggplot2::theme(legend.position = "none")

if (facet == TRUE){
        return(plot  +
                   ggplot2::facet_wrap(ggplot2::vars({{ x }}))
        )
    } else {
        return(plot)
    }
    return(plot)
}

#' Plot a boxplot with the magma color scheme and an option to facet.
#'
#' @param df Dataframe containing the variables for plotting
#' @param x Column name of the numerical variable to view the distribution of
#' @param y Column name containing the categorical variables to assign boxes to
#' @param facet Determines whether separate graphs will be created for each category
#'
#' @return a ggplot object
#' @export
#'
#' @examples
#' function(df, Length, Species, TRUE)
#'
boxplot <- function(df, x, y, facet = FALSE){


#check type of x
if ( typeof(rlang::get_expr(vars({{ x }})[[1]])) !=
     typeof(as.list(quote(symbol))[[1]])){
    stop("x, the column name for x, must be unquoted")
}

#check type of y
if ( typeof(rlang::get_expr(vars({{ y }})[[1]])) !=
         typeof(as.list(quote(symbol))[[1]])){
        stop("y, the column name of y, must be unquoted")
}

#check type of df
if ( typeof(df) != 'list' ){
        stop("df must be a dataframe")
}

#check if x exists in df
if ( !(as.character(as.list(
    rlang::get_expr(vars({{ x }})[[1]])
    )))
    %in%
    colnames({{ df }})
){
    stop('x column name not found')
}

#check if y exists in df
if ( !(as.character(as.list(
        rlang::get_expr(vars({{ y }})[[1]])
    )))
    %in%
    colnames({{ df }})
){
    stop('y column name not found')
}


library(viridis)

plot <- ggplot(df) +
            geom_boxplot(aes(
                x={{ x }},
                y={{ y }},
                fill= {{ x }}),
            ) +
    scale_fill_viridis(discrete=TRUE, option="magma") +
    labs(x= as.character(as.list(rlang::get_expr(vars({{ x }})[[1]]))),
         y= as.character(as.list(rlang::get_expr(vars({{ y }})[[1]])))
         )

        if (facet == TRUE){
            return(plot  +
                facet_wrap(vars({{ x }}))
            )
        } else {
            return(plot)
        }
return(plot)
}



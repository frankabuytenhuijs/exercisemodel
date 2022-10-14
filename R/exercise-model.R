


#' Run the exercise model
#'
#' Run the ODE model
#' run_exercise_model() defaults are s=0.2,k=2.5,n=1,i=1.5,j=1.5, a=c(1,5,7)
#' or choose own values with
#' run_exercise_model(s=0.3,k=2,n=1.2,i=1,j=1.7, a=c(1,3,5,7,9))
#' @param s the scale of the positive impact of activity. Decreasing s makes this impact
#'  slower decaying.
#' @param n the dampening of the positive effect of activity. 
#' @param k impact of activity on positive effect
#' @param a numeric vector. Beginning of activities (all take time 1)
#' @param i numeric. final scaling factor of negative effect
#' @param j numeric. final scaling factor of positive effect 
#' @param debug show some debugging output.
#' @return a data frame containing six variables. The first column contains the time, and 
#' the final columm contains the final TRI.
#' @export
#' @examples
#' # Run model with default parameters
#' x <- run_exercise_model()
#' plot( TRI ~ time, x, type='l' )
run_exercise_model <- function(s=0.2,k=2.5,n=1,i=1.5,j=1.5, a=c(1,5,7), debug=FALSE){ 
  init <- c( 0.0, 1.0, 1.0, 1.0, 1.0 )
  #s, k, n, i, j, a
  parameters <- list(s=s, k=k, n=n, i=i, j=j, a=a)
  if( debug ){
	  print(sprintf("running the exercise model with parameters: s = %s, k = %s, n = %s, i = %s, j = %s, a = %s", 
                s, k, n, i, j, paste(a, collapse=",")))
  }
  s <- .get_simulation(init, parameters)
  return(s)
}

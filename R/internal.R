
# Activity function
#
# returns 1 for normal activity and 2 for exercise 
# @param t, timestep, activity_times, list of numbers indication exercise times
# A(0.02, c(1,5,7))
# used in the function exercisemodel()
.A <- function(t, activity_times) {
  activity <- 1
  if( t < activity_times[1]){
    return (activity)
  }
  for(i in activity_times){
    if( t > i && t < i + 1){
      activity <- 2
    }
  }
  return(activity)
}

# The ODE model
#
# Exercise model 
# given as a function to the rk4 solver 
# used in the function get_simulation()
# @param init initial values for the parameters, parameters 
.exercisemodel <- function( t, x, parms ){
  time <- x[1]
  Dneg <- x[2]
  Dpos <- x[3]
  Tneg <- x[4]
  Tpos <- x[5]
  dt <- 1
  
  dDneg <- .A(t, parms[['a']] ) - Dneg
  dDpos <- parms[['s']] * (1 + parms[['k']]*(.A(t, parms[['a']])-1)/(Dneg**parms[['n']])) - parms[['s']] * Dpos
  dTneg <- - parms[['i']] * Tneg * Dneg + parms[['i']] #  negative part of TRI impact
  dTpos <- - parms[['j']] * Tpos * Dpos + parms[['j']] #  positive part of TRI impact

  dxdt <- c(dt, dDneg, dDpos, dTneg, dTpos)
  return ( list(dxdt) )
}

# Run the simulation with given parameters
#
# Get the values per time step 
# @param init initial values for the parameters, parameters 
# get_simulation(c( 0.0, 1.0, 1.0, 1.0, 1.0 ), c(0.2, 2.5, 1, 1.5, 1.5, 1,5,7)
# used in the function run_exercise_model
.get_simulation <- function( init, parameters ){
  s <- deSolve::rk4(init, seq(0, 12, by=0.01), .exercisemodel, parameters)
  s_tri <- list()
  df_all <- data.frame()
  for( i in 1:nrow(s)){
    tri <-  3*(s[i,length(s[i,])-1] - s[i,length(s[i,])]) + 1
    s[i,length(s[i,])] <- abs(s[i,length(s[i,])] - 1 ) + 1
    s_tri <- append(s[i,2:6], c(tri))
    df_all <- rbind(df_all, s_tri)
  }
  colnames(df_all) <- c("time", "damage", "healing", "damageTRI", "healingTRI", "TRI")
  return(df_all)
}

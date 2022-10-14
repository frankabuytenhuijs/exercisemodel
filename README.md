# Exercisemodel
R package for the TRI ODE model


# Installation 
The package can be installed from GitHub (note: this requires the devtools package):

```
devtools::install_github( "frankabuytenhuijs/exercisemodel" )
```

Then the package can be loaded as usual:

```
library("exercisemodel")
```

# Usage

The model can be run using the function 

```
run_exercise_model()
```

This will run the model with the default parameters (s = 0.2, k = 2.5, n = 1, i = 1.5, j = 1.5, a = 1,5,7). 

The default parameters can be changed by specifying them in the function call. 

```
run_exercise_model(s=0.5, k=1, n=4, a=c(1,2,5,9))
```

This function returns a data frame containing six variables. The first column contains the time, and the final columm contains the final TRI.

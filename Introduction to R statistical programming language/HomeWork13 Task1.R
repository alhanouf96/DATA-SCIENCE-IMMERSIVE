library(lpSolve)

#objective function 
f.obj <- c(13,23,30) 

#constraints 
f.con <- matrix(c(5,15,10,            
                  4,4,4,
                  35,20,15,
                  5,10,20),nrow=4, byrow = TRUE)  # last line is hours of labor   

f.dir <- c("<=",
           "<=",
           "<=",
           "<=")

# Decision variables controllable variables that influence the performance of the system
f.rhs <- c(600,     
           300,    
           1700,
           200) #hours the employees per month

sol <- lp("max", f.obj, f.con, f.dir, f.rhs, compute.sens = TRUE)

# Final value (z) 
sol$objval

# Variables final values
sol$solution 

# Dual Values (first dual of the constraints and then dual of the variables)
# Duals of the constraints and variables are mixed
sol$duals

#Solution:

#Maximize profit: 520
#The optimal amount of each beer that must be produced: 40 for Hopatronic, 0 for All American and 0 for Dantzig


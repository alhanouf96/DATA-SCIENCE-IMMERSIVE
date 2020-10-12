library(expm)
library(shape)
library(diagram)

#Transition matrix
T <- matrix(c(0.95,0.05,0,0
              ,0.75,0.2,0.05,0,
              0.2,0.2,0.8,0.05,             
              0.2,0.4,0.2,0.05), nrow=4, byrow=TRUE)
colnames(T)= c(0,1,2,3)
rownames(T)= c(0,1,2,3)

T

a<-c(0.2,0.2,0.8,0.05)  #change probability of having 2 kegs
round(a %*% T,3)

#        0    1    2     3
#[1,] 0.51 0.23 0.66 0.043       #probability of 60% or higher of having 2 kegs on hand


#Diagram
plotmat(T,
        lwd = 1, box.lwd = 2, 
        cex.txt = 0.8, 
        box.size = 0.1, 
        box.type = 'circle', 
        box.prop = 0.5,
        box.col = 'light yellow',
        arr.length=.1,
        arr.width=.1,
        self.cex = .4,
        self.shifty = -.01,
        self.shiftx = .13,
        main = '')

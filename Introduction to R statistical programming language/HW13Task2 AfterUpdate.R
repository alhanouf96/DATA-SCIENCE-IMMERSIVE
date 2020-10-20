library(expm)
library(shape)
library(diagram)

#Transition matrix

T <- matrix(c(0,0,0.6,0.4,
              0,0,0.6,0.4,
              0,0,0.6,0.4,
              0,0,0.6,0.4 ), nrow=4, byrow=TRUE)

colnames(T)= c(0,1,2,3)
rownames(T)= c(0,1,2,3)

T%^%20


#steady-state values

# 0 1   2   3
# 0 0 0 0.6 0.4
# 1 0 0 0.6 0.4
# 2 0 0 0.6 0.4
# 3 0 0 0.6 0.4

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

winnings<- vector("integer",10000)
Acc_winnings<- vector("integer",10000)

numplayers <-5
for (i in 1:length(winnings)){
  onehand<- sample(c("D","P","T"), numplayers, prob = c(0.493,0.42222,0.0848), replace =TRUE )
  winnings[i]<- length(onehand[onehand=="P"])*-1 + length(onehand[onehand=="D"])
   
  if(i != 1){
    Acc_winnings[i]<- Acc_winnings[i-1]+ winnings[i]
  } else{
    Acc_winnings[i]<- winnings[i]
  }
  
}

hist(winnings,
     main="visualisation the Winnings",
     xlab="Percent of winning a dollars is higher VS the losing it",
     col="darkmagenta",
     freq=FALSE
)

qqnorm(winnings,
       ylab = "More players = more chance of winning",
       main="visualisation the Winnings",
       col="darkmagenta",
       pch=19, 
       cex=.6)

#imaginary game Simulation
#player ‘Jack’, rolls an imaginary dice to get an outcome of 1 to 100. 
#If Jack rolls anything from 1–51, the casino wins, 
#but if the number rolled is from 52–100, Jack wins.

#1 Create function for simulating die roll 
#The die can take values from 1 to 100. 


rolldice<- function(){
  
  dice<-sample(1:100, size= 1, replace = TRUE)
  if(dice<=51){
    return(TRUE)
  }
  else{
    return(FALSE) }
}

#2 Define a function for the play which takes 3 arguments :
#1. total_funds = total money in hand the player is starting with
#2. wager_amount = the betting amount each time the player plays
#3. total_plays = the number of times the player bets on this game

play<- function(total_funds, wager_amount, total_plays){
  
  Play_num<- vector()
  Funds<- vector()
 
  play<- 1
  while(play<total_plays){
    if(rolldice()){
      #Add the money to our funds
      total_funds<-total_funds+wager_amount
      #Append the play number
      Play_num<-c(Play_num,play)
      #Append the new fund amount
      Funds<-c(Funds,total_funds)
    }
    else{
      #Add the money to our funds
      total_funds<-total_funds-wager_amount
      #Append the play number
      Play_num<-c(Play_num,play)
      #Append the new fund amount
      Funds<-c(Funds,total_funds)
    }
    play<-play+1
  }
  
  #Line plot of funds over time
       plot(Play_num,Funds,
       type= "l",
       ylab="Casino Money in $",
       xlab="Number of bets",
       col="darkmagenta"
       )
  
  Final_funds<-c(Final_funds,Funds[-1])
  return(Final_funds)
  
}

#3 Call the function to simulate the plays and calculate the remaining
#funds of the Casino after all the bets

x<-1
Final_funds<- vector()

while (x<=100){
  ending_fund <- play(10000,100,50)
x<-x+1

}

ends<- sum(ending_fund)/length(ending_fund)

print(paste0("The Casino starts the game with $10,000 and ends with $",ends))



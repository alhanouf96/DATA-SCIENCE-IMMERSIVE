library(datasets)  
library(caTools) 
library(party) 
library(dplyr) 
library(magrittr) 
library(rpart)
library(rpart.plot)

#1-  Load the dataset readingSkills

data("readingSkills") 

#2A- Create the decision tree model using rpart and plot the model
model_1 <- rpart(nativeSpeaker ~ ., readingSkills) 
rpart.plot(model_1)

#2B- Create the decision tree model using ctree and plot the model
model_2<- ctree(nativeSpeaker ~ ., readingSkills) 
plot(model_2) 


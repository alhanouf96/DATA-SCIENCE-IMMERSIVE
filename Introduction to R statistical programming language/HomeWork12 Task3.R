library("ggplot2")
library("dplyr")
library(tidyverse)

" I've not understand what is meant by -function that takes marginals and conditionals as inputs and calculates all of them-,
as none of them can be calculated without knowing the probability values or Joint Probabilities.
So I applied the concept of each of them to an existing dataset . which is -diamonds dataset- """


#The two different variables that we will work on: colors and cuts
#measure the frequency of each type of diamond color-cut combination
color_cut <-
  diamonds %>%
  group_by(color, cut) %>%
  summarize(n = n())

#1- Joints Probability
color_cut_prop <- 
  color_cut %>%
  ungroup() %>% #remove group_by
  mutate(prop = n / sum(n)) #adds new variables that calculates joints Probability
  

#2A- Marginal Probabilities for color variable
color_marginal <- 
  color_cut_prop %>%
  group_by(color) %>%
  summarize(marginal = sum(prop))#adds new variables that calculates Marginal Probabilities

#2B- #2A- Marginal Probabilities for cut variable
cut_marginal <- 
  color_cut_prop %>%
  group_by(cut) %>%
  summarize(marginal = sum(prop))#adds new variables that calculates Marginal Probabilities


#Casting will transform long format back into wide format.
color_cut_prop %>%
  dcast(color ~ cut, value.var = "prop") %>% #use dcast to cast your data into a dataframe
  left_join(color_marginal, by = "color") %>%
  bind_rows(
    cut_marginal %>%
      group_by(color = "marginal") %>% #adds row of marginal
      dcast(color ~ cut, value.var = "marginal")
  ) 


#3- Conditional Probability

#Probability of getting a diamond with the F color,given that diamond of Premium cut

# p(F,Premium)= ?
joint_prob <- 
  color_cut_prop %>%
  filter(color == "F", cut == "Premium") %>%
  .$prop

# p(Premium)= ?
marg_prob <- 
  cut_marginal %>%
  filter(cut == "Premium") %>%
  .$marginal

#p(F | Premium)= ?

cond_prob <- joint_prob / marg_prob
cond_prob



#source:https://tinyheero.github.io/2016/03/20/basic-prob.html

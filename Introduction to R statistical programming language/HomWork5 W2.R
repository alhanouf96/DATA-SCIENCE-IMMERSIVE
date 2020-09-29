#3.2.4 Exercises
#1 Run ggplot(data = mpg). What do you see?
ggplot(data = mpg) #empty plot

#2 How many rows are in mpg? How many columns?
mpg #234 rows, 11 columns

#3 What does the drv variable describe? Read the help for ?
#Ans: the type of drive train,
#where f = front-wheel drive, r = rear wheel drive, 4 = 4wd

#4 Make a scatterplot of hwy vs cyl.
 ggplot(data = mpg) + 
 geom_point(mapping = aes(x = hwy, y = cyl))
#5 What happens if you make a scatterplot of class vs drv?
 #Why is the plot not useful? 
 ggplot(data=mpg)+
   geom_point(mapping = aes(x=class, y=drv))
 #not useful because variable class is categorical
 
 #3.3.1 Exercises
 #1What’s gone wrong with this code? Why are the points not blue?
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))
 #2 Which variables in mpg are categorical? Which variables are continuous? 
 str(mpg)
 #3 Map a continuous variable to color, size, and shape. 
 #How do these aesthetics behave differently for categorical vs. continuous variables?
 
 #continuous
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, color = cyl))
 
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, size = cyl))
 
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, shape = cyl))
 #Error: A continuous variable can not be mapped to shape
#categorical 
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, color = class))
 
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, size = class))
 
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, shape = class))
 #4 What happens if you map the same variable to multiple aesthetics?
 ggplot(data = mpg) + 
 geom_point(mapping = aes(x = displ, y = hwy, size=cyl, color=cyl))
#5 What does the stroke aesthetic do? What shapes does it work with?  
 # Use the stroke aesthetic to modify the width of the border
 ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size=cyl, color=cyl, stroke = 3))
#6 What happens if you map an aesthetic to something other than a variable name, like aes(colour = displ < 5)?
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy, color=cyl<5))
 
 #3.5.1 Exercises
 #1 What happens if you facet on a continuous variable?
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy)) + 
   facet_grid(~ cyl)
#2 What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 
#No combination of data points
 
#3 What plots does the following code make? What does . do? 
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy)) +
   facet_grid(drv ~ .)
#rows are facetted by the drv variable
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy)) +
   facet_grid(. ~ cyl)
 #columns are facetted by the cyl variable 
 
#4 What are the advantages to using faceting instead of the colour aesthetic?
#What are the disadvantages? How might the balance change if you had a larger dataset?
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy)) + 
   facet_wrap(~ class, nrow = 2)
# Advantages: it is useful for categorical variables,display one subset of the data
 #making focus on particular facets alone. 
 #in contrast colour aesthetic having display of multiple colors can cause confusion.
 
 #Disadvantage: the points are on separate plots direct comparison may not be direct
 
#5 Read ?facet_wrap. What does nrow do? What does ncol do? 
 
 #ANS: To control in the number of rows and columns with nrow and ncol
 
 #3.6.1 Exercises
 #1 What geom would you use to draw a line chart? A boxplot? A histogram? An area chart?  
 ggplot(data = mpg)+
   geom_line(mapping=aes(x=displ,y=hwy))

 ggplot(data = mpg)+
   geom_boxplot(mapping=aes(x=displ,y=hwy, color=class))
 
 ggplot(data = mpg)+
   geom_area(mapping=aes(x=displ,y=hwy, color=class))
#2 Run this code in your head and predict what the output will look like.
 #Then, run the code in R and check your predictions.
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
   geom_point() + 
   geom_smooth(se = FALSE)
 #3 What does show.legend = FALSE do? What happens if you remove it?
 # ANS: Should this layer be included in the legends? NA, the default, includes if any aesthetics are mapped. 
 #FALSE never includes, and TRUE always includes.
  
 #4 What does the se argument to geom_smooth() do?
 #ANS: Display confidence interval around smooth, TRUE by default
 
 #5 Will these two graphs look different? Why/why not?
 
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
   geom_point() + 
   geom_smooth()
 
 ggplot() + 
   geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
   geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#ANS:same code, at the first one we avoid this type of repetition by passing a set of mappings to ggplot().
 #ggplot2 will treat these mappings as global mappings that apply to each geom in the graph.
 
 #6 Recreate the R code necessary to generate the following graphs.
 
#1
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
   geom_point(mapping = aes(size=class),show.legend = FALSE)+
   geom_smooth(se = FALSE)
#2
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group=drv)) + 
   geom_point(mapping = aes(size=class),show.legend = FALSE)+
   geom_smooth(se = FALSE) 
#3
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy, group=drv,color=drv)) + 
   geom_point(mapping = aes(size=class),show.legend = FALSE)+
   geom_smooth(se = FALSE) 
#4
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
   geom_point(mapping = aes(color=drv,size=class),show.legend = TRUE) + 
   geom_smooth(mapping = aes(color=drv),show.legend = TRUE,se=FALSE)
 
#5
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy, linetype=drv)) + 
   geom_point(mapping = aes(size=class,color=drv),show.legend = FALSE)+
   geom_smooth(se=FALSE) 

#6
 ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
   geom_point(mapping = aes(size=class,color=drv),show.legend = TRUE)
 
 #3.7.1 Exercises
 #1 What is the default geom associated with stat_summary()? 
 #How could you rewrite the previous plot to use that geom function instead of the stat function?
 ggplot(data = diamonds) +
   geom_pointrange(mapping = aes(x = cut, y = depth),
                   stat = "summary",
                   fun.ymin = min,
                   fun.ymax = max,
                   fun.y = median)
 #2 What does geom_col() do? How is it different to geom_bar()?
 
 #ANS: geom_bar() makes the height of the bar proportional to the number of cases in each group 
 #(or if the weight aesthetic is supplied, the sum of the weights). 
 #If you want the heights of the bars to represent values in the data, use geom_col() instead. 
 #geom_bar() uses stat_count() by default: it counts the number of cases at each x position. 
 #geom_col() uses stat_identity(): it leaves the data as is.
 
 #3 Most geoms and stats come in pairs that are almost always used in concert.What do they have in common?
 
 #ANS: geom_bar(mapping = NULL, data = NULL, stat = “count”, position = “stack”, …, width = NULL, binwidth = NULL, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE)
 #stat_count(mapping = NULL, data = NULL, geom = “bar”, position = “stack”, …, width = NULL, na.rm = FALSE, show.legend = NA, inherit.aes = TRUE) 
 #Both stat_count & geom_bar() understands the following aesthetics: x, y, alpha, colour, fill, group, linetype & size.
 
 #What variables does stat_smooth() compute? What parameters control its behaviour?
 #ANS: Computed variables
 #y predicted value
 
 #ymin lower pointwise confidence interval around the mean
 
 #ymax upper pointwise confidence interval around the mean
 
 #se standard error
 
 #5 In our proportion bar chart, we need to set group = 1
 
 ggplot(data = diamonds) + 
   geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

 #3.8.1 Exercises
 #1 What is the problem with this plot? How could you improve it?
 ggplot(data = mpg, mapping = aes(x = cty, y = hwy),position = "jitter") + 
   geom_point()
 #The values of hwy and displ are rounded 
 #so the points appear on a grid and many points overlap each other
 ggplot(data = mpg) + 
   geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

 #2 What parameters to geom_jitter() control the amount of jittering? 
 #ANS:width&height
 
 #3 Compare and contrast geom_jitter() with geom_count().
 #ANS:  geom_point() that counts the number of observations at each location, then maps the count to point area. 
 #It useful when you have discrete data and overplotting.
 #geom_jitter() It adds a small amount of random variation to the location of each point,
 #and is a useful way of handling overplotting caused by discreteness in smaller datasets.

 #4 What’s the default position adjustment for geom_boxplot()? 
 #Create a visualisation of the mpg dataset that demonstrates it.
 
 ggplot(data = mpg, mapping = aes(x = cty, y = hwy,color=class)) + 
   geom_boxplot()
 
 
 
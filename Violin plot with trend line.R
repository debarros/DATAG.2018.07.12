library(ggplot2)

# Let's say you have data you are collecting weekly on a set of students.
# You want to see how things are changing from one week to the next.
# You are interested in seeing not only how the average is changing, but also the distribution.
# To compare a bunch of distributions, you should use violin plots
# To show the change in the mean over time, you should use a trend line

# Make a toy data set
n <- 100
dates <- as.Date(c("2017-10-1", "2017-10-8", "2017-10-15", "2017-10-22"))
Week = rep(dates, each = n)
v_1 = c(pmin(6,2 * rexp(n, 1.5)), c(rnorm(n/2, 2, .5), rnorm(n/2, 5, .5)), pmax(0,log(runif(n)) + rnorm(n) + 6), pmin(rnorm(n) + 9, 10))
mydata = data.frame(Week = Week, v_1 = v_1)
mydata$Week.factor = as.factor(mydata$Week)
mydata$Week.levels = as.numeric(mydata$Week.factor) 

# Make the plot
p1 = ggplot(mydata) # create the plot stub
p1 + geom_violin(aes(x = Week.factor, y = v_1)) + 
  geom_smooth(aes(x = Week.levels, y = v_1), method = "lm") + 
  stat_summary(aes(x = Week.factor, y = v_1, group=1), fun.y = mean, geom = "point", color = "red", size = 3)

# The variable Week has date values.
# In Week.factor, the Week values were converted to a factor (nominal) variable.
# In Week.levels, the Week values were replaced by the number representing their factor level (1 through 4).
# The horizontal axis in the plot is really a scale of those factor levels (with the dates just showing up as labels).
# Anything plotted used the factor levels as the x-values will show up plotted correctly with the dates.
# This was necessary because you can't do a trend line when one of the variables is nominal.
# Since we are using two different variables for the x-axis in the various levels, 
# the mapping needs to be specified in each layer (rather than in the original ggplot statement)


#---------------------------#
#### Position Adjustment ####
#---------------------------#

# Set up a plot stub using the mpg data set
# Let's use fuel type as the x aesthetic and drive type as the fill aesthetic
s <- ggplot(data = mpg, 
            mapping = aes(x = fl, fill = drv))

# The default position for geom_bar is "stack"
s + geom_bar()
# Let's try some others

# The fill position makes the geom fill its space
s + geom_bar(position = "fill")
# This means that the colored blocks now represent portions of the column

# The "dodge" position forces the bars to be next to each other
s + geom_bar(position = "dodge")

# Instead of using a simple named position adjustment, you can use a position function.
# Position functions are named based on the standard position arguments.
# When using a position function, you can specify height and width parameters.
s + geom_bar(position = position_dodge(width = 1))
s + geom_bar(position = position_dodge(width = 2))
s + geom_bar(position = position_dodge(width = .5))

# That last one makes them overlap.  That might be easier to see with some transparency
s2 = s + geom_bar(
  position = position_dodge(width = .5),
  alpha = .7)
print(s2)

#--------------------------------------------#
#### Plot Annotations: Making it Polished ####
#--------------------------------------------#

# Let's keep using that last graph
s3 = s2 + labs(x = "Fuel Type", 
               y = "Number of car models",
               title ="Car Models",
               subtitle = "Fuel Type X Drive Type",
               caption = "fueleconomy.gov") 
print(s3)

# Let's mess with the legend
s3 + theme(legend.position = "bottom", 
           legend.background = element_rect(fill = "pink"))



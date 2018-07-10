#----------------------------------#
#### Plotting Multivariate Data ####
#----------------------------------#


# ggplot2 includes a dataset "mpg"
?mpg         # ? gives help on a function or dataset
head(mpg)    # head() lists the first several rows of a data.frame
str(mpg)     # str() gives the structure of the object
summary(mpg) # summary() gives frequency tables for categorical variables and summary stats for continuous variables

# Let's make some plots
p <- ggplot(mpg, aes(x = displ, y = hwy)) # Specify the dataset and variables that will be used.  Call this the plot stub.
p2 <- p + geom_point()                    # add a plot layer with points
print(p2)

# Color code by type of vehicle
# The aesthetic mapping in the plot stub did not map any variable to the colour aesthetic.
# Here, we add on to the existing aesthetic mapping, but only for this one geom.
p3 <- p + geom_point(aes(colour = class)) 
print(p3)
# Note that, since we now have an aesthetic that is not a scale, there is now a legend.

# Use other variables to modify the shape and size of points
p4 <- p + geom_point(aes(colour = class, size = cyl, shape = drv))
print(p4)
# That's a little hard to interpret.

# Use the alpha setting to change the opacity of the points
p5 <- p + geom_point(mapping = aes(colour = class, size = cyl, shape = drv), 
                     alpha = 1/4) 
print(p5)
# Note that the alpha parameter was set as a part of the entire layer.
# It was not included in the aesthetic mapping, so the degree of transpancy
# is constant, not based on any variable.

#------------------------------#
#### Plotting with Faceting ####
#------------------------------#

# start by creating a basic scatterplot
p <- ggplot(mpg, aes(x = displ, y = hwy))
p <- p + geom_point()

## two methods exist for making output with multiple plots in it
# facet_grid(rows ~ cols) for 2D grid, "." for no split.
# facet_wrap(~ var)       for 1D ribbon wrapped into 2D.

# examples of subsetting the scatterplot in facets
p1 <- p + facet_grid(. ~ cyl)     # columns are cyl categories
print(p1)

p2 <- p + facet_grid(drv ~ .)     # rows are drv categories
print(p2)

p3 <- p + facet_grid(drv ~ cyl)   # both
print(p3)

p4 <- p + facet_wrap(~ class)     # wrap plots by class category
print(p4)



# When values are disrete, the points might overlap
p <- ggplot(mpg, aes(x = cty, y = hwy))
p <- p + geom_point()
print(p)
# The data set has 234 entries, far fewer points show up.

# One way to address this is using jitter and alpha
p <- ggplot(mpg, aes(x = cty, y = hwy))
p <- p + geom_point(position = "jitter", alpha = 1/2)
print(p)
# However, note that, by jittering the points, 
# you are moving them away from their true location.

# Graphs that have a factor variable (categorical) will arrange by factor levels (often alphabetically)
p <- ggplot(mpg, aes(x = class, y = hwy))
p <- p + geom_point()
print(p)


# You can rearrange them by using reorder
p <- ggplot(mpg, aes(x = reorder(class, hwy), y = hwy))
p <- p + geom_point()
print(p)
# reorder defaults to using the average value of each category to do the sorting


# Again, points are overlayed.  Let's do some jittering!
p <- ggplot(mpg, aes(x = reorder(class, hwy), y = hwy))
p <- p + geom_point(position = "jitter")
print(p)
# That is not very helpful, is it?


# Since we want to look at the distributions of values in each category, let's try boxplots.
p <- ggplot(mpg, aes(x = reorder(class, hwy), y = hwy))
p <- p + geom_boxplot()
print(p)
# You know how hard it is to get that from Excel?  Super hard.


# Let's turn it up a bit and add two different geom layers to the plot.
p <- ggplot(mpg, aes(x = reorder(class, hwy), y = hwy))
p <- p + geom_point(position = "jitter")
p <- p + geom_boxplot(alpha = 0.5)
print(p)


# If we add the layers in a different order, the outcome is different.
p <- ggplot(mpg, aes(x = reorder(class, hwy), y = hwy))
p <- p + geom_boxplot(alpha = 0.5)
p <- p + geom_point(position = "jitter")
print(p)
# The first one is placed in the back and the last in the front.


# Remember how reorder uses the mean of each category?  Let's tell it to use the median instead.
p <- ggplot(mpg, aes(x = reorder(class, hwy, FUN = median), y = hwy))
p <- p + geom_boxplot()
p <- p + geom_point(position = "jitter", alpha = .1)
print(p)


# Let's put some stuff together.
p <- ggplot(mpg, aes(x = reorder(class, hwy, FUN = median), y = hwy))
p <- p + geom_boxplot()
p <- p + geom_point(mapping = aes(colour = class, shape = drv),
                    position = "jitter", 
                    alpha = .3)
print(p)









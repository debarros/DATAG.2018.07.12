# Note: much of what follows is taken from the lecture notes of Erik B. Erhardt, 
# who is a professor at the University of New Mexico.
# You read more about him at statacumen.com

#----------------------#
#### Getting Set Up ####
#----------------------#

# There are three primary strategies for plotting in R. 
# The first is base graphics, using functions such as plot(), points(), and par().
# A second is use of the package lattice, which creates very nice graphics quickly, 
# though can be more difficult to create high-dimensional data displays.
# A third is using package ggplot2, which is an implementation of the "Grammar of Graphics".
# We will be using ggplot2.

# Install the ggplot2 package (if you don't have it already)
install.packages("ggplot2") # only needed once after installing or upgrading R

# load package ggplot2 for its functions and datasets
library(ggplot2) # each time you start R


#--------------------------------#
#### Plotting Univariate Data ####
#--------------------------------#

# Let's set up some data.  Assume that the following are meaurments of head size.
hb <- c(141, 148, 132, 138, 154, 142, 150, 146, 155, 158, 150, 140, 147, 148, 144, 150, 149, 145)

# Put the hb vector into a data.frame
hb_df <- data.frame(hb)
# A data.frame is the standard way of using data in R, and required when using ggplot2 


# Histogram
# Always specify a binwidth for the histogram (default is range/30)
# Ty several binwidths
px = ggplot(data = hb_df, mapping = aes(x = hb))                           # set up the plot stub
p2 <- px + geom_histogram(binwidth = 5) 
p2 <- p2 + labs(title = "Modern Englishman head breadth")
print(p2)



# Stripchart (aka Dotplot)
# We are going to use geom_point here, which requires both x and y.
# We want the data spread horizontally, so we'll use hb and the x variable and leave the y variable blank.
px0 <- ggplot(data = hb_df, mapping = aes(x = hb, y = ""))
p1 <- px0 + geom_point(position = position_jitter(h = 0.1))           # add a geom layer with points plotted
p1 <- p1 + labs(title = "Head Breadth") + xlab("head breadth (mm)")   # add labels
print(p1)







# Boxplot
# We are going to use geom_boxplot here, which requires both x and y.
# The y variable is actually used to set up the boxplot.  
# The x is unused in univariate boxplots, so we'll leave it blank.
p0y = ggplot(hb_df, aes(x = "", y = hb)) # plot stuf
p3 <- p0y + geom_boxplot(aes(group = 1)) # bopxplot layer
p3 <- p3 + coord_flip()                  # flip the axes
p3 <- p3 + labs(title = "Head Breadth")  # add a title
print(p3)



# Violin plot
# We are going to use geom_violin here, which uses the same setup as geom_boxplot.
# Therefore, we can use the same plot stub.
p4 <- p0y + geom_violin()
print(p4)


#-------------------------------------------------#
#### Plotting randomly generated data (Normal) ####
#-------------------------------------------------#

# sample from normal distribution
x1 <- rnorm(250, mean = 100, sd = 15)
# rnorm means "random normal" - take random samples from the normal distribution

x1_df <- data.frame(x1)          # put it in a data.frame
p <- ggplot(x1_df, aes(x = x1)) # set up the plot stub

# Histogram 
p1 <- p + geom_histogram(aes(y = ..density..), 
                          binwidth = 5, 
                          colour = "black", 
                          fill = "white")
print(p1)
# Are you wondering what the ..density.. means?  Yeah, it's weird, right?
# A geom will generally inherit aesthetics from the ggplot statement
# You can override that by using the aes() function to map different variables to the aesthetic
# However, sometimes you don't want to use the actual variable, but some calculation on it, like its density
# Here, it basically means to map the density of the variable as the aesthetic, rather than the variable itself
# What are aesthetics and geoms?  Well, that's a deeper question.
# Read here: http://tutorials.iq.harvard.edu/R/Rgraphics/Rgraphics.html#geometric_objects_and_aesthetics


# Overlay with transparent density plot
p1 <- p1 + geom_density(alpha  =0.1, fill = "#FF6666")
print(p1)

# Add a carpet of jittered points below the histogram
p1 <- p1 + geom_point(aes(y = -0.001), 
                      position = position_jitter(height = 0.0005), 
                      alpha = 1/5)
print(p1)

# Violin plot
p2 <- p + geom_ribbon(aes(ymax = ..density.., ymin = -..density..), stat = "density")
print(p2)

# More direct way to get a violin plot
p2.alternate <- ggplot(x1_df, aes(1, y = x1)) + geom_violin() + coord_flip()
print(p2.alternate)


# Boxplot
p3 <- ggplot(x1_df, aes(x = "x1", y = x1))
p3 <- p3 + geom_boxplot()
p3 <- p3 + coord_flip()
print(p3)



# Note: the rest of this file is just more examples of the same stuff.

#--------------------------------------------------#
#### Plotting randomly generated data (Uniform) ####
#--------------------------------------------------#

# sample from uniform distribution
x3 <- runif(250, min = 50, max = 150)
# I know this looks like "run if", but read it like "r unif", short for "random uniform"


# Density Histogram 
x3_df <- data.frame(x3)
p1 <- ggplot(x3_df, aes(x = x3))
p1 <- p1 + geom_histogram(aes(y = ..density..), 
                          binwidth = 5, 
                          colour = "black", 
                          fill = "white")
print(p1)

# Overlay with transparent density plot
p1 <- p1 + geom_density(alpha = 0.1, fill = "#FF6666")
print(p1)

# Add a carpet of jittered points
p1 <- p1 + geom_point(aes(y = -0.001), position = position_jitter(height = 0.0005), alpha = 1/5)
print(p1)

# violin plot
p2 <- ggplot(x3_df, aes(x = 1, y = x3))
p2 <- p2 + geom_violin()
print(p2)

# boxplot
p3 <- ggplot(x3_df, aes(x = "x3", y = x3))
p3 <- p3 + geom_boxplot()
p3 <- p3 + coord_flip()
print(p3)


#------------------------------------------------------#
#### Plotting randomly generated data (Exponential) ####
#------------------------------------------------------#


# sample from exponential distribution
x4 <- rexp(250, rate = 1)
# I know this looks like "rex p" but read it as "r exp", short for "random exponential"




# Density Histogram 
x4_df <- data.frame(x4)
p1 <- ggplot(x4_df, aes(x = x4))
p1 <- p1 + geom_histogram(aes(y=..density..), binwidth=0.5, colour="black", fill="white")
print(p1)

# Overlay with transparent density plot
p1 <- p1 + geom_density(alpha=0.1, fill="#FF6666")
print(p1)

# Add a carpet of points
p1 <- p1 + geom_point(aes(y = -0.001), position = position_jitter(height = 0.0005), alpha = 1/5)
print(p1)

# violin plot
p2 <- ggplot(x4_df, aes(x = 1, y = x4))
p2 <- p2 + geom_violin()
print(p2)

# boxplot
p3 <- ggplot(x4_df, aes(x = "x4", y = x4))
p3 <- p3 + geom_boxplot()
p3 <- p3 + coord_flip()
print(p3)

#--------------------------------------------------------#
#### Plotting randomly generated data (Uniform again) ####
#--------------------------------------------------------#

# sample from uniform distribution
x5 <- 15 - rexp(250, rate = 0.5)
x5_df <- data.frame(x5)



# Density Histogram 
p1 <- ggplot(x5_df, aes(x = x5))
p1 <- p1 + geom_histogram(aes(y = ..density..), 
                          binwidth = 0.5, 
                          colour = "black", fill = "white")
print(p1)

# Overlay with transparent density plot
p1 <- p1 + geom_density(alpha = 0.1, fill = "#FF6666")
print(p1)

# Add a carpet of points
p1 <- p1 + geom_point(aes(y = -0.001), 
                      position = position_jitter(height = 0.0005), 
                      alpha = 1/5)
print(p1)


# violin plot
p2 <- ggplot(x5_df, aes(x = "", y = x5))
p2 <- p2 + geom_violin()
print(p2)


# boxplot
p3 <- ggplot(x5_df, aes(x = "x5", y = x5))
p3 <- p3 + geom_boxplot()
p3 <- p3 + coord_flip()
print(p3)



#-------------------------------------------------------#
#### Plotting randomly generated data (Normal again) ####
#-------------------------------------------------------#

# sample from 2 normal distributions
x6 <- c(rnorm(150, mean = 100, sd = 15), rnorm(150, mean = 150, sd = 15))
x6_df <- data.frame(x6)

# Density Histogram
p1 <- ggplot(x6_df, aes(x = x6))
p1 <- p1 + geom_histogram(aes(y = ..density..), binwidth = 5, colour = "black", fill = "white")
print(p1)

# Overlay with transparent density plot
p1 <- p1 + geom_density(alpha=0.1, fill="#FF6666")
print(p1)

# Add a carpet of points
p1 <- p1 + geom_point(aes(y = -0.001), position = position_jitter(height = 0.0005), alpha = 1/5)
print(p1)

# violin plot
p2 <- ggplot(x6_df, aes(x = "", y = x6))
p2 <- p2 + geom_violin()
print(p2)

# boxplot
p3 <- ggplot(x6_df, aes(x = "x6", y = x6))
p3 <- p3 + geom_boxplot()
print(p3)

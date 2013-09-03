##############################################################################
# title         : Introduction_to_R.R;
# purpose       : Annotated code and R script for an introduction to R for;
#               : IRRI Epidemiology and Plant Health Unit Statistics workshop; 
#               : held in Tagaytay, Philippines May 2012;
# producer      : prepared by A. Sparks;
# last update   : in Los Banos, IRRI, May 2012;
# inputs        : Yields.csv, PlantHeight.csv;
# outputs       : Graph of plant yields vs. disease severity;
##############################################################################

# Why use R?

# R is a free software environment that includes a set of base packages for 
# graphics, math, and statistics. You can also make use of specialized packages
# contributed by R users or write your own new functions. You can also share 
# your own script files for analysis and other types of work. Because R is free
# it is possible for anyone to install it and use these materials.

# R performs many of the same statistical analyses as SAS, http://www.sas.com/. 
# The trade-off in use of R versus SAS might revolve around the fact that R is 
# free while SAS may have better technical support and testing for features 
# such as linear models in packages like SAS Proc Mixed.

##############################################################################
### Becoming familiar with R

# Pay VERY close attention to how I have typed the lines in this script file.
# The syntax of R is very specific, if something doesn't work, maybe you forgot to
# use a "," or a " ' " or put a space where there should not be one, or 
# used a ":" where there should be a ",", because R is a programming language
# this is critical.

# Move the cursor to the prompt below and type the following text at the ">" and hit enter
# Or put the cursor on the line and hit the "Run" button above and to the right.
# Or put the cursor on the line and hit "Control + Enter".

16 # this is a number
'rice' # this is NOT a number, it is a character
'16' # this is NOT a number either because it uses quotes, it is a character
# comment - This is a comment because of the "#", it will not do anything in R


### Searching R help
# Type this, or use the help tab in the right-hand pane of RStudio
?sqrt

## Using R as a deluxe calculator
# To save time you can put the cursor on the line here that you wish to run and 
# type "ctrl + enter" and it will give you the results below in the Console
3*3 # Multiply, multiplication uses the * symbol not X or x
3^3 # Exponential, the ^ indicates to the _ power
log10(100) # Log

### Creating objects and assigning values
x <- 5
x

# Typing this replaces the value of x, previously 5, with 7
x <- 7
x

# R is case sensitive, X≠x!
X <- 8
x
X


# Actions can be carried out on the value assigned to an object
x*X


### Grouping objects
# Using c() creates an object with a 'list' of whatever is contained in the ()
y <- c(10, 6, 8)
y

z <- '16'
z

# Operations can then be performed on the whole list. 
# For example, for the object y created above, check the results of the following
y*2
z*2 # does not work because z does not contain numbers, remember it's a character!

# The numbers in y can be indexed (accessed) individually, for example:
y[2] # Gives the second entry in y
y[1] # Gives the first entry in y

# The numbers in y can be indexed in subsets. 
y[1:2] # Gives the first and second entries in y
y[c(1, 3)] # Gives the first and third entries in y

# Some words are 'reserved' for functions built into R try some of these common calculations
mean(y) # Calculates the mean of the entries in y
var(y)  # Calculates the variance of the entries in y
sum(y)
cumsum(y) # Check what this function is doing…
median(y)
length(y) # How many values does y contain?

### Exercises, remember R is case sensitive, follow what I have typed here.
# 1.) Create an object Y with a value of 3.3
# 2.) Now take Y to the 3rd power, what is the value displayed?
# 3.) Now create an object, Z, using Y to the third power
# 4.) What is the value of z, (not Z!!!)?


##############################################################################
### Working with data

# Finding what directory R is working in
# This is useful for knowing where files are located when importing them to R
getwd()

### Using RStudio, set the directory which R "works" in using "Tools > Set Working Directory > To Source File Location"
# Now check the working directory, again
getwd()

# Working with data, bringing data into R from Excel and other external files
# Read the help file for read.csv and read.table
yield.data <- read.csv(file.choose()) # Select yields.csv

# Examine the data once it is in R
yield.data # Display all data in the data set
summary(yield.data) # Display somewhat detailed information for the data
head(yield.data, 5) # Display the first five lines of all columns
yield.data$DisSev # Display values in the column DisSev
yield.data[, 2] # Display values in column 2, DisSev
yield.data[2, ] # Display values in row 2 (note the comma placement!)
yield.data[1, 3] # Display the value for row 1, column 3

# dataframe[row #, column #]
# dataframe[, 1] means all rows, only column 1
# dataframe[1, ] means all columns of only row 1

# Now open the second set of data
height.data <- read.csv(file.choose()) # Select PlantHeight.csv

# Combine the data sets into one data frame in R
exp.data <- cbind(yield.data, height.data) # Also read help for '?rbind'
exp.data # Note the extra 'Plot' column
exp.data <- exp.data[, -4] # this will remove the fourth column
exp.data

# Alternative method to join yield data and only the height data
exp.data <- cbind(yield.data, height.data$PlantHeight) # This only takes the 'PlantHeight' column

# But look at the name of the column now!
exp.data

# We can rename the column to something easier for us to read
# Using the [4] tells R to rename the 4th column to 'PlantHeight'
names(exp.data)[4] <- 'PlantHeight'

# Now look at the names of the columns in the data frame
exp.data

# To rename all of the columns in the dataframe
# use the c() command to string the names together in a list and
# do not specify just one colum, use the whole data frame
names(exp.data)  <- c('column1', 'column2', 'column3', 'column4')

# Now look at the names of the columns in the data frame
exp.data

### Exercises
# 1) What would you type to display the DisSev value for plot 5 in exp.data?
#    Hint: see line 140
# 2) Create a new data frame called exp.data2 using yield.data and height.data;
#    using the cbind() command, including the extra "plot" column
# 3) Now remove the extra plot column, hint [row, column], see line 152
# 4) Rename the column "RelYield", in exp.data2, to 'Yield'


##############################################################################
### Graphics

## Scatterplot
plot(x = yield.data$DisSev, # Which data to plot on the x-axis
     y = yield.data$RelYield, # Which data to plot on the y-axis
     xlab = 'Disease Severity (%)', # Label the x-axis
     ylab = 'Relative Yield (%)') # Label the y-axis

## Histogram
hist(yield.data$RelYield, 
     xlab = 'Yield', 
     main = 'This is a histogram')

### Using colors and point shapes in graphics
# To see the different point styles search '?points'
# To see a list of colors R knows type 'colors()'
# cex makes the points bigger or smaller, this time we'll make them bigger

plot(x = yield.data$DisSev, 
     y = yield.data$RelYield,
     xlab = 'Disease Severity (%)',
     ylab = 'Relative Yield (%)',
     col = 'orange',
     pch = 15,
     cex = 5)

### Saving graphics for publications and presentations
# Graphs can be saved in a range of file types, BMP, JPEG, PNG, TIFF, SVG and PDF
# Search "?png" for more help on these options

### Easy way to save images from RStudio
# In the plot window select "Export"
# "Save Plot as Image" or "Save Plot as PDF"

### Exercises
# 1) Change the color of the points to red, hint: see lines 211 and 231
# 2) Change the point type to a solid triangle, hint: '?pch',
#    hint: use bg after pch = 15 to fill the triangle, don't forget the ',' after 15.


##############################################################################
### R resources

## Online
# http://cran.r-project.org/doc/manuals/R-intro.pdf
# http://www.rseek.org/ - Search engine for R subjects
# http://stackoverflow.com/questions/tagged/r - Programming website with R support

## Make your code read able to yourself in the future and to others, follow a consistent style
# Google R Style Guide: http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html
# Hadley Wickham's R Style Guide: http://stat405.had.co.nz/r-style.html

## Exercises in Epidemiology and Ecology Using R on the APS Website: 
#  http://www.apsnet.org/EDCENTER/ADVANCED/TOPICS/ECOLOGYANDEPIDEMIOLOGYINR/Pages/default.aspx

## Book
# "The R Book" by M. J. Crawley

#eos

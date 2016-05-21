# =============================================================================
# Lab 3: Descriptive analysis
# =============================================================================

# Balint Neray  |   MTA-TK-SZI  |   neray.balint@tk.mta.hu

# =============================================================================

# let's get familiar with a few descriptive methods
# and visuals

# =============================================================================
# (0) LIB and WD
# =============================================================================

# (0.1) libraries
#install.packages("MASS")
library(MASS)

# (0.2) working directory
rm(list=ls())
whoareyou <- "balintneray"
path <- paste0("/Users/",whoareyou,"/Copy/My_Projects/MTA_R_workshop/")
setwd(path)

# (0.3) original data
# ...


# =============================================================================
# (1) Describe the data
# =============================================================================

  # frequences
  ?painters
  data(painters)

  school <- painters$School
  school.freq <- table(school)
  school.freq
  class(school.freq)
  # note that this is a new 'table' class that we haven't met before
  # we can give it a more 'SPSS-like' outlook
  cbind(school.freq)

  comp <- painters$Composition
  comp.freq <- table(comp)
  comp.freq
  cbind(comp.freq)

  # maximum
  school <- painters$School
  school.freq <- table(school)
  school.freq.max <- max(school.freq)
  school.freq.max

  # mean of a subsample
  school <- painters$School
  c_school <- school == "C"
  c_painters <- painters[c_school, ]
  mean(c_painters$Composition)
  # all of it:
  tapply(painters$Composition, painters$School, mean)

  # portion of a subsample
  colour = painters$Colour
  x = which(colour >= 14)
  length(x)/nrow(painters)
  ?length
  ?nrow

# =============================================================================
# EXCERCISE
# =============================================================================
# 1. Apply the function table() separately to the different categorical variables.
# 2. Use the table() function for different combinations of categorical variables.
# 3. To get proportions instead of frequencies, the function prop.table() can be used.
# This function has two arguments, namely table, and a margin index number 1 or 2
# which can also be omitted.
# For example:
# prop.table(table(painters$Colour, painters$School),1)
# prop.table(table(painters$Colour, painters$School),2)
# prop.table(table(painters$Colour, painters$School))
# Use these three options and evaluate what the effective differences are
# =============================================================================
  
  prop.table(table(painters$Colour, painters$School),1)
  prop.table(table(painters$Colour, painters$School),2)
  prop.table(table(painters$Colour, painters$School))
  round(prop.table(table(painters$Colour, painters$School)),2)
  
  # Distribution
  # There are several ways to inspect the empirical distribution of variables.
  # The function summary(), producing summary statistics of variables, has already
  # been mentioned.
  summary(painters$Composition)

  # A function for outlier detection is getOutliers() and outlierPlot from the
  # extremevalues package. It produces a QQ-plot or comparing two probability
  # distributions by plotting their quantiles against each other.
  # it can serve as a test of normal distribution

  # install.packages("extremevalues")
  library(extremevalues)
  L <- getOutliers(painters$Composition)
  outlierPlot(painters$Composition, L)

# =============================================================================
# EXCERCISE
# =============================================================================
# R offers a variety of functions to obtain dispersion measures, for example var(),
# sd(), IQR(), and mad().
# Look up these functions and try to understand the way they work.
# =============================================================================

  # Plots
  # bar
  school = painters$School
  school.freq = table(school)
  barplot(school.freq)
  # with some colors
  colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan")
  barplot(school.freq, col=colors)
  # pie
  school <- painters$School
  school.freq <- table(school)
  pie(school.freq)
  colors <- c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan")
  pie(school.freq, col=colors)
  ?pie

  # Printing plots to files
  # the image that should be present on the graphical device
  # will be printed to the given directory
  # note that the plot actual is not displayed
  # categorical-data1
  png(file="categorical-data1.png", width=450, height=450)
  barplot(table(painters$School))
  dev.off() # we close the device

  # categorical-data2
  png(file="categorical-data2.png", width=450, height=450)
  barplot(table(painters$Composition))
  dev.off()

  # categorical-data3
  png(file="categorical-data3.png", width=450, height=450)
  colors = c("red", "yellow", "green", "violet", "orange", "blue", "pink", "cyan")
  barplot(table(painters$School), col=colors)
  dev.off()

# =============================================================================
# EXCERCISE
# =============================================================================
# More useful graphics of the frequency distribution of observations on variables are
# produced by hist(), boxplot(), and stem(), providing a histogram, a box plot
# and a stem-and-leaf diagram, respec-tively.
# Try to aplly these functions on the data.
# =============================================================================

# =============================================================================
# (2) Bivariate relations
# =============================================================================

  # Graphically, the relation between two continuous variables can be explored
  # using the pairs() command
  pairs(USJudgeRatings)
  ## show only lower triangle (and suppress labeling for whatever reason):
  pairs(USJudgeRatings, upper.panel = NULL)

  # relations among fertility, educatoin and religion
  # where education is bigger then 20
  pairs(~ Fertility + Education + Catholic, data = swiss,
        subset = Education < 20, main = "Swiss data, Education < 20")
  # let's do something with our favorite colors
  ?iris
  pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species",
        pch = 21, bg = c("red", "green3", "yellow")[unclass(iris$Species)])
  # or squares
  pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species",
        pch = 23, bg = c("red", "green3", "blue")[unclass(iris$Species)])
  # and grey-scale with dots (they look nicer)
  pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species",
        pch = 21, bg = palette(gray(seq(0, 0.2, len = 3)))[unclass(iris$Species)])
  # and random rainbow
  pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species",
        pch = 21, bg = palette(rainbow(3))[unclass(iris$Species)])
  # and finally you can be super spesific about the colors if that's what you want
  pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species",
        pch = 21, bg = palette(c(rgb(170,93,152, maxColorValue=255),
                                 rgb(103,143,57, maxColorValue=255),
                                 rgb(115,113,206, maxColorValue=255)))[unclass(iris$Species)])
  
  # look what is 'unclass' for
  a <- iris$Species
  class(a)
  summary(a)
  b <- iris$Species
  b <- unclass(iris$Species)
  class(b)
  summary(b)
  
# =============================================================================
# EXCERCISE
# =============================================================================
# Use the 'pairs' function to create new plots. Play around the specifications
# to produce even more meaningful or just more shiny results.
# Don't be affraid to use different data sets.
# =============================================================================

  # Non-independent samples' t-tests (paired t-test)
  # In case of dependence or overlaping of the sub-samples
  rm(list=ls())
  ?immer
  t.test(immer$Y1, immer$Y2, paired=TRUE)

  # Independent samples' t-tests (Welch Two Sample t-test)
  # typically applied when the statistical units
  # underlying the two samples being compared are non-overlapping
  ?mtcars
  L <- mtcars$am == 0 # cars with automatic transmission
  mpg.auto <- mtcars[L,]$mpg # miles / gallon milage
  mpg.auto       # automatic transmission mileages

  mpg.manual <- mtcars[!L,]$mpg
  mpg.manual     # manual transmission mileages

  t.test(mpg.auto, mpg.manual)

  # Test of equal proportions
  # testing the null that the proportions in several groups are the same
  library(MASS)
  ?quine
  head(quine)
  # ethnic background and sex
  table(quine$Eth, quine$Sex)
  prop.test(table(quine$Eth, quine$Sex))

  # Pearson's Chi-squared Test for count data
  # can be used to reject the hypothesis that the data
  # (in the different categories) are independent
  ?survey
  head(survey)
  levels(survey$Clap)
  levels(survey$Sex)
  chisq.test(survey$Sex, survey$Clap)

  # Manually on 1 variable
  # clap.freq <- table(survey$Clap)
  # clap.freq
  # str(chisq.test)
  # N <- sum(clap.freq)
  # n1 <- 39 / N
  # n2 <- 50 / N
  # n3 <- 147 / N
  # clap.prob = c(0.17, 0.21, 0.62) # it has to add up to 1
  # chisq.test(clap.freq, p=clap.prob)

# =============================================================================
# EXCERCISE
# =============================================================================
# Inspect the correlaion between two variables
# Note that correlations are most meaningful for continuous variables.
# For the association between categorical variables, tables are more informative.
# For the association between categorical variables and continuous variables,
# it is more informative to compute descriptives of the continuous variables
# for each of the categories (as we did earlier)
# Note that the function cor() does not provide p values.
# The package Hmisc has a function calles rcorr() that does provide these values.
# Use this function to obtain the p values.
# =============================================================================

# =============================================================================
# (3) Towards multivariate realtions
# =============================================================================

  # Analysis of Variance (ANOVA)
  # a statistical test of whether or not the means of several groups are equal,
  # and therefore generalizes the t-test to more than two groups
  # the observed variance in a particular variable is partitioned into components
  # attributable to different sources of variation
  # in general terms we are interested in how different treatments influance the response set
  # that is, we are comparing among and between group variations
  ?survey
  head(survey)
  str(survey)
  levels(survey$Exer) # let it be the treatment
  summary(survey$Pulse) # let it be the response that we are interested in

  # let's do some visual description
  boxplot(survey$Pulse ~ survey$Exer)

  # To perform an ANOVA, the command anova(lm()) can be used,
  # where lm() stands for linear model.
  model1 <- anova(lm(survey$Pulse ~ survey$Exer))
  model1

  # Two-way ANOVA and multiple-way ANOVAs can be done by simply adding
  # more predictors after the tilde sign ~
  # and using the plus sign + between the predictors
  model2 <- anova(lm(survey$Pulse ~ survey$Exer + survey$Sex))
  model2

  # When comparing more than two groups, the problem of multiple comparisons arises.
  # To obtain all pairwise comparisons (with corrected p-values), the function
  # TukeyHSD() can be applied to an aov() object.
  # ?TukeyHSD()
  # model3 <- aov(lm(survey$Pulse ~ survey$Exer))
  # model3

  # Not that the assumption of ANOVA can / shall be tested
  # We already checked for normal distribution (QQ-plot)
  # The assumption of homogeneity of variance  can be testedwith Levene's test
  # The null hypothesis that is tested is that the population variances are
  # equal. Levene's test can be found in the car package using the command leveneTest.

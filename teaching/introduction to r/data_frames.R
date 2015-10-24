# =============================================================================
# Lab 2: Data frames
# =============================================================================

# Balint Neray  |   MTA-TK-SZI  |   neray.balint@tk.mta.hu

# =============================================================================

  # Maintaining a data set is one of the most important things a user
  # needs to know how to do. Most statistical software requires that the data set
  # be in a very specific format, called a data table or a data.frame.

  # A data.frame is a list of vectors of varying types.
  # Each vector is a column in the data.frame making this a column-oriented
  # data structure (as opposed to the row-oriented nature of relational databases)

# =============================================================================
# (1) Loading the data
# =============================================================================

  # read.table() is the most common R command for loading data from
  # files in which values are in tabular format. The function loads
  # the table into a data frame object, which is the basic data type
  # for most operations in R. By default, R assumes that the table
  # has no header and is delimited by any white space

  ?rm
  rm(names1)
  rm(logical1, logical2, logical3)
  rm(list=ls())

  # One handy aspect of R is that you can read in data from a URL
  # directly by referencing the URL in the read.table() function,
  # as follows:
  # Let's read a text file from a web page
  my_first_data_frame <- read.table('http://sna.stanford.edu/sna_R_labs/data/Krack-High-Tec-edgelist-Advice.txt')
  class(my_first_data_frame)
  
  # Note that when you set a variable equal to something, if all
  # goes well R will not provide any feedback. To see the data we
  # just loaded, it's necessary to call the variables directly.
  my_first_data_frame

  # If the files you want to work with are on your local machine,
  # the easiest way to access them is to first set your working
  # directory via the setwd() command, and then reference the
  # files by name:
  # setwd('path/to/your_directory')
  # your_data_frame <- read.table('your_file_name')

  # But there is a somewhat solution
  whoareyou <- "balintneray" # this is the user name
  path <- paste0("/Users/",whoareyou,"/Copy/My_Projects/MTA_R_workshop/") #
  # on WINDOWS:
  # path <- paste0("c:\\Users\\",whoareyou,"\\Copy\\My_Projects\\MTA_R_workshop")
  setwd(path)
  list.files(path = ".")
  list.files(path = path)
  # the default corresponds to the working directory which we already set
  ?read.table
  my_second_data_frame <- read.table("exampleData.txt", header=T, sep=' ')
  my_second_data_frame
  # if the data is in a
  load("exampleData.RData")
  my.second.data.frame <- data
  
  # When data files are part of an R package you can read them as
  # follows:
  # data(kracknets, package = "NetData")
  # You need to have the package installed and activated in order to do so.
  # To install a package you can type:
  # install.packages("ggplot2")
  # Or go to the "Packages" window (bottom-right) and do the installation from there
  # To activate a package, type:
  # library(ggplot2) # do it only once
  # Now we can easily call our third data.frame
  myThirdDf <- data.frame(diamonds)

  data() # lists all the datasets in all the packages in memory
  data(package="datasets") # lists all the datasets in the "datasets" package
  require(ggplot2)
  ?diamonds # you can find out more about the data
    
  # The 'foreign' package will allow you to read a few other
  # custom data types, such as SPSS files via read.spss() and
  # STATA files via read.dta().
  # install.packages("foreign")
  library(foreign)
  # for example
  myStataData <- read.dta("test_ESS.dta")

# =============================================================================
# EXCERCISE
# =============================================================================
# create an SPSS file from the 'quine' data set
# (it might require some google search)
# =============================================================================
  
  ?quine
  # install.packeges("MASS")
  library(MASS)
  write.foreign(quine, "mySpssData.sps", "mySpssData.sps",   package="SPSS")
  
# =============================================================================
# (2) Browsing data.frames
# =============================================================================

  # let's create a working copy of our third data.frame
  df <- myThirdDf

  str(df) # gives a very brief description of the data
  names(df) # gives the name of each variables
  summary(df) # gives some very basic summary statistics for each variable
  head(df) # shows the first few rows
  tail(df) # shows the last few rows.
  head(df, n = 20)

  # We can select columns by names
  df[,c('carat','cut','color')]
  # columns by names and rows
  df[1:5,c('carat','cut','color')]
  # or rows that meet certain criteria on a variable
  # for the same three columns
  df[df$carat>0.21,c('carat','cut','color')]
  df[df$carat>0.21,1:3]
  # or the total data.frame
  df[df$carat>0.21,]

# =============================================================================
# (3) Building data.frames
# =============================================================================

  # set a global option here
  options(stringsAsFactors = FALSE)

  # let's create 2 vectors first
  names <- c("karoly", "balint", "dori")
  is.character(names)
  gender <- c(2,2,1)
  class(gender)

  # create a data.frame out of them
  myBuiltData1 <- data.frame(names, gender)

  # bind the vectors together by columns
  myBuiltData2 <- cbind(names, gender)
  # notice that this is not a data.frame yet
  class(myBuiltData2)
  # let's transforme it
  myBuiltData2 <- data.frame(myBuiltData2)

  # bind the data.frames together by rows
  myBuiltData3 <- rbind(myBuiltData1, myBuiltData2)
  # binding vectors creates a matrix but binding data.frames preserves the data.frame

  # let's add some new variables
  myBuiltData3$id <- c(1,2,3,4,5,6)
  # let's reorder the columns
  myBuiltData3 <- cbind(myBuiltData3$id, myBuiltData3$name, myBuiltData3$gender)
  # since we operated on the vectors of the data.frame it became a matrix again
  # and lost the names of the columns
  myBuiltData3
  colnames(myBuiltData3) <- c("id", "name", "gender")
  myBuiltData3 <- data.frame(myBuiltData3)

  # let's create an other data.frame very fast
  id <- c(1,2,3,4,5,6,7)
  education <- c(1,2,2,1,2,2,3)
  myBuiltData4 <- data.frame(id, education)

  # let's merge them
  myBuiltData5 <- merge(myBuiltData3, myBuiltData4, by.x = "id", by.y = "id", all.x = T, all.y = T)
  myBuiltData6 <- merge(myBuiltData3, myBuiltData4, by.x = "id", by.y = "id", all.x = T, all.y = F)

  # removing observations with NA
  myBuiltData7 <- myBuiltData5[!is.na(myBuiltData5$name),]

# =============================================================================
# EXCERCISE
# =============================================================================
# create a data.frame with the following variables:
# "id", "name", "gender", "hairColor"
# it shall contain at least 5 observations
# chose the units of observatoin from participants of the class
# name it as: myTestData
# =============================================================================

  id <- c(1,2,3,4,5)
  name <- c("Zoli", "Flora", "Borte", "Karoly", "Palma")
  gender <- c(1,2,2,1,2)
  hairColor <- c(1,1,1,2,3)
  
  myTestData <- data.frame(id, name, gender, hairColor)
  
# =============================================================================
# (4) Handling data.frames
# =============================================================================

  # removing columns / vraibles
  myBuiltData8 <- myBuiltData7
  myBuiltData8$id <- NULL

  # removing duplicates
  myBuiltData9 <- unique(myBuiltData8)

  # recoding variables
  myBuiltData10 <- myBuiltData9
  myBuiltData10$gender[myBuiltData10$gender == 2] <- 0
  myBuiltData10$gender[myBuiltData10$gender == 1] <- 1

  # renameing variables
  names(myBuiltData10)[2] <- "female"

  # selecting subsets
  myBuiltData11 <- myBuiltData10[myBuiltData10$female == 0,]

  # sorting the data
  myBuiltData12 <- myBuiltData10[order(myBuiltData10$education, decreasing=T),]
  myBuiltData12 <- myBuiltData12[order(myBuiltData12$female, decreasing=T),]

# =============================================================================
# (5) Saving the data
# =============================================================================
  
  # saving the data
  # one data object
  save(myBuiltData12, file="myBuiltData12.RData")
  
  # mroe data object
  save(myBuiltData1, myBuiltData2, myBuiltData3, file="myBuiltData1-3.RData")
  
  # clean up the global environment
  rm(data, my_first_data_frame)
  
  # save the complete globl environment
  save.image("dataFrames.Rdata")
  
# =============================================================================
# EXCERCISE
# =============================================================================
# Take your myTestData
# delete the names, because it shall be anonym
# create a 'man' dummy variable from the gender variable
# remove the gender variable
# create factor variable for 'hairColor' with labels for the colors
# myTestData$hairColor <- factor(myTestData$hairColor,
#                         levels = c(1,2,3),
#                         labels = c("red", "blue", "green"))
# save your brand new data
# =============================================================================

  head(myTestData)
  myTestData$name <- NULL
  head(myTestData)
  
  myTestData$man <- myTestData$gender
  myTestData$man[myTestData$man == 1] <- 1
  myTestData$man[myTestData$man == 2] <- 0
  myTestData$gender <- NULL
  head(myTestData)
  
  myTestData$hairColor <- factor(myTestData$hairColor,
                          levels = c(1,2,3),
                          labels = c("braun", "braunish", "braunishish"))
  
  class(myTestData$hairColor)
  str(myTestData)
  
  # we shall create a factor from 'man'
  
  
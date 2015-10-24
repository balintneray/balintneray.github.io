# =============================================================================
# Lab 1: Introduction to R basics
# =============================================================================

# Balint Neray  |   MTA-TK-SZI  |   neray.balint@tk.mta.hu

# =============================================================================
# (1) Script and Console
# =============================================================================

  # R is a programming language that executes commands in two ways:
  # 1. you can type code in the console (next to the 'greater than' arrow) and hit enter (return on Mac)
  # 2. or you can type on a script (like this one) and send the lines of code to the console
  # to do so you hit control+enter (or command+return on Mac)
  # You could also highlight the lines and hit 'Run' in the upper right corner of this window.
  # You could run a single line doing the same when standing in the line in your script.

  # Unless you are working on very simple calculations,
  # you should always save your code as a script using a ".R"
  # Sometimes it makes sense to save you're global environment (top right window)
  # or at least important parts of it.

  # Every line that begins with '#' is ignored by the console, it is a comment.
  # So you can add comments to your code without generating errors.
  # It's good practice to comment everything in your code, especially for beginners
  # It is garanteed that you will forget what you wanted exactly
  # and how you fixed some problems that emerged.
  # Morevover, ideally, somebody who knows R should be able to take your code and
  # understand exactly what it's doing, without you there to explain to them.

# =============================================================================
# (2) R as a calculator
# =============================================================================

  # R works with numbers as a calculator does.
  # For instance, you can do basic arithmetics:
  5+7
  4*3
  5^2

  # Besides working with numbers in R, R has a number of functions built in.
  # For instance sqrt() gives the square root of its argument.
  sqrt(16)

  # ALL FUNCTIONS have a name, curly brakets and arguments in these brakets.
  # The function that gives the positive square root of a number called 'sqrt'
  # The argument it takes is a vector - that can have only one element: a single number this time.

  # If you are unfamiliar with a function, you should ALWAYS read the documentation what it does.
  # You could do this in three different ways:
  ?sqrt
  help(sqrt)
  # or type 'sqrt' to search field of the help window in the bottom right

  # What does exp() do?
  exp(3)

  # You can nest functions in one another.
  log(exp(3))
  # Note that log() computes the natural logarithm.
  # This, you can change with passing on a second argument, which gives the appropriate base.

  log(exp(3), base = 10)
  log(exp(3), 10)
  log(10, exp(3))
  log10(exp(3))

  # R preserves the order of operations.
  (5+7)*2+3

# =============================================================================
# (3) Different types of objects in R
# =============================================================================

  # (3.1) Vectors

  # You have seen how to inquire about a function that you know the name of.
  # What happens when you don't know the name of a function?
  # Chances are that there is one with the functionality you desire.
  # For instance, you could want to calculate the arithmetic mean of a vector.

  (3 + 4 + 5)/3

  # Let's see if there is a function called 'mean'
  ?mean

  # But how do you pass these numbers to the function so that it understands that it is a vector?
  # In R you create things, called "objects", by a process called assignment.
  # For value assignment in R you use '<-'
  # R also understands '=' but DO NOT use it, it is really bad practice.
  # This SHOULD NOT be read as "x equals 7", which will result in confusion later.
  # Instead, the single equals sign means "takes the value" or "is assigned the value."

  ?c

  my_first_vector <- c(3,4,5)
  my_first_vector
  class(my_first_vector)
  is.numeric(my_first_vector)
  mean(my_first_vector)

  # Note that a new R object appeared in your 'Global Environment' in the upper right corner.
  # Here are some other objects.
  dates <- c("1986-02-16","2001-09-25")
  dates
  class(dates)

  # Be aware that R is case sensitive!
  names1 <- c("Anna","Imre","Bence")
  names2 <- c("anna","imre","bence")
  # Let's compare the elemetns of the 2 vectors
  names1 == names2
  # Let's see the difference between "=" and "=="
  names2 = names1
  names1 == names2

  # Let's restore the original
  names1 <- c("Anna","Imre","Bence")
  names2 <- c("anna","imre","bence")

  # You can refer to elements of these vectors of by using [ ]:
  names1[1]
  names1[2:3]
  names1[c(1,3)]
  names1[2:length(names1)]

  # Note that the function length() gives the length of the object back.
  # That is the number of elements within the object
  # This is not only true for vectors, but for other objects as well.
  length(names1)

  # You can list all the objects floating around in your Global Environment or workspace.
  ls()
  # And you can remove paricular objects.
  rm(dates)
  # Or all of them.
  # rm(list=ls())

  # Three main types of vectors
  # Numeric
  # Character
  # Logical

  # my_first_vector was numeric, names was character vector.

  # Here is an easy way of creating sequences:
  1:10
  10:1
  0.2:11

  # The seq() function gives you more flexibility
  my_sequence <- seq(from = 1, to = 10, by = 2)
  my_sequence
  class(my_sequence)
  # in a short form
  seq(1,10,2)
  seq(1,10,0.5)

  # The rep() function repeats the same value a number of times.
  rep(x = 10, times = 6)
  rep(10,6)
  rep(c(1,10),6)
  names1 <- c("Anna","Imre","Bence")
  rep(names1,3)

  # Logical vectors
  logical1 <- c(T,F,T,F,T,T,T)
  logical2 <- c(TRUE,FALSE,TRUE,FALSE,TRUE,TRUE,TRUE)
  logical3 <- c(1,0,1,0,1,1,1)
  logical1
  logical2
  logical3

  # Note, that logical3 is a numeric vector. This is how you can transform it to a logical one:
  class(logical3)
  logical3 <- as.logical(logical3)
  logical3
  # Let's check its class (type):
  class(logical3)
  # The conversion works backwards:
  logical3 <- as.numeric(logical3)
  logical3
  class(logical3)

  # You can also test the type of vectors using the functions below:
  is.numeric(logical3)
  is.logical(logical3)
  is.character(logical2)
  is.character(names1)
  is.numeric(my_first_vector)

  # How about combining different types of data in one vector?
  my_mixed_vector <- c(names1,as.numeric(logical3),logical1)
  my_mixed_vector
  class(my_mixed_vector)
  # Note that as soon as you have a character vector in the mix, all data will be interpreted as character.
  # The quotationmarks around the elemets let you know this.
  # In case you use quotation marks, anything in between those marks will be interpreted as character.
  disguised_numeric <- c("1","2","3")
  disguised_numeric
  as.numeric(disguised_numeric)
  class(disguised_numeric)
  # Here is what would happen with a character vector if you wanted to convert it into a numeric vector.
  as.numeric(names1)
  as.numeric(c(names1,1))

  # The type of vectors is important, because it determines what functions can do with the data.
  # For instance, you can calculate the mean of only numeric vectors
  mean(my_mixed_vector)
  mean(as.numeric(my_mixed_vector))
  mean(as.numeric(my_mixed_vector), na.rm = T)

  # Let's print the mixed vector again and understand what happened
  my_mixed_vector
  mean(as.numeric(my_mixed_vector), na.rm = T) == 5/7

# =============================================================================
# (4) Other object classes
# =============================================================================

  # In addition to vectors, there are four major object classes in R:
  # matrices, arrays, dataframes, and lists.
  # Each of these is typically made up of numeric, character, and logical vectors.
  # In R everything is a vector.
  # This post nicely explains why vectorization can be advantageous in R
  # http://www.noamross.net/blog/2014/4/16/vectorization-in-r--why.html

# =============================================================================
# (5) Matrix: Two dimensional (row x column) object
# =============================================================================

  # It's always row by column (NOT column by row)
  my_first_vector <- c(1,2,3)
  my_second_vector <- c(5,7,0)
  my_first_matrix <- cbind(my_first_vector,my_second_vector)
  my_second_matrix <- rbind(my_first_vector,my_second_vector)
  my_first_matrix
  my_second_matrix
  ?cbind
  # cbind() and rbind() are functions that are very handy and you will use them over and over again

  # Here are other ways of creating simple matrices.
  ?matrix
  my_third_matrix <- matrix(my_first_vector, nrow = 2, ncol = 3)
  matrix(my_first_vector, nrow = 3, ncol = 2)
  matrix(my_first_vector, nrow = 2, ncol = 3)

  matrix(1:9,3,3,byrow = T)
  matrix(1:9,3,3,byrow = F)
  matrix(1,3,3)

  # You can refer to rows, columns and elements of a matrix in the following way:
  # Here is the first row:
  my_first_matrix
  my_first_matrix[1,]
  # First column:
  my_first_matrix[,1]
  # First element (first row, forst column)
  my_first_matrix[1,1]

  # How could you inquire about the size of a matrix?
  dim(my_first_matrix)
  dim(my_second_matrix)

# =============================================================================
# (6) Dataframe: a data frame is also a two-dimensional (row x column) object
# =============================================================================

  # Within each column the data must be of the same type (numeric, character, logical).
  # Unlike matrices, though, different columns can have different data types.
  # Regression and other statistical functions usually use dataframes.
  # We shall come back to this later

  # Use as.data.frame() to convert matrices to dataframes.
  my_firs_dataframe <- as.data.frame(my_first_matrix)
  my_firs_dataframe

  # Note how this object shows up in your workspace.

  # You can refer to rows, columns and elements of a data frame in the following way:
  # Here is the first row:
  my_firs_dataframe[1,]
  # First column:
  my_firs_dataframe[,1]
  # First element:
  my_firs_dataframe[1,1]

  # Would it be possible to use the names of the columns?
  my_firs_dataframe$my_first_vector
  # Note that this ($) doesn't work for matrices

  # Also note that a natural way of building data.frames from scratch
  # is to start from vectors then a matrix then the data frame.

# =============================================================================
# (7) Lists: set of objects, each of which can be a different type
# =============================================================================

  # A single list could have 5 vectors, 4 matrices, 3 arrays,
  # 2 dataframes, and who knows what else
  names1 <- c("a", "b", "c")
  my_first_list <- list(my_first_vector,
                        my_second_vector,
                        my_firs_dataframe,
                        names1)

  # Note how the indexing is done, and the difference between [[ ]] and [ ]
  my_first_list[1]
  my_first_list[[1]]
  my_first_list[[1]][2]

# =============================================================================
# (8) Arrays: Three dimensional (row x column x height) object
# =============================================================================

  # Working with arrays can be a pain in the butt.
  # You've been warned

  array1 <- array(0, dim = c(2, 2, 3))
  array1

# =============================================================================
# EXCERCISE
# =============================================================================
# Create 'a' 'b' and 'c' objects from numbers of your choice
# Do different calculations with these objects and create new objects from
# the results
# Now create a single vector from all your results
# Inspect its class
# Make sure it is numeric
# Convert it into a matirx
# Convert the matrix into a data.frame
# Print the number in the first column and second row
# Multiply the number in the first column and first row with the number in the
# the first column and third row
# =============================================================================
  
  a <- 4
  b <- 2
  c <- 7
  
  d <- a+b
  e <- a*b*c
  f <- c-a
  g <- a/b
  
  vector <- c(d,e,f,g)
  
  matrix <- as.matrix(vector)
  
  data <- as.data.frame(matrix)
  
  data[2,1]
  
  h <- data[1,1]
  i <- data[3,1]
  
  j <- h*i
  j
  

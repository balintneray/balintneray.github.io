# =============================================================================
# Lab 5: Functions
# =============================================================================

# Balint Neray  |   MTA-TK-SZI  |   neray.balint@tk.mta.hu

# =============================================================================

# This is just a very short introduction to some useful R functions

# Writing loops is useful when programming but not particularly easy all the time.
# There are some functions which implement looping to make life easier.
# lapply: Loop over a list and evaluate a function on each element
# sapply: Same as lapply but try to simplify the result
# apply: Apply a function over the margins of an array
# tapply: Apply a function over subsets of a vector
# mapply: Multivariate version of lapply

# Let's see some examples

# =============================================================================
# (1) apply
# =============================================================================

# It is most often used to apply a function to the rows or columns of a matrix
# It can be used with general arrays, e.g. taking the average of an array of matrices
# It is not really faster than writing a loop, but it works in one line!
str(apply)
x <- matrix(rnorm(200), 20, 10)
apply(x, 2, mean)
# where x is the input matrix, 2 refers to the columns of the matrix, and mean is the
# function we'd like to execute (function within the function)

# =============================================================================
# (2) lapply
# =============================================================================

# takes three arguments: a list X, a function (or the name of a function) FUN,
# and other arguments via its ... argument. If X is not a list, it will be coerced to a list
# using as.list.
y <- list(a = 1:5, b = rnorm(10))
y
lapply(y, mean)

# =============================================================================
# (3) sapply
# =============================================================================
# will try to simplify the result of lapply if possible.
# If the result is a list where every element is length 1, then a vector is returned
# If the result is a list where every element is a vector of the same length (> 1), a
# matrix is returned.
# If it can’t figure things out, a list is returned
z <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
lapply(z, mean)
sapply(z, mean)

# =============================================================================
# (4) Control your own work flow
# =============================================================================

# Control structures in R allow you to control the  flow of execution of the program,
# depending on runtime conditions. Common structures are:
# if, else: testing a condition
# for: execute a loop a fixed number of times
# while: execute a loop while a condition is true
# repeat: execute an infinite loop
# break: break the execution of a loop
# next: skip an interation of a loop
# return: exit a function

# The beauty of R is that you can create you're own functions
# Functions are created using the function() directive and are stored as R objects just
# like anything else. In particular, they are R objects of class “function”.

# Creating a function is something like
# f <- function(<arguments>) {
#  Do something interesting
# }

# But all these should be the subject of an other workshop
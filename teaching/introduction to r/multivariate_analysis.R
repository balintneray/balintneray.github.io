# =============================================================================
# Lab 4: Multivariate analysis
# =============================================================================

# Balint Neray  |   MTA-TK-SZI  |   neray.balint@tk.mta.hu

# =============================================================================

# Regression
# And some plotting
# http://www.statmethods.net/advgraphs/parameters.html

# =============================================================================
# (0) LIB and WD
# =============================================================================

  # (0.1) libraries
  require(foreign)
  require(MASS)
  require(gclus)
  require(aod)
  require(ggplot2)
  require(lme4)
  require(stargazer)
  require(gridExtra)
  
  # (0.2) working directory
  rm(list=ls())
  whoareyou <- "balintneray"
  path <- paste0("/Users/",whoareyou,"/Copy/My_Projects/MTA_R_workshop/")
  setwd(path)
  
  # (0.3) original data
  data <- read.dta("http://www.ats.ucla.edu/stat/data/crime.dta")
  # We will use the crime dataset that appears in Statistical Methods for Social Sciences,
  # Third Edition by Alan Agresti and Barbara Finlay (Prentice Hall, 1997). The variables
  # are state id (sid), state name (state), violent crimes per 100,000 people (crime),
  # murders per 1,000,000 (murder), the percent of the population living in metropolitan areas
  # (pctmetro), the percent of the population that is white (pctwhite), percent of population
  # with a high school education or above (pcths), percent of population living under
  # poverty line (poverty), and percent of population that are single parents (single).
  # It has 51 observations. We are going to use poverty and high school education or above.

# =============================================================================
# (1) Linear regression
# =============================================================================

  # create a working copy
  d <- data
  # Let's describe the data first
  summary(d)
  
  # the dependent variable
  table(d$crime, useNA = 'ifany')
  # is numeric?
  class(d$crime)
  hist(d$crime)
  # seems to be a little skewed
  # let's put a normal curve on it
  h <- hist(d$crime, breaks=10, col='lightblue', xlab="Crime",
            main="Distribution with normal curve")
  xfit <- seq(min(d$crime), max(d$crime), length=max(d$crime))
  yfit <- dnorm(xfit, mean=mean(d$crime), sd=sd(d$crime))
  yfit <- yfit*diff(h$mids[1:2])*length(d$crime) # where 'mids' are the coorinates of the bars
  lines(xfit, yfit, col='blue', lwd=3, lty='solid')
  # where 'wd' is the line width
  # and lty is the line type
  # for more graphical options see 'par'.
  
  # this was very not-normal
  # let's remove that 1 ugly outlier
  d <- d[d$crime < 2000,]
  
  # let's see it again
  h <- hist(d$crime, breaks=10, col='lightblue', xlab="Crime",
            main="Distribution with normal curve")
  xfit <- seq(min(d$crime), max(d$crime), length=max(d$crime))
  yfit <- dnorm(xfit, mean=mean(d$crime), sd=sd(d$crime))
  yfit <- yfit*diff(h$mids[1:2])*length(d$crime) # where 'mids' are the coorinates of the bars
  lines(xfit, yfit, col='blue', lwd=3, lty='solid')
  
  # way better
  # one more thing to complete our eyeball-test:
  # let's shift the mean to the median of the scale
  yfit <- dnorm(xfit, mean=median(d$crime), sd=sd(d$crime))
  yfit <- yfit*diff(h$mids[1:2])*length(d$crime) # where 'mids' are the coorinates of the bars
  lines(xfit, yfit, col='red', lwd=3, lty='dotted')
  
  # The linear regression model assumes that the residuals are normally distributed. The
  # functions qqnorm, qqline and qqplot can be used to test this
  # Note that we used different functions and (and package) during the previous lab.
  qqnorm(d$crime)
  qqline(d$crime)
  qqplot(d$poverty, d$crime)
  qqplot(d$pcths, d$crime)
  
  # we can plot the relations
  # first, we shall create a new data.frame with the particular variables
  dPlot <- cbind(d$poverty, d$pcths, d$crime)
  dPlot <- data.frame(dPlot)
  colnames(dPlot) <- c("poverty", "edu", "crime")
  dPlot$crime <- as.numeric(dPlot$crime)
  dPlot$poverty <- as.numeric(dPlot$poverty)
  dPlot$edu <- as.numeric(dPlot$edu)
  
  # let's create a useful plot for our model
  # to describe the pairwise realtions between the variables
  dPlotCor <- cor(dPlot)
  dPlotColor <- dmat.color(dPlotCor)
  cpairs(dPlot,
         panel.colors = dPlotColor,
         lower.panel = panel.smooth,
         pch = 19,
         gap = 0.5,
         lwd = 2,
         col = palette(gray(seq(0.49, 0.99, len = 50))),
         cex = 2,
         cex.labels = 1,
         main = "Descriptive relations")
  
  # let's do it for the wholw data
  # just for the sake of practicing
  dPlotCor <- cor(d[,3:9])
  dPlotColor <- dmat.color(dPlotCor)
  cpairs(d[,3:9],
         panel.colors = dPlotColor,
         lower.panel = panel.smooth,
         pch = 19,
         gap = 0.5,
         lwd = 2,
         col = palette(gray(seq(0.49, 0.99, len = 50))),
         cex = 2,
         cex.labels = 1,
         main = "Descriptive relations")
  
  # Linear regression models can be estimated by the linear model function lm().
  # Inspect the help function of lm() frst.
  ?lm
  
  # basic model with poverty
  model1 <- lm(crime ~ poverty, data = d)
  summary(model1)
  
  # and then with pcths
  model2 <- lm(crime ~ poverty + pcths, data = d)
  summary(model2)
  
  # To include interaction terms, products of variables are usually added to the
  # model specification.
  model3 <- lm(crime ~ poverty + pcths + poverty*pcths, data = d)
  summary(model3)
  
  # extracting coefficients
  coeffs = coefficients(model3)
  coeffs
  
  # extracting the R-square from the summary
  R <- summary(model3)$r.squared
  R
  
  # extracting the predicted values with confidence intervals
  predVal <- predict(model3, d, interval="confidence")
  predVal
  
  # extracting the residuals
  resid <- resid(model3)
  resid
  
  # An important and elegant function is plot(model), where the argument model is an
  # estimated linear model obtained with the lm() function. It produces four plots
  # to check the assumptions of linearity, normality and constant variance, and it
  # generates indications of outliers. 
  plot(model3)
  # we can see that state 1, 20 and 26 are problematic according to the forst 3 figures.
  # their residuals are far from the fitted line
  # they divate from the normal QQ-plot
  # and the variance of their residual is the further from the constant
  # figure 4 suggests further outliers: state 1, 18 and 49.

# =============================================================================
# EXCERCISE
# =============================================================================
# In order to get more robust results, remove state 1 from the data
# Run the models again generating new objects,
# and evaluate the fit of the final model again.
# =============================================================================

  # d <- d[d$sid != 1,]
  # or ...
  # d <- d[2:50,]
  
# =============================================================================
# (2) Logistic regression
# =============================================================================

  # clear up and set wd again
  rm(list=ls())
  whoareyou <- "balintneray"
  path <- paste0("/Users/",whoareyou,"/Copy/My_Projects/MTA_R_workshop/")
  setwd(path)
  
  # get the original data
  data <- read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
  
  # make a working copy
  d <- data
  
  # Here we are interested in how variables, such as GRE (Graduate Record Exam scores),
  # GPA (grade point average) and prestige of the undergraduate institution effect
  # admission into graduate school. The response variable, admit/don't admit,
  # is a binary variable.
  # There are three predictor variables: gre, gpa and rank.
  # We will treat the variables gre and gpa as continuous.
  # The variable rank takes on the values 1 through 4.
  # Institutions with a rank of 1 have the highest prestige, while those with
  # a rank of 4 have the lowest
  
  # what is there?
  head(d)
  # get mean and SD,
  # yes we ask for mean, even if there are non-continous variables
  sapply(d, mean)
  sapply(d, sd)
  
  # since it is a binary outcome, let's create a crosstab to further describe the data
  xtabs(~admit + rank, data = d)
  
  # now let's create a factor from the rank variable
  d$rank <- factor(d$rank)
  
  # 'glm' estimates a logistic regression model (generalized linear model)
  ?glm
  
  # let's see the models
  model1 <- glm(admit ~ gre, data = d, family = "binomial")
  summary(model1)
  
  model2 <- glm(admit ~ gre + gpa, data = d, family = "binomial")
  summary(model2)
  
  model3 <- glm(admit ~ gre + gpa + rank, data = d, family = "binomial")
  summary(model3)
  
  # We can use the confint.default function to obtain confidence intervals
  # based on standard errors
  confint.default(model3)
  
  # We can test for an overall effect of rank using the wald.test function of the aod library.
  # The order in which the coefficients are given in the table of coefficients is the same as
  # the order of the terms in the model. This is important because the wald.test function
  # refers to the coefficients by their order in the model.
  # b supplies the coefficients,
  # while Sigma supplies the variance covariance matrix of the error terms,
  # finally Terms tells R which terms in the model are to be tested,
  # in this case, terms 4, 5, and 6, are the three terms for the levels of rank.
  wald.test(b = coef(model3), Sigma = vcov(model3), Terms = 4:6)
  # p-value of 0.00011 indicating that the overall effect of rank
  # is statistically significant.
  
  # We can also test additional hypotheses about the differences in the coefficients
  # for the different levels of rank. Below we test that the coefficient for rank=2 is
  # equal to the coefficient for rank=3. The first line of code below creates a vector l
  # that defines the test we want to perform. In this case, we want to test the difference
  # (subtraction) of the terms for rank=2 and rank=3 (this is the 4th and 5th terms in the model).
  # To contrast these two terms, we multiply one of them by 1, and the other by -1.
  # The other terms in the model are not involved in the test, so they are multiplied by 0.
  # The second line of code below uses L=l to tell R that we wish to base the test on the vector l
  # (rather than using the Terms option as we did above).
  
  l <- cbind(0, 0, 0, 1, -1, 0)
  wald.test(b = coef(model3), Sigma = vcov(model3), L = l)
  # p-value of 0.019 is indicating that the difference between the coefficient for
  # rank=2 and the coefficient for rank=3 is statistically significant.
  
  # let's see the difference between the two last parameters
  l <- cbind(0, 0, 0, 0, 1, -1)
  wald.test(b = coef(model3), Sigma = vcov(model3), L = l)
  # not surprisingly, there is none
  
  # We can also exponentiate the coefficients and interpret them as odds-ratios.
  # They might make a little more sense that way.
  exp(cbind(OR = coef(model3), confint(model3)))
  
  # We can also use predicted probabilities to hel understand the model.
  # First need to create a new data frame
  # with the values we want the independent variables to take on to create our predictions.
  # Here we will be interested in the effect of rank while holding the rest of the variables
  # at their mean.
  newdata1 <- with(d, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))
  # view data frame
  newdata1
  
  # !These objects must have the same names as the variables in your logistic regression above
  # (e.g. in this example the mean for gre must be named gre)!
  # Now that we have the data frame we want to use to calculate the predicted probabilities,
  # we can tell R to create the predicted probabilities. The first line of code below is quite compact,
  # we will break it apart to discuss what various components do.
  # The newdata1$rankP tells R that we want to create a new variable in the dataset (data frame)
  # newdata1 called rankP, the rest of the command tells R that the values of rankP should be
  # predictions made using the predict( ) function.
  # The options within the parentheses tell R that the predictions should be based on the analysis
  # model3 with values of the predictor variables coming from newdata1 and that the type of prediction
  # is a predicted probability (type="response").
  newdata1$rankP <- predict(model3, newdata = newdata1, type = "response")
  # Although not particularly pretty, this is a table of predicted probabilities.
  newdata1
  # We can see that the predicted probability of being accepted into a graduate program
  # is 0.52 for students from the highest prestige undergraduate institutions (rank=1), and 0.18 for students
  # from the lowest ranked institutions (rank=4), holding gre and gpa at their means.
  
  # We can do something very
  # similar to create a table of predicted probabilities varying the value of gre and rank.
  summary(d)
  # We are going to plot these, so we will create 100 values of gre between 200(!) and 800,
  # at each value of rank (i.e., 1, 2, 3, and 4).
  newdata2 <- with(d, data.frame(gre = rep(seq(from = 200, to = 800, length.out = 100),
                  4), gpa = mean(gpa), rank = factor(rep(1:4, each = 100))))
  head(newdata2)
  
  # The code to generate the predicted probabilities is the same as before, except we are also going to ask
  # for standard errors so we can plot a confidence interval. We get the estimates on the link scale and back
  # transform both the predicted values and confidence limits into probabilities.
  newdata3 <- cbind(newdata2, predict(model3, newdata = newdata2, type = "link", se = TRUE))
  newdata3 <- within(newdata3, {
    PredictedProb <- plogis(fit)
    LL <- plogis(fit - (1.96 * se.fit))
    UL <- plogis(fit + (1.96 * se.fit))
  })
  
  head(newdata3)
  # Now graphs of predicted probabilities to understand and/or present the model.
  # We will use the ggplot2 package for graphing.
  # Below we make a plot with the predicted probabilities,
  # and 95% confidence intervals.
  ggplot(newdata3, aes(x = gre, y = PredictedProb)) + geom_ribbon(aes(ymin = LL,
        ymax = UL, fill = rank), alpha = 0.2) + geom_line(aes(colour = rank), size = 1)
  
# =============================================================================
# (3) Hierarchical logistic regression with lme4
# =============================================================================

  # (0.2) working directory
  rm(list=ls())
  whoareyou <- "balintneray"
  path <- paste0("/Users/",whoareyou,"/Copy/My_Projects/MTA_R_workshop/")
  setwd(path)
  
  # (0.3) the complete data created by the 03 script
  load("regression_data.Rdata")
  
  # let's see the key variables
  str(d)

  # this is going to be a 2 level analysis
  # where the level 1 observations are friendship diyads among students
  # and the level 2 observations are schoolse dependent variable is 
  # friendship retention (measurement): retained / not retaoned
  # as explanatory / control variables there are variables 
  # to measure the composition of the dyad as well as the school context
  # since it is a 5-wave longitudinal data there are time-varying variabls too
  
  # removing NA on free lunch
  # bcause it is an imprtant control
  # creating a working copy
  d <- d[!is.na(d$homogeneFreeLunch),]
  
  m11 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m11)
  
  m12 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + existenceSofar
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m12)
  
  m13 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + existenceSofar
               + merge
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m13)
  
  # 
  m14 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + existenceSofar
               + merge
               + bestFriend
               + mutual
               + sharedFriends
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m14)
  
  # 
  m15 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + existenceSofar
               + merge
               + bestFriend
               + mutual
               + sharedFriends
               + egosEthnicProp1Third
               + egosEthnicProp3Third
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m15)
  
  # 
  m16 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + existenceSofar
               + merge
               + bestFriend
               + mutual
               + sharedFriends
               + egosEthnicProp1Third
               + egosEthnicProp3Third
               + homogeneFreeLunch
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m16)
  
  # 
  m17 <- glmer(measurement ~
               # race / ethnicity
               + WhiteBlack
               + WhiteHispanic
               + BlackBlack
               + BlackWhite
               + BlackHispanic
               + HispanicHispanic
               + HispanicWhite
               + HispanicBlack
               + wave
               + existenceSofar
               + merge
               + bestFriend
               + mutual
               + sharedFriends
               + egosEthnicProp1Third
               + egosEthnicProp3Third
               + homogeneFreeLunch
               + senderFreeLunch
               + (1 | group),
               data = d,
               family = binomial("logit"),
               control = glmerControl(optimizer = "bobyqa"),
               nAGQ = 1)
  summary(m17)
  
  # writing out the resutls to txt
  stargazer(m11, m12, m13, m14, m15, m16, m17, type="text",
            title="Models",
            align=TRUE,
            dep.var.labels=c("Friendship retention"),
            out="TESTPRINT.txt")
  
  # with our own labels to html
  stargazer(m11, m12, m13, m14, m15, m16, m17,  type="html",
            title="Models",
            align=TRUE,
            dep.var.labels=c("Friendship retention"),
            covariate.labels=c("WhiteBlack",
                               "WhiteHispanic",
                               "BlackBlack",
                               "BlackWhite",
                               "BlackHispanic",
                               "HispanicHispanic",
                               "HispanicWhite",
                               "HispanicBlack",
                               "wave2-3",
                               "wave3-4",
                               "wave4-5",
                               "existenceSofar",
                               "merge",
                               "bestFriend",
                               "mutual",
                               "sharedFriends",
                               "EgosEthnicPropUnder15%",
                               "EgosEthnicPropAbove30%",
                               "homogeneFreeLunch",
                               "senderFreeLunch"
            ),
            out="TESTPRINT2.html")

  # Let's create more descriptive plots to intrudoce the results
  # We are going to plot the friendship rentenrion of the different
  # dyads in between every wave (4-times)
  
  # creating one variable for all the 9 different dyads
  
  # the original variables have to be nueric because we have to use them for math
  # note that the levels and numbers are shifted
  d$WhiteWhite <- as.numeric(d$WhiteWhite)
  d$WhiteBlack <- as.numeric(d$WhiteBlack)
  d$WhiteHispanic <- as.numeric(d$WhiteHispanic)
  d$BlackBlack <- as.numeric(d$BlackBlack)
  d$BlackWhite <- as.numeric(d$BlackWhite)
  d$BlackHispanic <- as.numeric(d$BlackHispanic)
  d$HispanicHispanic <- as.numeric(d$HispanicHispanic)
  d$HispanicBlack <- as.numeric(d$HispanicBlack)
  d$HispanicWhite <- as.numeric(d$HispanicWhite)
  
  # recreate the original dummies in numeric form
  d$WhiteWhite[d$WhiteWhite == 1] <- 0
  d$WhiteBlack[d$WhiteBlack == 1] <- 0
  d$WhiteHispanic[d$WhiteHispanic == 1] <- 0
  d$BlackBlack[d$BlackBlack == 1] <- 0
  d$BlackWhite[d$BlackWhite == 1] <- 0
  d$BlackHispanic[d$BlackHispanic == 1] <- 0
  d$HispanicHispanic[d$HispanicHispanic == 1] <- 0
  d$HispanicBlack[d$HispanicBlack == 1] <- 0
  d$HispanicWhite[d$HispanicWhite == 1] <- 0
  
  table(d$WhiteWhite)
  table(d$WhiteBlack)
  table(d$WhiteHispanic)
  table(d$BlackBlack)
  table(d$BlackWhite)
  table(d$BlackHispanic)
  table(d$HispanicHispanic)
  table(d$HispanicBlack)
  table(d$HispanicWhite)
  
  # recode
  d$WhiteWhite[d$WhiteWhite == 2] <- 1
  d$WhiteBlack[d$WhiteBlack == 2] <- 2
  d$WhiteHispanic[d$WhiteHispanic == 2] <- 3
  d$BlackBlack[d$BlackBlack == 2] <- 4
  d$BlackWhite[d$BlackWhite == 2] <- 5
  d$BlackHispanic[d$BlackHispanic == 2] <- 6
  d$HispanicHispanic[d$HispanicHispanic == 2] <- 7
  d$HispanicBlack[d$HispanicBlack == 2] <- 8
  d$HispanicWhite[d$HispanicWhite == 2] <- 9
  
  # Creating full dyad type plot
  # The new dyad type variable
  d$dyadType <- d$WhiteWhite + d$WhiteBlack + d$WhiteHispanic +
    d$BlackBlack + d$BlackWhite + d$BlackHispanic +
    d$HispanicHispanic + d$HispanicWhite + d$HispanicBlack
  d$dyadType <- factor(d$dyadType, levels=c(1,2,3,4,5,6,7,8,9),
                       labels=c("WW", "WB", "WH",
                                "BB", "BW", "BH",
                                "HH", "HB", "HW"))
  d$friendshipRetention <- d$measurement
  d$friendshipRetention <- factor(d$friendshipRetention, levels=c(0,1), labels=c("not retained", "retained"))
  
  # Subsets based on waves
  dw1 <- d[d$wave==1,]
  dw2 <- d[d$wave==2,]
  dw3 <- d[d$wave==3,]
  dw4 <- d[d$wave==4,]
  
  # pdf() will tell R that there is going to be some graphical output that we want to save somewhere
  # then we create the 4 plot with qplot() in a grid format where the grid is based on the retention dummy
  # the expand_limits() as an extra argument specifies the max height of y.
  # finally, dev.off() will close the graphical device so R know to write out everythin that is
  # in between the the pdf() and dev.off() commands.
  pdf(file="/Users/balintneray/Copy/My_Projects/MTA_R_workshop/dyad_plots_all.pdf", width=11.69, height=8.27)
  plot1 <- qplot(dyadType, data=dw1, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w1-2)",
                 xlab="Dyad type",
                 ylab="N (3466)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,2800))
  plot2 <- qplot(dyadType, data=dw2, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w2-3)",
                 xlab="Dyad type",
                 ylab="N (4228)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,2800))
  plot3 <- qplot(dyadType, data=dw3, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w3-4)",
                 xlab="Dyad type",
                 ylab="N (5496)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,2800))
  plot4 <- qplot(dyadType, data=dw4, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w4-5)",
                 xlab="Dyad type",
                 ylab="N (5609)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,2800))
  grid.arrange(arrangeGrob(plot1, plot2, plot3, plot4, nrow=2, ncol=2)) # main = "title"
  dev.off()
  
  # Dyad type plot without WhiteWhite dyad
  # ... because that one big bar made the whole plot ugly /
  # diffucult to interpret
  d$dyadType2 <- d$WhiteBlack + d$WhiteHispanic +
    d$BlackBlack + d$BlackWhite + d$BlackHispanic +
    d$HispanicHispanic + d$HispanicWhite + d$HispanicBlack
  d$dyadType2 <- factor(d$dyadType2, levels=c(2,3,4,5,6,7,8,9),
                        exclude=NULL,
                        labels=c("WB", "WH",
                                 "BB", "BW", "BH",
                                 "HH", "HB", "HW"))
  d2 <- d[!is.na(d$dyadType2),]
  d2w1 <- d2[d2$wave==1,]
  d2w2 <- d2[d2$wave==2,]
  d2w3 <- d2[d2$wave==3,]
  d2w4 <- d2[d2$wave==4,]
  
  pdf(file="/Users/balintneray/Copy/My_Projects/MTA_R_workshop/dyad_plots_no_whitewhite.pdf", width=11.69, height=8.27)
  plot5 <- qplot(dyadType2, data=d2w1, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w1-2)",
                 xlab="Dyad type",
                 ylab="N (1085)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,450))
  plot6 <- qplot(dyadType2, data=d2w2, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w2-3)",
                 xlab="Dyad type",
                 ylab="N (1242)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,450))
  plot7 <- qplot(dyadType2, data=d2w3, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w3-4)",
                 xlab="Dyad type",
                 ylab="N (1728)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,450))
  plot8 <- qplot(dyadType2, data=d2w4, fill=friendshipRetention, geom="bar",
                 main="N of friendship dyads (w4-5)",
                 xlab="Dyad type",
                 ylab="N (1761)") + guides(fill=F) + facet_grid(friendshipRetention ~ .) + expand_limits(y=c(0,450))
  grid.arrange(arrangeGrob(plot5, plot6, plot7, plot8, nrow=2, ncol=2)) # main = "title"
  dev.off()
  
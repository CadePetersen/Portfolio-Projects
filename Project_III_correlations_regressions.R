#Homework 3
#Author: Cade H. Petersen
#Date: 09/27/22
#Topic: correlations and regressions

# Using the heights dataset from the modelr package you will build a regression model and explain the results. 
#brary(readr)
#omework_3_heights <- read_csv("Survey Files/R Files/Homework/homework_3_heights.csv")


# 1. Build a regression model that includes height, weight, and age. In a comment in the code answer the following questions.

#   a. What is the R square?

library(modelr)
heights
df <- heights
omit.na(df)
View(df)


plot(df$height, df$weight, df$age, pch = 20, col = "lightblue")
text(paste("Correlation:", round(cor(df$height, df$weight, df$age), 2)), x = 250, y = 50)

mod1 <- lm(df$weight, df$age ~ df$height, data = df1)
summary(mod1)
#Above was my first attempt.. Forgot to omit NA properly!

df1 <- na.omit(df)
View(df1)

mod2 <- lm(height ~ weight + age, data = df1)
summary(mod2)

#a. We have an R^2 of 0.2186. 


#   b. If someone is 1 inch taller than average, how much more money does the model estimate that they will make?  NOTE: in the dataset documentation it says that height is in feet but I am fairly sure it is 

#Well first I need to get the average.. so simply;
median(df1$height) #I believe median more accurately depicts the true average. So I'll use this.
mean(df1$height) #Basically the same.. nice..

#So we want to view our prediction and look at a height of 68 inches for their income.
df1$preds <- predict(mod2, df1) 
View(df1)
#Uhh.. so this aint that simple, we need to view only the height of 68 specifically to pull a median/average.

median(df1$income[3027:3569])
median(df1$income[3620:4133])
#b. So I looked at the dataframe and noticed at height 68, rows 3620 to 4133 are of height 68. So to get the
# median/average income I simply indexed the median command to take the average of these combined rows. So the
# average income at height 68 is $24735.5 as opposed to $33000 at height 67 "rows 3027 to 3569".


# 2. Build a regression model that includes height, weight, age, marital, sex, education and afqt. Answer the following questions
#   a. What is the R square? 

df1
View(df1)

mod3 <- lm(height ~ weight + age + marital + sex + education + afqt, data = df1)
summary(mod3)
#a. We have an r^2 of 0.5805, so about 60% of the correlation of height can be accounted for from these 6 variables.


#   b. Provide a theory that describes why height and weight are no longer significant after adding the new variables.

#b. Well, if we look at the coefficients we see that we have a higher t-value on the factors afqt, sex, education, beyond
# just weight. My theory is because sexfemale has a drastic impact on height as on average males are significantly taller.
# For afqt, intelligence is correlated to socioeconomic status, thus I theorize that the nourishment is higher in higher afqt
# people which directly correlates to someones height. The same logic for afqt I theorize is applicable for education, as
# there is significant evidence that nutrition has a correlation to ones height in a given sample.
 


# 3. From the previous model add the predictions to the dataset and create the following ggplot

#   a. Predicted values on the X-axis
library(ggplot2)
df1

#   b. Income on the Y-axis
ggplot(df1, aes(x = df1$preds, y = df1$income)) +
  geom_point()

#     HINT: use the predict function i.e. heights$preds <- predict(fancyModel, heights)
#   c. color by education

#   d. facet_grid with sex and marital
#     HINT: facet_grid(sex ~ marital)

cluster <- kmeans(df1$height, centers = 1
                  
df1$cluster_weight <- cluster[["cluster"]]

ggplot(df1, aes(x = preds, y = income, colour = education)) + 
  geom_point() +
  facet_grid(sex ~ marital)


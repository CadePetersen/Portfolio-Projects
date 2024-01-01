#Homework 1: R basics and chi-squared
#Author: Cade H. Petersen
#Date: 09/08/2022


# In this assignment you will run chi-square models to discover the food that was responsible for a poisoning outbreak.  
# You can use this commented script to write your R code. 
# When you have completed the assignment export your assignment.R file and upload it to canvas before class next week

## This data set describes a food poisoning outbreak and is from the epitools package.
##Please complete the following:

# 1. install the epitools package, the load the epitools library. Then read in the dataset oswego
install.packages("epitools")
library(epitools)
library(readr)

homework_1_oswego <- read_csv("Survey Files/R Files/Homework/homework_1_oswego.csv")
View(homework_1_oswego)

df <- homework_1_oswego  #Made a copy in case I mess up..
colnames(df) #We have 11 "food types". I am not considering drinks as food types, I apologize if this is misinterpreted!
str(df) #Mmmk, all are characters, which makes sense as this is binomial type of problem..

# 2. Create a series of fourfold plots for each food type and ill (our outcome) to discover the food that made everyone sick
fourfoldplot(with(df, table(ill, baked.ham))) #29 yes, 17 no for who ate it

fourfoldplot(with(df, table(ill, spinach))) #26 yes, 17 no for who ate it

fourfoldplot(with(df, table(ill, mashed.potato))) #23 yes, 14 no for who ate it

fourfoldplot(with(df, table(ill, cabbage.salad))) #18 yes, 10 no for who ate it

fourfoldplot(with(df, table(ill, jello))) #16 yes, 7 no for who ate it

fourfoldplot(with(df, table(ill, rolls))) #21 yes, 16 no for who ate it

fourfoldplot(with(df, table(ill, brown.bread))) #18 yes, 9 no for who ate it

#fourfoldplot(with(df, table(ill, milk)))   Not considering these three as 
#fourfoldplot(with(df, table(ill, water)))   "food types", as per instruction.
#fourfoldplot(with(df, table(ill, coffee)))

fourfoldplot(with(df, table(ill, cakes))) #27 yes, 13 no for who ate it

fourfoldplot(with(df, table(ill, vanilla.ice.cream))) #43 yes, 11 no for who ate it
#Who can resist vanilla ice cream... based on the plots, this is our culprit!!

fourfoldplot(with(df, table(ill, chocolate.ice.cream))) #25 yes, 22 no for who ate it

fourfoldplot(with(df, table(ill, fruit.salad))) #4 yes, 2 no for who ate it
#Let's be real, are we surprised this many people didn't eat this??


# 3. When you find the culprit run a chi.square test on with ill as your outcome
chisq.test(df$ill, df$vanilla.ice.cream)
#Well, we can say that since our p-value > .05 that we fail to reject the null hypothesis.
#Where our H0: Vanilla ice cream is suspected to have caused the food poisoning. 


# 4. Export and upload Assignment.R to canvas

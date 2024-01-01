#Homework 2
#Author: Cade H. Petersen
#Date: 09/15/2022
#Topic: tidyverse and t-tests

#For this homework you are asked to look at dataset of penguins. You will create summary stats, boxplots and run t-tests to see if there are differences in penguins based on their sex

#Install the "palmerpenguins" and the "tidyverse" packages. Then load these libraries

#library(readxl)
#homework_2_penguins <- read_excel("Survey Files/R Files/Homework/homework_2_penguins.xlsx")
#View(homework_2_penguins)

#install.packages("palmerpenguins") 

library(palmerpenguins) 
library(tidyverse)

#Load the penguins data using:
data("penguins")
view(penguins) #Uhh, this is the same as the imported dataset? I'll just go with this

df <- (penguins) #Made a copy in case of potential errors.
view(df)

#Then complete the following:

# 1. Using dplyr create a summary dataset that shows the average of bill_length_mm, 
# bill_depth_mm, and flipper_length_mm (There are two ways to handle missing(NA) values)

#Note: I assume you mean a summary dataset that shows the averages between male/female?
library(dplyr)
?dplyr #So I can find the website link to recall..

str(penguins) #Don't see any problems with the structure..


df_summ <- df %>%  #Makes our summ dataset.
  group_by(sex) %>% #pipes that we want to look at the averages between male/female.
  filter(sex != "NA") %>% #Because we have some NA data, lets negate it out for logical reasons.
  summarise(
    AveBillLength = mean(bill_length_mm, na.rm = TRUE),
    AveBillDepth = mean(bill_depth_mm, na.rm = TRUE),
    AveFlipperlength = mean(flipper_length_mm, na.rm = TRUE),
  )
view(df_summ)

#or....
#penguins %>%
#  group_by(species) %<%
#  summarise(
#    AveBillLength = mean(bill_length_mm, na.rm="TRUE"),
#    AvebillDepth = same...
#    AveFlipperLength = same...
#  )


# 2. Create boxplots that compare penguins by sex for bill_length_mm,
# bill_depth_mm, and flipper_length_mm

#Okay, so I forgot all about the commands so I'm going to refer to that handy-dandy link you sent.
library(ggplot2) 

#Because we have NA's in sex, we want to use tidyverse to pipe these out
df %>%
  filter(!is.na(sex)) %>% # filters out the NA values.
  ggplot(aes(x = sex, y = bill_length_mm, fill = sex)) + 
  xlab("Sex of Penguin") +
  ylab("Average Length in mm") +
  ggtitle("Boxplot of average mm length in bills between sex") +
  geom_boxplot()

df %>%
  filter(!is.na(sex)) %>% 
  ggplot(aes(x = sex, y = bill_depth_mm,
             fill = sex)) + 
  xlab("Sex of Penguin") +
  ylab("Average Depth in mm") +
  ggtitle("Boxplot of average mm depth in bills between sex") +
  geom_boxplot()

df %>%
  filter(!is.na(sex)) %>% 
  ggplot(aes(x = sex, y = flipper_length_mm, 
             fill = sex)) + 
  xlab("Sex of Penguin") +
  ylab("Average Flipper Length in mm") +
  ggtitle("Boxplot of average flipper length in mm between sex") +
  geom_boxplot()

#Looks pretty complicated, but with the guides and experience this came easy! I did struggle on filtering
# The NA's, but after a long time of pondering forums I figured it out!


# 3. Run t.tests to compare penguins by sex for bill_length_mm, bill_depth_mm, and flipper_length_mm

# Sigh.. I found this out too late, but to show my process I won't change my code above..
# But I can make a new DF that omitts the NA's! DUH.. So I utilized this code in this last question.

df2 <- na.omit(df)
view(df2) #Confirming it works..

# The sole reason I hate rigorous proofs and hail the all-mighty R for making this such a simple task.
# Note; We know if p-value < .05 then there is a sig difference

t.test(bill_length_mm ~ sex, data = df2)
 #since p-value < .05, there is significant evidence to support our H0, that is there is sig evidence
 #on average bill length differs between penguins sex. By a group mean of 42.09697 for female, and 
 # 45.85476 for male.
 
t.test(bill_depth_mm ~ sex, data = df2)
 #since p-value < .05, there is significant evidence to support our H0, that is there is sig evidence
 #on average bill depth differs between penguins sex. By a group mean of 16.42545 for female, and 
 # 17.89107 for male. Which arguably is not noticeable to any sane-human-being on this earth.. but 
 # not the statistician.. OH NO, the statistician sees all.

t.test(flipper_length_mm ~ sex, data = df2)
 #since p-value < .05, there is significant evidence to support our H0, that is there is sig evidence
 #on average flipper length differs between penguins sex. By a group mean of 197.3636 for female, and 
 # 204.5060 for male. Duh, 0.000002336 < .05..

#So we can conclude, if a statistician is looking at these penguins with some binoculars, the birds are
#doomed to prejudice in their gender being assumed by the statistician with a significant confidence level.
#How-ever, there is a significant difference in all three variables between sex.. but in reality the
# difference is fairly minute (my-NOOT), albeit a reality.

#See ya next week!
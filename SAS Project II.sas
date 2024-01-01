filename githubT url 'https://raw.githubusercontent.com/JackStat/6003Data/master/Titanic.txt';
proc import datafile=githubT dbms=dlm out=Titanic replace; 
delimiter='09'x; 
getnames=yes; 
guessingrows=5000; 
run; 


*First we want to look at the variables in the dataset, their formats, and other attributes;
proc contents data=Titanic replace order=varnum;
run;

*looking at the top 5 rows;
proc print data=Titanic (obs=5);
run;


* to see the values in the columns;
proc iml;
use Titanic;
   read all var "Survived";
Survivors = unique(Survived);
print Survivors;

*proc format takes a numeric variable and makes it a character variable;

proc format;
	value Ridefmt
		0="died"
		1="survived"
		;
run;

//so now we want to make our frequency table of the survived variable 

proc freq data=Titanic;
tables Survived;
run;


// now we run our chi-squared test and show a freuqncy table that includes both the survived and sex variables.

proc freq data=Titanic;
tables sex*Survived / chisq;
run;
* With the test stats = 891 and p less than .0001 there is a significant assiociation between sex and who survived;
* of all the people 64.76% were male and survived. within the female survivors only 35.24%;

// now for our frequency table

ods graphics on;
proc freq data=Titanic;
tables sex*Survived / chisq plots=freqplot;
run;

// now our plot that shows it as a percent rather than a frequency to show relationship between the survived and sex variable

ods graphics on;
proc freq data=Titanic;
 tables sex*Survived / plots=(freqplot(scale=percent));
run;

// now for our odds ratio tests between the survived and sex variable

proc freq data=Titanic;
tables sex*Survived / chisq plots=freqplot;
exact or;
run;

// now we want to run a logistic regression with the sex variable predicting the surival outcome

proc logistic data=Titanic;
   model Survived=Titanic sex DL2 grade2;
   OUTPUT OUT=PROB2 PREDICTED=PHAT;
run;

proc logistic data=Titanic;
   model Survived=sex;
   OUTPUT OUT=PROB PREDICTED=PHAT;
run;

//NOTE: I failed on this step above, I wasnt able to figure it out after some attempts and unfortunately the lecture isnt appearing on the zoom recordings as of current

// now if I had succeded, I would then want to check the correctness of the logistic regression model via the next code

Correct=(RideClass=Survived);

run;


// as stated above, the results of the chi=squared, odds ratio tests, and logistic regression are shown above but to summarize we have 
* With the test stats = 891 and p less than .0001 there is a significant assiociation between sex and who survived;
* of all the people 64.76% were male and survived. within the female survivors only 35.24%;




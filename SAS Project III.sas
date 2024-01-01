/* Note too-self: This is the format needed for commenting out blocks of code, also 'f3' is our hotkey for running code. */           

/* Cade H. Petersen  -  10/27/22   - Assignment Three; T-Test, Correlation, and Regression */


/* 1: Find the correlation between these four variables: fixedacidity, residualsugar, ph, price. What two variables have the highest correlation? */

/* 1.1: First I uploaded our data, and titled it 'ww' for whitewines... */
filename gith url 'https://raw.githubusercontent.com/kevin-greenberg/FA_21_stats_package/main/data/whitewines.csv';
proc import datafile= gith dbms=csv out=ww replace;
datarow=2; getnames=yes;
run;


/* 1.2: Now I wanted to look at the summary of our dataframe via 'proc contents'. */
proc contents data=ww order=varnum;
run;

proc means data = ww;
run;

/* 1.3: Now we run the correlations between the four variables. */
proc corr data=ww;
var fixedAcidity residualSugar pH Price;
with fixedAcidity residualSugar pH Price;
run;
/* 1.4: So we can see that the two variables that have the highest correlation is pH and Price at 0.09913, and then a close second is fixedAcidity and residualSugar. We recall the closer to 1, the more correlated
 our variables are, thus this is a low correlation but inuitively it makes sense as older wines tend to cost more "age produces higher pH". */





/* 2: Create a binary column based on the price of the wine. Wines equal to or greater than 31.42 should be considered Expensive and anything else is classified as Cheap. */

/* 2.1: So the code below creates our binary column based on the price of the wine, where we can see that the list starts with the cheapest and the bottom rows are the expensive ones. */
proc means data=ww;
class price;
var price;
run;

proc sort descending
run;

/* 2.2: Now we want to title the wines equal to or greater than 31.42 as expensive, else cheap. 
     Now I tried several different codes, watched the lecture, and checked the lecture code and couldn't figure out how to do the "class" portion in SAS so I couldnt figure this out.
     How-ever I'll include my code so you know that I've put a great amount of effort trying to do these parts of the problems. */

data ww;
	set ww
	binclass = price > 31.42

proc means data=ww;
var fixedAcidity residualSugar pH Price;
Class price;
run;

proc means data=ww;
var price;
Class fixedAcidity residualSugar pH Price;
WHERE >31.42 = 'expensive' OR <31.23 = 'cheap';
output out=expensiveandcheapmeans mean=price mean=price;
run;





/* 3: Run a t-test to determine if the amount of alcohol determines the binary class of wine. Is there a significant different between the two groups? */

/* 3.1: Now I tried several different codes, watched the lecture, and checked the lecture code and couldn't figure out how to do the "class" portion in SAS so I couldnt figure this out.
     How-ever I'll include my code so you know that I've put a great amount of effort trying to do these parts of the problems. */

proc ttest data=ww plots=all;
var fixedAcidity residualSugar pH Price;
Class price;
run;





/* 4: Create a boxplot with the binary class of wine as the grouping variable in relation to any variable you want to explore. */

/* 4.1: Since the question says we can use "any variable you want to explore" I decided to curiously look into the the different in alcohol to the cost.. so interestingly enough, there is a slight
    trend in how alchohol is higher in the more expensive whitewines, how-ever in general this philosophy would'nt hold up as a rule of thumb.. but a good way to quickly shop alcohol in a pinch to get drunk! */

proc sgplot data=ww;
 hbox alcohol / category=price;
 label alcohol='Alcohol levels'
 price='costs';
run;





/* 5: Run a regression that predicts the price of the wine with the 3 variables you think best predict the price.
                (Make your best guess, you won’t lose points for picking the variables. I am more interested in your ability to run the regression). */

/* 5.1: So we ran the regression, using the pH, residualSugar, and fixedAcidity variables based on our correlation plot above. Now for my best guess; We have an R^2 of 0.0224, so we're just about
   explaining 22% of our variance with our variables. How-ever pH isn't a p-value <.0001 where the other two are so we would want to look for another third variable that more accurately predicts the
   price of the wine from our other 13 variables. Notice that 22% isn't account for much of the r^2, so clearly other variables that were'nt suggested in the homework's 4 variables likely account for 
   better price predictors. */

proc reg data=ww;
model price = pH residualSugar fixedAcidity;
run;

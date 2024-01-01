/*
Program: class1.sas
Author(s): Kevin Greenberg
Date: 09/28/2022
Project: Homework #4 
*/

/* First we want to load in our data set using the code below. */

data Snacks;
	set sashelp.Snacks;
	run;

proc print data=Snacks;
run;

/* Now that I have looked at the data, I know what columns I need to subset the table to retain only the columns of interest. */

data Snacks;
	set sashelp.Snacks;
keep Product Price;
run;

/* Now we want to sort the data from most expensive to least expensive. */

proc sort data=Snacks;
by descending Price;
run;


/* Now we want to get a table that has snacks that are more expensive than 2 dollars. */

/* First create a new dataset. */

data snacks2;
	set sashelp.Snacks;
run;


/* Second sort the dataset; */

proc sort data=snacks2;
by descending Price;
run;




/*Third add a ranking variable; */

data snacks2;
	set sashelp.Snacks;

Rank=_N_;
run;



/* Fourth and last we print out a table that has snacks that're more expensive than two dollar. */

proc print data=snacks2;
where Rank >=2.00;
run;



/* Now we wish to get the descriptive stats for the quantity sold by the product, and also group by if the product was advertised or not and if the day was a holiday or a regular day. */

proc means data=snacks2;
var QTYSold Product;
Class Price;
run;

proc means data=snacks2;
var Holiday Product;
Class Advertised;
run;

/* Now weirdly enough, we see that the most expensive product was Wheat Crackers at 3.49. For the product with the most quantities sold it was Baked Potato chips and the day(s) this occured 
 was late november and all of december! I guess people feel giving around that time! */


/* Extra credit: Print the top 10 most expensive products. */

proc print data=snacks2;
where Rank >=10;
run;

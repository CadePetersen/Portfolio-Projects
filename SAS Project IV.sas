/* Note: This is the format needed for commenting out blocks of code, also 'f3' is our hotkey for running code. */           

/* Cade H. Petersen  -  11/13/22   - Assignment Four; PROC-SQL */


/* 1: Join the three tables. */

/* 1.1: First we read in our data, and titled them. */
filename githubT url 'https://raw.githubusercontent.com/kevin-greenberg/FA_21_stats_package/main/data/userprofile.csv';
proc import datafile=githubT
     out=up
     dbms=csv
     replace;
     getnames=yes;
     guessingrows=5000; 
run;


filename githubT url 'https://raw.githubusercontent.com/kevin-greenberg/FA_21_stats_package/main/data/parking.csv';
proc import datafile=githubT
     out=parking
     dbms=csv
     replace;
     getnames=yes;
     guessingrows=5000; 
run;


filename githubT url 'https://raw.githubusercontent.com/kevin-greenberg/FA_21_stats_package/main/data/ratings.csv';
proc import datafile=githubT
     out=ratings
     dbms=csv
     replace;
     getnames=yes;
     guessingrows=5000; 
run;


/* 1.2: Now we look at the top 30 observations. */
proc print data=up (obs=30);
run;


proc print data=parking (obs=30);
run;

*Take a look at the top 30 observations;
proc print data=ratings (obs=30);
run;

/* 1.3: Now we use PROC SQL to join all the tables together. */
PROC SQL;
CREATE TABLE joined AS
SELECT *
FROM up a
LEFT JOIN parking b ON a.userID=b.placeID 
LEFT JOIN ratings c ON c.placeID=a.userID
;
quit;

proc print data=joined (obs=30);
run;
/* I spent a few hours on this, I could not get it after many failed attempts for the sake of my sanity I'm going to proceed ahead with question two.. I'm sorry, I dont understand the problem. */



/* 2: Create a table that shows the mean combined rating for each userID (This will be the mean(sum of the rating, food_rating, and service_rating columns)). */

/* 2.1: Using our lecture notes, we can create a table that shows the mean combined rating for each UserID/PlaceID */
PROC SQL;
CREATE TABLE AVG as

SELECT
    userID
	, (rating / food_rating) AS foodAVG   
	, (rating/ service_rating) AS serviceAVG
 /* , mean(column_name) AS name
	, sum(column_name) AS name
	, max(column_name) AS name
	, min(column_name) AS name */

FROM ALL
GROUP BY userID
HAVING foodAVG > 0.200
ORDER BY foodnAVG desc
;

quit;


/* 3: From this table, find out which placeID (restaurant) has the highest mean combined rating? */
/* I couldn't figure out the join table (after looking at lecture/link/and trial-errors) so I wasnt able to compute my above code for 2, how-ever since the observations are only 30, I'd guess it's placeID; 132584


/* 4: Do restaurants with valet parking, public parking, general parking(labeled as yes) or no parking have the highest mean combined rating? */
/* Resturaunts with valet parking have the highest mean combined rating by computing simple mean averages learnt in applied stats */


/* 5: With the original table that you created in step 1, when you group by activity and personality, which group gives the highest mean service rating? */

/* 5.1: So we just have to change the GROUP BY, to specifiy the new columns. */

*/ 5.2: by activity */
PROC SQL;
CREATE TABLE AVG as

SELECT
    userID
	, (rating / food_rating) AS foodAVG   
	, (rating/ service_rating) AS serviceAVG
 /* , mean(column_name) AS name
	, sum(column_name) AS name
	, max(column_name) AS name
	, min(column_name) AS name */

FROM ALL
GROUP BY activity
HAVING foodAVG > 0.200
ORDER BY foodnAVG desc
;

/* 5.3: By personality */
PROC SQL;
CREATE TABLE AVG as

SELECT
    userID
	, (rating / food_rating) AS foodAVG   
	, (rating/ service_rating) AS serviceAVG
 /* , mean(column_name) AS name
	, sum(column_name) AS name
	, max(column_name) AS name
	, min(column_name) AS name */

FROM ALL
GROUP BY personality
HAVING foodAVG > 0.200
ORDER BY foodnAVG desc
;

/* Since I wasnt able to figure out the table combining, I'm not certain but looking at our tables I'd guess activity. */

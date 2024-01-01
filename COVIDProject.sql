select *
from COVIDProject.dbo.CovidDeaths
where continent is not null
order by 3,4
/* Note; we used "where continent is not null" as to remove from our data continents as a location from our data set as we're interested in specific countries. */

--select *
--from COVIDProject.dbo.CovidVaccinations
--order by 3,4

-- Select data that we're going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
from COVIDProject..CovidDeaths
order by 1,2


-- Looking at Total Cases VS. Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRatio
from COVIDProject..CovidDeaths
where location like '%states%'
and continent is not null
order by 1,2
-- So the above code tells us the likelihood of Mortality if you contract COVID in this case, the U.S. "Interests me as I'm American".


-- Now let's look at the Total Cases VS. Population

SELECT location, date, population, total_cases, (total_cases/population)*100 as ConfirmedCovid
from COVIDProject..CovidDeaths
where location like '%states%'   /* EDIT; We can easily comment this block out for global population */
and continent is not null
order by 1,2
-- Similarily, the above code shows us the ratio of people that were positive for COVID in the states in our time interval.



-- I'm interested in seeing globally what countries have the highest contraction rate at their peaks
SELECT location, population, max(total_cases) as PeakContracted, max((total_cases/population))*100 as PercentPopulationWithCovid
from COVIDProject..CovidDeaths
where continent is not null
group by location, population
order by PercentPopulationWithCovid desc
-- Looking at the results, we have a few observations that we can examine. Initially we want to ask, are the lowest PercentPopulationWithCovid
-- isolated "such as on an island or relatively obsolete" or more interestingly we see that the U.S. is ranked at number 9 as the highest rate,
-- so is there certain variables that are more correlated that is causing this "such as the reporting measures we have in play, or the readily
-- accessiblity the population has to frequent testing facilities, or if there's something more sinister like a lack of measures in play enforcing
-- the population to prevent higher contraction rates. 

-- Regardless, this brings up a lot of interesting questions that we can use Data Analysis for in hypothesis testing.


-- Similarily to the above table, we can also look at a table showing which countries globally have the highest total death count.
SELECT location, max(cast(total_deaths as int)) as TotalMortalityCount
from COVIDProject..CovidDeaths
where continent is not null
group by location
order by TotalMortalityCount desc
/* Note; We used "cast" because if we look at the data set for CovidDeaths we note that total_deaths was causing issues because of the datatype of that Column. So we needed to convert it to an Integer.. */



-- Now let's seperate the data in subsets by each continent, which shows us the continents with the highest death counts.
SELECT continent, max(cast(total_deaths as int)) as TotalMortalityCount
from COVIDProject..CovidDeaths
where continent is not null
group by continent
order by TotalMortalityCount desc
-- Again, we're presented with many possible hypothesis we can test as a result of this SQL Data Exploration of the data we pulled.
-- We can test an absurd amount of possible specific questions off this code alone, the screaming question would be looking at the variables that have a 
-- correlation in death count, which would help us determine why North America is disporpotionally represented.





/* Global Numbers:  */

SELECT date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 
	as DeathRatio
from COVIDProject..CovidDeaths
where continent is not null
group by date
order by 1,2
-- So the above code tells us the death ratio across the world on each specific date that our data set recorded.

-- The above begs the question, what's the average then? 
SELECT sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 
	as DeathRatio
from COVIDProject..CovidDeaths
where continent is not null
order by 1,2
-- So slightly over 2%. 


-- Now, let's look at the other table "our vacination table", and join the two!
select *
from COVIDProject..CovidDeaths dea
join COVIDProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date


-- Let's examine what's the total amount of people in the world that've been newly vaccinated (per-day by location).
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingCountVaccinated
from COVIDProject..CovidDeaths dea
join COVIDProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3
-- our partition here is our rolling count that takes the consecutive number and sums the two.
/* Note; we could've used "sum(cast(... as int)" instead of convert, just another way of doing the same thing really. */


-- We need a CTE for our code above in order to take the rolling count and see it's ratio. So let's do that!
with PopuVsVacc (continent, location, date, population,new_vaccinations, RollingCountVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingCountVaccinated
from COVIDProject..CovidDeaths dea
join COVIDProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingCountVaccinated/population)*100 as NowVacc
from PopuVsVacc
-- Now we're able to look at the newly vaccinated people per location by date, and then look at the compounding rolling count and then ultimately the new now vaccinated column.

-- ALTERNATIVELY, we could've just made a temp table like so..
drop table if exists #PercentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_vaccinations numeric,
RollingCountVaccinated numeric
)
insert into #PercentPopulationVaccinated
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingCountVaccinated
from COVIDProject..CovidDeaths dea
join COVIDProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
select *, (RollingCountVaccinated/population)*100 as NowVacc
from #PercentPopulationVaccinated
/* Note; the line (drop table if exists) is useful when messing around with a temp table, because in my case I made a few mistakes and had to remake the table. */




-- Lastly, let's create a view to store our data for data visualizations "like tableau".

create view PercentPopulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as RollingCountVaccinated
from COVIDProject..CovidDeaths dea
join COVIDProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

-- We can even look at the view as a table..
select *
from PercentPopulationVaccinated
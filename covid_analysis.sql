CREATE DATABASE covid_analysis;

SELECT datname FROM pg_database;

SELECT COUNT(*)
FROM coviddeaths;

SELECT * 
FROM coviddeaths
LIMIT 5;

-- Query 1 (Looking At Data)

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
WHERE continent IS NOT NULL
ORDER BY location, date;


-- Query 2 (Likelihood of Dying if you Catch Covid in United States)

SELECT location, date, total_cases, total_deaths,
       (total_deaths::numeric / total_cases) * 100 AS death_percentage
FROM coviddeaths
WHERE location LIKE '%States%'
  AND continent IS NOT NULL
ORDER BY location, date;

-- Query 3 (Here, I'm looking at the top 10 percent of daily infected)
SELECT date, new_cases,
       (new_cases::numeric / population) * 100 AS daily_percent_infected
FROM coviddeaths
WHERE location LIKE '%States%'
  AND continent IS NOT NULL
ORDER BY new_cases DESC NULLS LAST
LIMIT 10;

-- Query 4 (Here, I'm using Group By and Order By to see countries and thier infection
-- rates vs population)
SELECT location, population,
       MAX(total_cases) AS highest_infection_count,
       MAX((total_cases::numeric / population) * 100) AS percent_population_infected
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY percent_population_infected DESC;

-- Query 5 (Highest Death Counts)
SELECT location, MAX(total_deaths) AS total_death_count
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC NULLS LAST;
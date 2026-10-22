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


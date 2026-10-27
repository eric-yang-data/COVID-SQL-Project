-- Set Up (Run Once): CREATE DATABASE covid_analysis;

SELECT datname FROM pg_database;

SELECT COUNT(*)
FROM coviddeaths;

SELECT * 
FROM coviddeaths
LIMIT 5;

-- QUERIES ON DEATHS

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

-- Query 3: Top 10 single days for new US cases as a % of population
SELECT location AS country,
       date,
       new_cases,
       (new_cases::numeric / population) * 100 AS daily_percent_infected
FROM coviddeaths
WHERE location = 'United States'
  AND continent IS NOT NULL
ORDER BY daily_percent_infected DESC NULLS LAST
LIMIT 10;

-- Query 4 (Here, I'm using Group By and Order By to see countries and their infection
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

-- Query 6: Highest death percentage among infected people (countries with 100,000+ cases)
SELECT location AS country,
       MAX(total_cases) AS total_cases,
       MAX(total_deaths) AS total_deaths,
       (MAX(total_deaths)::numeric / NULLIF(MAX(total_cases), 0)) * 100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
HAVING MAX(total_cases) >= 100000
ORDER BY death_percentage DESC NULLS LAST
LIMIT 10;

-- Creating a View by using Join and Window Functions
CREATE OR REPLACE VIEW percent_population_vaccinated AS
SELECT dea.continent,
       dea.location,
       dea.date,
       dea.population,
       vac.new_vaccinations,
       SUM(vac.new_vaccinations) OVER (
           PARTITION BY dea.location
           ORDER BY dea.date
       ) AS rolling_people_vaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL;


-- Using View in a Query
SELECT *,
       (rolling_people_vaccinated::numeric / population) * 100 AS percent_vaccinated
FROM percent_population_vaccinated
WHERE location LIKE '%States%'
ORDER BY date;

SELECT * FROM percent_population_vaccinated LIMIT 10;

-- Query 7: Total deaths by continent
-- (continent totals are stored as rows where continent IS NULL, so that it'll filter out income groups and World)
SELECT location AS continent,
       MAX(total_deaths) AS total_death_count
FROM coviddeaths
WHERE continent IS NULL
  AND location NOT LIKE '%income%'
  AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY total_death_count DESC NULLS LAST;

-- Query 8: Global new cases, new deaths, and death percentage by day
SELECT date,
       SUM(new_cases) AS total_new_cases,
       SUM(new_deaths) AS total_new_deaths,
       (SUM(new_deaths)::numeric / NULLIF(SUM(new_cases), 0)) * 100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- Query 9: Global totals overall
SELECT SUM(new_cases) AS total_cases,
       SUM(new_deaths) AS total_deaths,
       (SUM(new_deaths)::numeric / NULLIF(SUM(new_cases), 0)) * 100 AS death_percentage
FROM coviddeaths
WHERE continent IS NOT NULL;

-- QUERIES ON VACCINATIONS

-- Query 10: Join deaths and vaccinations (one row per country per day)
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM coviddeaths dea
JOIN covidvaccinations vac
  ON dea.location = vac.location
 AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY dea.location, dea.date;





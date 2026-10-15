CREATE DATABASE covid_analysis;


SELECT datname FROM pg_database;

SELECT COUNT(*)
FROM coviddeaths;

SELECT * 
FROM coviddeaths
LIMIT 5;
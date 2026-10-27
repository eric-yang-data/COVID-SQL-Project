# COVID-SQL-Project

This Project was on analyzing data from Covid vaccines and deaths, to find numbers, probe insights, and try to better make sense of our data. In this project, I use data from Alex the Analyst's repository linked here:
(https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/CovidDeaths.xlsx and https://github.com/AlexTheAnalyst/PortfolioProjects/blob/main/CovidVaccinations.xlsx). Using PostgreSQL, I worked through question about infection rates, mortality, and vaccination rollout across about 85,0000 country-day records using multiple tools and techniques.


## Questions Answered

* How likely was a person to die after being infected, in a given country over time?
* What share of each country's population was infected, and which countries had the highest rates?
* Which countries and continents had the highest death counts?
* What were the global case and death numbers by day?
* How did vaccination rollout progress, measured as a running total per country?
* Is higher vaccination coverage associated with lower death rates?</ls>

## Tools Used
* Database: **PostgreSQL** (Postgres.app), queried from VS Code
* Data loading: **Python **(pandas, SQLAlchemy, psycopg2) to import the Excel files into PostgreSQL
* SQL concepts: **JOIN, GROUP BY, HAVING, aggregate functions, type casting, window functions (SUM() OVER (PARTITION BY ... ORDER BY ...)), views**

## How to Reproduce

1. Install PostgreSQL and create a database:
```sql
   CREATE DATABASE covid_analysis;
```
Download CovidDeaths.xlsx and CovidVaccinations.xlsx from the repo linked above and place them in the project folder.

Install the Python dependencies:
```python
bash
   pip install pandas sqlalchemy psycopg2-binary openpyxl
```

Load the data:
```bash
   python load_data.py
```

Run the queries in covid_analysis.sql against the covid_analysis database!

## Key Findings

**Infection rate**: **ANDORRA** had the highest share of its population infected at 17.13%, followed by **Montenegro** at 15.51% and **Czechia** at 15.22%.

**Death counts**: The United States recorded the highest total deaths at *576232*, while Mexico had the highest death percentage among infected people at 9.25%. Technically, Vanuatu and Yemen beat Mexico in death percentage, however since the sample size was so small -- Vanuatu with 4 cases, and Yemen with under 7000 -- it can be seen as heavily skewed. Meanwhile Mexico was 3rd, with a sample size of over 2.3 million.

**United States trend**: The worst single month for new cases was January 2nd, 2021 with about 0.9% of the population newly infected, equalling 300,000 new cases in a day.

**GLOBAL TOTALS**: There were over 150,000,000 total cases, 3 million deaths, and the global death percentage was around 2%.

**Death count By Continent**: Europe had the most amount of deaths at 1,016,750 deaths, followed by North America at 847,942. The continent with the fewest amount of deaths was Oceania with 1046 total deaths.

## Possible Limitation
Case and death counts depend on each country's testing and reporting practices, which vary widely.

## Author
**Eric Yang** | https://github.com/eric-yang-data/Eric-Yang-Data

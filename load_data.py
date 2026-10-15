import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql://postgres@localhost:5432/covid_analysis")

deaths = pd.read_excel("CovidDeaths.xlsx")
vax = pd.read_excel("CovidVaccinations.xlsx")

deaths.columns = deaths.columns.str.lower()
vax.columns = vax.columns.str.lower()

deaths.to_sql("coviddeaths", engine, index=False, if_exists="replace")
vax.to_sql("covidvaccinations", engine, index=False, if_exists="replace")

print("Loaded:", len(deaths), "death rows,", len(vax), "vaccination rows")
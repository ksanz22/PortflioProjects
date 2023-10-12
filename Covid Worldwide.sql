SELECT *
FROM PortfolioProject..CovidDeaths
ORDER BY 3,4

-- Select Data that we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
-- Some of the data in "Numeric" data type is actually float, thats why we need to convert it
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases,total_deaths, 
(CONVERT(float, total_deaths) / NULLIF(CONVERT(float, total_cases), 0)) * 100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
AND continent is not null
ORDER BY 1,2

-- Looking at Total Cases vs Population 
-- Shows what percentage of population got covid

SELECT location, date,population, total_cases, 
(CONVERT(float, total_cases) / NULLIF(CONVERT(float, population), 0)) * 100 AS PercentofPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
Where continent is not null
ORDER BY 1,2

--Looking at countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) as HighestInfectionCount, 
MAX((CONVERT(float, total_cases)) / NULLIF(CONVERT(float, population), 0)) * 100 AS PercentofPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
Where continent is not null
GROUP BY location, population
ORDER BY PercentofPopulationInfected DESC

-- Showing Countries with Highest Death Count per Population

SELECT location, MAX (cast(Total_Deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
Where continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC

--  Showing Continents with Highest Death Count per Population

SELECT continent, MAX (cast(Total_Deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location like '%states%'
Where continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC

-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, 
sum(cast(new_deaths as int)) /NULLIF(SUM (new_cases), 0) * 100 AS Deathpercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2



# Layoff Data Cleaning and Exploratory Analysis

This project demonstrates a full workflow for cleaning and analyzing a real-world layoff dataset using SQL. The process includes:
- Removing duplicates
- Standardizing data entries
- Handling missing and inconsistent values
- Performing exploratory data analysis (EDA)

## Folder Structure

- **Data-Cleaning-Project.sql**: Contains all the SQL code for data cleaning and EDA.
- **docs/**: Project explanation, methodology, and findings.
- **screenshots/**: Visuals of analysis, queries, or insights.
- **LICENSE**: Project license.

## Features

- Duplicate removal using CTE and row_number().
- Data standardization (trimming, normalization, handling nulls).
- Date formatting and fixing inconsistent values.
- Multiple aggregation queries for EDA (by company, industry, date, etc.).
- Deleting records with no relevant data.

## Running the Project

1. Clone this repository:
    ```
    git clone https://github.com/Ishantm07/layoff-data-cleaning-analysis.git
    ```

2. Import the SQL file (`Data-Cleaning-Project.sql`) into your SQL environment (e.g., MySQL Workbench).

3. Review the queries and adjust as needed for your layoff dataset.

4. Check `docs/` for detailed methodology and outcomes.

## Key Insights
- Largest layoffs by company, industry, country.
- Year-by-year and rolling monthly layoff analysis.
- Data quality improved dramatically after cleaning.


create database layoff;
select * from layoffs;


-- removing duplicate
-- standardising data
-- update and alter columns
-- removin row/columns


-- removing duplicate
create table layoff_2
like layoffs;
select * from layoff_2;

insert layoff_2
select * from layoffs;


with duplicate_cte as (
select *, 
row_number() over(partition by company, location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)
as row_num from layoff_2)

select * from duplicate_cte;


CREATE TABLE `layoff_3` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



select * from layoff_3;

insert layoff_3
select *, 
row_number() over(partition by company, location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions)
as row_num from layoff_2;
SET SQL_SAFE_UPDATES = 0;

delete from layoff_3
where row_num >1;


select * from layoff_3
where row_num >1;

-- Standardizing Data

update layoff_3
set company =  trim(company);


select * from layoff_3
where industry like "crypto%";


update layoff_3
set industry = 'Crypto'
where industry like 'Crypto%';

update layoff_3
set industry = 'Finance'
where industry like 'Fin%';

update layoff_3
set industry = null
where industry = '';

update layoff_3
set country = trim(trailing '.' from country)
where country like 'United States%';

select distinct country from layoff_3;


select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoff_3;	

update layoff_3
set `date` = str_to_date(`date`,'%m/%d/%Y');

alter table layoff_3
modify 	column `date` date;


select * from layoff_3
where industry is null;

select * from layoff_3
where company = 'Airbnb';


SELECT t1.industry, t2.industry
FROM layoff_3 t1
JOIN layoff_3 t2 
	ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;


update layoff_3 t1 
join layoff_3 t2 
	on t1.company = t2.company
set t1.industry = t2.industry    
where t1.industry is null
and t2.industry is not null;

select * from layoff_3 
where total_laid_off is null and
percentage_laid_off is null;

delete from layoff_3
where total_laid_off is null and
percentage_laid_off is null;

select * from layoff_3;

alter table layoff_3
drop column row_num;


-- Explorartory Data Analyis



select max(total_laid_off),max(percentage_laid_off)
from layoff_3;


select company, sum(total_laid_off) as total_laid
from layoff_3
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoff_3;

select industry, sum(total_laid_off) as total_laid
from layoff_3
group by industry
order by 2 desc;

select country, sum(total_laid_off) as total_laid
from layoff_3
group by country
order by 2 desc;


select year(`date`), sum(total_laid_off) as total_laid
from layoff_3
group by year(`date`)
order by 2 desc;

select stage, sum(total_laid_off) as total_laid
from layoff_3
group by stage
order by 2 desc;



select substring(`date`,1,7) as `Month`, sum(total_laid_off) as total_laid
from layoff_3
where substring(`date`,1,7) is not null
group by `Month`
order by sum(total_laid_off) desc;


with rolling_total as(
select substring(`date`,1,7) as `Month`, sum(total_laid_off) as total_laid
from layoff_3
where substring(`date`,1,7) is not null
group by `Month`
order by sum(total_laid_off) desc)

select `Month`, total_laid,sum(total_laid) over(order by `Month`) as rolling_off
from rolling_total;

select company, year(`Date`), sum(total_laid_off) as total_off
from layoff_3
group by company, year(`Date`)
order by 3 desc;

with company_year( company, `year`,total_off) as (
select company, year(`Date`), sum(total_laid_off) as total_off
from layoff_3
group by company, year(`Date`)),
company_rank as(

select *, dense_rank() over(partition by `year` order by total_off desc) as rnk from company_year
where `year` is not null)

select * from company_rank
where rnk <=5;



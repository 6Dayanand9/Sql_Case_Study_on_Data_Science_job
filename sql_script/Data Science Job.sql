select * from salaries;


/* 1. You're a Compensation analyst employed by a multinational corporation.
 Your Assignment is to Pinpoint Countries who give work fully remotely, 
for the title 'managers’ Paying salaries Exceeding $90,000 USD */

select * from salaries where salary_in_usd>90000 and job_title like "%Manager%" and remote_ratio=100;

select count(*) from salaries where salary_in_usd>90000 and job_title like "%Manager%" and remote_ratio=100;

/*2.AS a remote work advocate Working for a progressive HR tech startup who place their 
freshers’ clients IN large tech firms. you're tasked WITH Identifying top 5 Country Having 
greatest count of large (company size) number of companies.*/

select company_location,count(*) as large_company_per_country 
from salaries where company_size = "L" and experience_level="EN"
group by company_location order by large_company_per_country desc limit 5;

/*3. Picture yourself AS a data scientist Working for a workforce management platform. 
Your objective is to calculate the percentage of employees. 
Who enjoy fully remote roles WITH salaries Exceeding $100,000 USD, Shedding light ON the attractiveness of high-paying 
remote positions IN today's job market.*/

set @total_count= (select count(*) from salaries where salary_in_usd>100000);
set @Remotecount= (select count(*)from salaries where salary_in_usd>100000 and remote_ratio=100);
set @percentage = (((@Remotecount)/(@total_count))*100);

select @percentage 'percentage of people working remotely and having salary>100000$';

/*4.	Imagine you're a data analyst Working for a global recruitment agency. 
Your Task is to identify the Locations where entry-level average salaries exceed the 
average salary for that job title in market for entry level, helping your agency guide candidates towards lucrative countries.*/

select t.job_title,k.company_location,t.average_sal,k.average_per_country from 
(
select job_title,avg(salary_in_usd) as average_sal from 
salaries where experience_level="EN" group by job_title
) AS t 
inner join
(
select job_title,company_location,avg(salary_in_usd) as average_per_country from salaries
where  experience_level="EN" group by job_title,company_location
)as k 
on t.job_title= k.job_title where average_per_country>average_sal order by average_per_country desc;



/* 5 You've been hired by a big HR Consultancy to look at how much people get paid IN different Countries. 
Your job is to Find out for each job title which  Country pays the maximum average salary. 
This helps you to place your candidates IN those countries.*/

select * from 
( 
select *,dense_rank() over(partition by job_title order by average desc) as rankbyja from
(
select company_location,job_title,avg(salary_in_usd) as average from salaries group by job_title,company_location
)t
)k where rankbyja=1;


/* 6. AS a data-driven Business consultant, you've been hired by a multinational corporation to analyze salary trends across 
different company Locations. Your goal is to Pinpoint Locations WHERE the average salary Has consistently Increased over 
the Past few years (Countries WHERE data is available for 3 years Only(present year and past two years) providing Insights
 into Locations experiencing Sustained salary growth.*/
with k as
(
	select * from salaries where company_location in
(
	select company_location from
(
	select company_location,avg(salary_in_usd),count(distinct work_year) as yearcount from salaries 
	where work_year>=year(current_date())-2
	group by company_location having yearcount=3
)a
)
)
SELECT 
    company_locatiON,
    MAX(CASE WHEN work_year = 2022 THEN  average END) AS AVG_salary_2022,
    MAX(CASE WHEN work_year = 2023 THEN average END) AS AVG_salary_2023,
    MAX(CASE WHEN work_year = 2024 THEN average END) AS AVG_salary_2024
FROM 
(
SELECT company_locatiON, work_year, AVG(salary_IN_usd) AS average FROM  k GROUP BY company_locatiON, work_year 
)q GROUP BY company_locatiON  havINg AVG_salary_2024 > AVG_salary_2023 AND AVG_salary_2023 > AVG_salary_2022;

select company_location,avg(salary_in_usd) as average ,work_year  from k group by company_location,work_year order by company_location;

/*7 Picture yourself AS a workforce strategist employed by a global HR tech startup. Your Mission is to Determine the percentage of fully remote work for each experience level 
IN 2021 and compare it WITH the corresponding figures for 2024,
Highlighting any significant Increases or decreases IN remote work Adoption over the years.*/
select * from
(
	select *,((remote_count)/(total_count))*100 as ratio_2021 from
	(
		select a.experience_level,total_count,remote_count from 
		(
		select experience_level,count(*) as total_count from salaries where work_year=2021 group by experience_level
		)a
		inner join
		(
		select experience_level,count(*) as remote_count from salaries where work_year=2021 and remote_ratio=100 group by experience_level
		)b on a.experience_level= b.experience_level
	)x
)p inner join
(
	select *,((remote_count)/(total_count))*100 as ratio_2024 from
	(
		select a.experience_level,total_count,remote_count from 
		(
		select experience_level,count(*) as total_count from salaries where work_year=2024 group by experience_level
		)a
		inner join
		(
		select experience_level,count(*) as remote_count from salaries where work_year=2024 and remote_ratio=100 group by experience_level
		)b on a.experience_level= b.experience_level
	)y
)q on p.experience_level=q.experience_level;


/*8 AS a Compensation specialist at a Fortune 500 company, you're tasked WITH analyzing salary trends over time. 
Your objective is to calculate the average salary increase percentage for each experience level and job title 
between the years 2023 and 2024, helping the company stay competitive IN the talent market.*/

select a.experience_level,
a.job_title,
round(average2023,2)
,round(average2024,2),
round((((average2024)-(average2023))/average2023)*100,2) 
from
	(
	select experience_level,job_title,avg(salary_in_usd) as average2023 from salaries 
	where work_year=2023 
	group by experience_level,job_title
	)a
inner join
	(
	select experience_level,job_title,avg(salary_in_usd) as average2024 from salaries 
	where work_year=2024 
	group by experience_level,job_title
	)b
	on a.experience_level=b.experience_level and 
	a.job_title=b.job_title;
-- *****************************************************************************************************************

/*11.As a market researcher, your job is to Investigate the job market for a company that analyzes workforce data. Your Task is to know how many people were
 employed IN different types of companies AS per their size IN 2021.*/

 select company_size,
 count(company_size) as count_of_employees
 from salaries where
 work_year=2021 group by 
 company_size;
 
/*12.Imagine you are a talent Acquisition specialist Working for an International recruitment agency. Your Task is to identify the top 3 job titles that 
command the highest average salary Among part-time Positions IN the year 2023.*/

select job_title,
avg(salary_in_usd) as average 
from salaries 
where work_year=2023 and employment_type="PT" 
group by job_title 
order by average desc limit 3;

/*3.As a database analyst you have been assigned the task to Select Countries where average 
mid-level salary is higher than overall mid-level salary for the year 2023.*/
select company_location,
a.experience_level, 
mid_level_salary_by_country,
overall_midlevel_salary 
from
(
select company_location,
experience_level,
avg(salary_in_usd) as mid_level_salary_by_country 
from salaries 
where work_year=2023 and experience_level="MI" 
group by company_location,experience_level
)a 
inner join
(
select  experience_level,
avg(salary_in_usd)as overall_midlevel_salary 
from salaries 
where experience_level="MI" and work_year = 2023 
group by experience_level
)b 
on a.experience_level=b.experience_level 
where overall_midlevel_salary< mid_level_salary_by_country;


/*14.As a database analyst you have been assigned the task to Identify the company locations with the highest and lowest average salary for 
senior-level (SE) employees in 2023.*/

(
select company_location,
avg(salary_in_usd) as average 
from salaries where experience_level="SE" and work_year=2023 
group by company_location 
order by average limit 1
)
union
(
select company_location,
avg(salary_in_usd) as average 
from salaries 
where experience_level="SE" and work_year=2023 
group by company_location 
order by average desc limit 1
);

/*15. You're a Financial analyst Working for a leading HR Consultancy, and your Task is to Assess 
the annual salary growth rate for various job titles. By Calculating the percentage Increase IN 
salary FROM previous year to this year, you aim to provide valuable Insights Into salary trends WITHIN different job roles.*/
select a.job_title,
avg_salary2023,avg_salary2024,
round((((avg_salary2024)-(avg_salary2023))/(avg_salary2023))*100,2) as percentage_change  from
(
select job_title,
avg(salary_in_usd) as avg_salary2023 
from salaries 
where work_year = 2023
 group by job_title
)a
inner join
(
select job_title
,avg(salary_in_usd) as avg_salary2024 
from salaries 
where work_year = 2024 
group by job_title
)b on a.job_title=b.job_title;

/*16 You've been hired by a global HR Consultancy to identify Countries experiencing significant salary 
growth. Your task is to list the top three Countries with the highest salary growth
 rate FROM 2020 to 2023, Considering Only companies with more than 50 employees, helping multinational Corporations
 identify Emerging talent markets.
*/
with t as 
(
select company_location,avg(salary_in_usd) as average,work_year from salaries where
work_year in (2021,2023)and experience_level="EN" group by company_location,work_year
)

SELECT 
        company_location,
        MAX(CASE WHEN work_year = 2021 THEN average END) AS AVG_salary_2021,
        MAX(CASE WHEN work_year = 2023 THEN average END) AS AVG_salary_2023
        
    FROM 
        t 
    GROUP BY 
        company_location having
    (((AVG_salary_2023 - AVG_salary_2021) / AVG_salary_2021) * 100) IS NOT NULL  
ORDER BY 
    (((AVG_salary_2023 - AVG_salary_2021) / AVG_salary_2021) * 100) DESC 
    limit 3 ;

/*17.Picture yourself as a data architect responsible for database management. Companies in US and AU(Australia) 
decided to create a hybrid model for employees they decided that employees earning salaries exceeding $90000 USD,
 will be given work from home. You now need to update the remote work ratio for eligible employees,
 ensuring efficient remote work management while implementing appropriate error handling mechanisms 
 for invalid input parameters.*/

 create  table camp  as select * from   salaries;  -- creating temporary table so that changes are not made in actual table as actual table is being used in other cases also.

-- SET SQL_SAFE_UPDATES = 0;
 UPDATE camp 
SET remote_ratio = 100
WHERE (company_location = 'AU' OR company_location ='US')AND salary_in_usd > 90000;

select * from camp where company_location in ('AU','US')AND salary_in_usd > 90000;

/* 8. In year 2024, due to increase demand in data industry , there was  increase in salaries of data field employees.
                   Entry Level-35%  of the salary.
                   Mid junior – 30% of the salary.
                   Immediate senior level- 22% of the salary.
                   Expert level- 20% of the salary.
                   Director – 15% of the salary.
you have to update the salaries accordingly and update it back in the original database. */

update camp
set salary_in_usd = salary_in_usd * 1.35
where experience_level="EN";

update camp
set salary_in_usd = salary_in_usd * 1.30
where experience_level="MI";

update camp
set salary_in_usd = salary_in_usd * 1.20
where experience_level="EX";

update camp
set salary_in_usd = salary_in_usd * 1.22
where experience_level="SE";

update camp
set salary_in_usd = salary_in_usd * 1.15
where experience_level="DX";

/*9. You are a researcher and you have been assigned the task to Find the year with
 the highest average salary for each job title.*/
select job_title,work_year,average as max_average from
(
 select *,rank() over(partition by job_title order by average desc) as "ranked" from
 (
select job_title,work_year,avg(salary_in_usd) as average from salaries group by job_title,work_year  order by job_title
)a
)b where ranked=1;

/*10. You have been hired by a market research agency where you been assigned the task to show the percentage of different employment type (full time, part time) in 
Different job roles, in the format where each row will be job title, each column will be type of employment type and  cell value  for that row and column will show 
the % value*/

select job_title,count(*) from salaries where employment_type="FT" group by job_title; 
select job_title,count(*) from salaries where employment_type="PT" group by job_title; 

SELECT 
    job_title,
    ROUND((SUM(CASE WHEN employment_type = 'PT' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS PT_percentage, -- Calculate percentage of part-time employment
    ROUND((SUM(CASE WHEN employment_type = 'FT' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS FT_percentage, -- Calculate percentage of full-time employment
    ROUND((SUM(CASE WHEN employment_type = 'CT' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS CT_percentage, -- Calculate percentage of contract employment
    ROUND((SUM(CASE WHEN employment_type = 'FL' THEN 1 ELSE 0 END) / COUNT(*)) * 100, 2) AS FL_percentage -- Calculate percentage of freelance employment
FROM 
    salaries
GROUP BY 
    job_title;


SELECT 
    job_title,
    employment_type,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY job_title)), 2) AS percentage
FROM 
    salaries
WHERE 
    employment_type IN ('ft', 'pt','ct','fl')
GROUP BY 
    job_title, employment_type
ORDER BY 
    job_title, employment_type;

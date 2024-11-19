# Sql_Case_Study_on_Data_Science_job
### **Detailed Description**

This project is a comprehensive **Data Science Job Market Case Study** aimed at understanding global salary trends, remote work adoption, and workforce dynamics. The dataset used contains detailed information about salaries, job titles, company locations, experience levels, work years, and company sizes. The analysis leverages advanced SQL queries to address real-world business challenges and provide actionable insights. The key aspects of this case study include:

1. **Remote Work Trends and High-Salary Jobs**:  
   Identifying countries offering fully remote work for managerial roles paying over $90,000 and analyzing the percentage of employees in high-paying remote jobs to highlight the attractiveness of such opportunities.

2. **Workforce Distribution**:  
   Investigating the distribution of employees across different company sizes and identifying the top 5 countries with the highest number of large companies hiring freshers.

3. **Salary Growth Patterns**:  
   Analyzing salary trends over time, including average salary increases by job title and experience level between specific years (e.g., 2023 to 2024). This includes exploring significant salary growth in emerging talent markets and locations with sustained salary increases over three years.

4. **Entry-Level Insights**:  
   Pinpointing locations where entry-level salaries exceed the average salary for specific job titles, providing guidance to job seekers on lucrative markets.

5. **Job Role Comparisons**:  
   Comparing salaries across job titles and identifying the highest-paying countries for each role. This helps in understanding global variations in compensation.

6. **Employment Type Analysis**:  
   Calculating the percentage distribution of different employment types (full-time, part-time, freelance, etc.) across job roles, providing a clear picture of job type preferences in various roles.

7. **Remote Work Adoption Over Time**:  
   Examining the adoption of fully remote roles across different experience levels from 2021 to 2024 to understand trends in remote work.

8. **Dynamic Adjustments**:  
   Simulating real-world scenarios like updating salary values based on industry trends and implementing policy changes for hybrid and remote work models.

9. **Market Insights for Senior Roles**:  
   Identifying countries with the highest and lowest average salaries for senior-level employees, helping businesses make competitive offers to attract top talent.
### =================================================================================================
### **Features**

1. **Salary Trends**:  
   Analyze salary growth patterns by job title, experience level, and company location over multiple years.

2. **Remote Work Analysis**:  
   Identify high-paying remote jobs, adoption trends, and percentage of employees working fully remotely.

3. **Workforce Distribution**:  
   Study employee distribution across company sizes and locations, focusing on large companies and freshers.

4. **Job Role Comparisons**:  
   Compare salaries across job titles and find the highest-paying countries for each role.

5. **Employment Type Analysis**:  
   Calculate the percentage of full-time, part-time, freelance, and contract roles for each job title.

6. **Entry-Level Insights**:  
   Highlight countries offering above-average salaries for entry-level positions.

7. **Senior-Level Insights**:  
   Determine locations with the highest and lowest average salaries for senior roles.

8. **Dynamic Adjustments**:  
   Simulate salary updates based on market trends and implement remote work policies.

9. **Emerging Talent Markets**:  
   Identify countries experiencing significant salary growth for early-career professionals.  

10. **Work Year Analysis**:  
    Investigate trends in workforce dynamics and salaries across specific years.

11. **Advanced Data Processing**:  
    Utilizing SQL techniques like window functions, CTEs (Common Table Expressions), and aggregations to extract meaningful insights and showcase a variety of skills applicable in real-world data analysis.

This case study is designed as a portfolio project for data scientists, data analysts, and SQL enthusiasts to showcase expertise in database management, workforce analytics, and salary trend analysis. It demonstrates the use of SQL to address complex business problems and make data-driven decisions.

### =================================================================================================
Setup Instructions (CSV-Based with MySQL)
1. Prerequisites
MySQL Installed: Ensure you have MySQL installed on your system.
SQL Client: Install tools like MySQL Workbench  to run SQL queries.
CSV File: Ensure the CSV file (e.g., salaries.csv) is present and accessible i have uploaded it.
### =================================================================================================

**Queries And There Output**
 1. You're a Compensation analyst employed by a multinational corporation.
 Your Assignment is to Pinpoint Countries who give work fully remotely, 
for the title 'managers’ Paying salaries Exceeding $90,000 USD

- select * from salaries where salary_in_usd>90000 and job_title like "%Manager%" and remote_ratio=100;
- select count(*) from salaries where salary_in_usd>90000 and job_title like "%Manager%" and remote_ratio=100;

![query1](https://github.com/user-attachments/assets/338b6856-e5a0-4f7a-891b-1e456443fc33)

2.AS a remote work advocate Working for a progressive HR tech startup who place their 
freshers’ clients IN large tech firms. you're tasked WITH Identifying top 5 Country Having 
greatest count of large (company size) number of companies.


select company_location,count(*) as large_company_per_country 
from salaries where company_size = "L" and experience_level="EN"
group by company_location order by large_company_per_country desc limit 5;

![Screenshot (43)](https://github.com/user-attachments/assets/07c8369c-7918-4904-873a-f2bc48667b60)

3. Picture yourself AS a data scientist Working for a workforce management platform. 
Your objective is to calculate the percentage of employees. 
Who enjoy fully remote roles WITH salaries Exceeding $100,000 USD, Shedding light ON the attractiveness of high-paying 
remote positions IN today's job market.

set @total_count= (select count(*) from salaries where salary_in_usd>100000);
set @Remotecount= (select count(*)from salaries where salary_in_usd>100000 and remote_ratio=100);
set @percentage = round(((@Remotecount)/(@total_count))*100,2);

select @percentage 'percentage of people working remotely and having salary>100000$';

![Screenshot (44)](https://github.com/user-attachments/assets/b49140c0-41ab-49f0-9fbc-61b22594d48e)


4.	Imagine you're a data analyst Working for a global recruitment agency. 
Your Task is to identify the Locations where entry-level average salaries exceed the 
average salary for that job title in market for entry level, helping your agency guide candidates towards lucrative countries.


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


![Screenshot (46)](https://github.com/user-attachments/assets/88382e24-774b-4778-9dc1-bcefcb6e112b)



5. You've been hired by a big HR Consultancy to look at how much people get paid IN different Countries. 
Your job is to Find out for each job title which  Country pays the maximum average salary. 
This helps you to place your candidates IN those countries.

select * from 
( 
select *,dense_rank() over(partition by job_title order by average desc) as rankbyja from
(
select company_location,job_title,avg(salary_in_usd) as average from salaries group by job_title,company_location
)t
)k where rankbyja=1;

![Screenshot (47)](https://github.com/user-attachments/assets/a97ecdbf-0434-4c2b-a2b3-6c96ff5e7a5b)

6. AS a data-driven Business consultant, you've been hired by a multinational corporation to analyze salary trends across 
different company Locations. Your goal is to Pinpoint Locations WHERE the average salary Has consistently Increased over 
the Past few years (Countries WHERE data is available for 3 years Only(present year and past two years) providing Insights
 into Locations experiencing Sustained salary growth.
```
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
```

![Screenshot (48)](https://github.com/user-attachments/assets/846efe33-0620-4f55-8452-bf7982714ef4)

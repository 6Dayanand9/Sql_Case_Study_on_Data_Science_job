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

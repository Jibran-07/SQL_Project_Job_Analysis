# Data Scientist Job Market Analysis in Madrid, Spain

## Introduction

📊 This project explores the **Data Scientist job market in Madrid, Spain**, using SQL to uncover high-paying opportunities, in-demand skills, and technologies associated with higher salaries.

The analysis focuses on job postings from 2023 and investigates the relationship between **salary, skill demand, and technical specialization**.

🔍 All SQL queries used for the analysis are available in the [`project_sql`](project_sql) folder.

## Background

The data science job market is constantly evolving, making it important to understand which skills employers are looking for and which technologies are associated with stronger compensation.

This project was created to analyze Data Scientist job postings in **Madrid, Spain** and answer practical questions about salaries and technical skills.

### Questions Explored

1. What are the highest-paying Data Scientist jobs in Madrid?
2. Which skills are required for the highest-paying Data Scientist positions?
3. What skills are most in demand for Data Scientists?
4. Which skills are associated with higher salaries?
5. Which skills offer the strongest combination of demand and salary?

## Tools Used

The analysis was completed using:

- **SQL:** Data extraction, filtering, aggregation, and analysis
- **PostgreSQL:** Database management and query execution
- **Visual Studio Code:** SQL development and database management
- **Git & GitHub:** Version control and project documentation

## The Analysis

### 1. Top-Paying Data Scientist Jobs in Madrid

The first analysis identifies the highest-paying Data Scientist positions located in **Madrid, Spain**, using annual average salary as the primary ranking metric.

```sql
SELECT
    job_id,
    job_title,
    company_name,
    job_location,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Scientist'
    AND job_location = 'Madrid, Spain'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
Key Findings

The highest-paying results identified in the analysis were:

Job Title	Company	Average Salary ($)
Core Data Specialist for The Olympic Games	Deloitte	90,000
DESARROLLADOR PYTHON - PYSPARK	Devoteam	89,100
Data Science Platform Lead	Syngenta Group	89,100
Data Scientist	Talent Hackers	87,307.50
Data Scientist	dentsu international	69,962.50
Graduate Consultant - Data Science	Celonis	56,700

The results show that Data Science opportunities in Madrid extend beyond traditional Data Scientist titles. Related positions include data platform, consulting, Python, and specialized data roles.

2. Skills Required for Top-Paying Data Scientist Jobs

The second analysis examines the technical skills associated with the highest-paying Data Scientist positions.

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        company_name,
        job_location,
        salary_year_avg,
        job_posted_date
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Scientist'
        AND job_location = 'Madrid, Spain'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
Key Findings

The skills appearing in the highest-paying positions include:

Python
SQL
AWS
Jupyter
NoSQL
Azure
PySpark
R
MATLAB

Python appears across several of the highest-paying positions, highlighting its importance within the Data Science market.

Cloud technologies such as AWS and Azure also appear in high-paying roles, while PySpark and NoSQL point toward the importance of large-scale data processing.

Overall, the results suggest that employers value a combination of programming, databases, cloud platforms, and data-processing technologies.

3. Most In-Demand Skills for Data Scientists

The third analysis measures how frequently skills appear across Data Scientist job postings.

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS total_jobs
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    skills
ORDER BY
    total_jobs DESC
LIMIT 5;
Results
Skill	Total Jobs
Python	3,296
SQL	2,395
R	1,867
Key Findings

The results demonstrate the importance of programming and data querying skills within Data Science roles.

Python is the most frequently requested skill, appearing in 3,296 jobs.
SQL follows with 2,395 jobs, highlighting the importance of database querying in Data Science.
R appears in 1,867 jobs, showing that statistical programming remains relevant.

Together, these results suggest that a strong foundation in Python, SQL, and statistical programming can provide broad coverage of Data Science opportunities.

4. Skills Associated with Higher Salaries

The fourth analysis examines the average salary associated with different skills.

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    average_salary DESC
LIMIT 15;
Top Salary-Associated Skills
Skill	Average Salary ($)
Asana	215,477.38
Airtable	201,142.86
Red Hat	189,500.00
Watson	187,417.14
Elixir	170,823.56
Lua	170,500.00
Slack	168,218.76
Solidity	166,979.90
Ruby on Rails	166,500.00
RShiny	166,436.21
Notion	165,636.36
Objective-C	164,500.00
Neo4j	163,971.09
dplyr	163,111.06
Hugging Face	160,867.72
Key Findings

Several specialized technologies are associated with high average salaries.

Notable results include:

Asana and Airtable ranked highest by average salary.
Red Hat and Watson were also associated with high average compensation.
Neo4j reflects the value of graph database technologies.
dplyr and RShiny represent specialized tools within the R ecosystem.
Hugging Face highlights the relevance of modern AI and machine learning technologies.

These results should be interpreted carefully because some skills may occur in relatively few job postings. A high average salary does not necessarily mean the skill is widely demanded.

5. Most Optimal Skills to Learn

The final analysis combines skill demand and average salary to identify technologies that offer a strong balance between market demand and compensation.

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS total_jobs,
    ROUND(AVG(job_postings_fact.salary_year_avg), 2) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_salary DESC,
    total_jobs DESC
LIMIT 15;
Results
Skill	Total Jobs	Average Salary ($)
Watson	14	187,417.14
Slack	17	168,218.76
RShiny	17	166,436.21
Notion	11	165,636.36
Neo4j	32	163,971.09
dplyr	16	163,111.06
Hugging Face	18	160,867.72
DynamoDB	12	160,581.13
Airflow	144	155,878.41
Theano	25	153,133.41
Zoom	18	151,676.89
BigQuery	135	149,291.75
Atlassian	23	148,714.59
Express	89	148,332.78
Looker	186	147,538.02
Key Findings

The combination of demand and salary provides a more useful perspective than looking at either metric individually.

Several technologies stand out:

Airflow appears in 144 jobs with an average salary of $155,878.41.
BigQuery appears in 135 jobs with an average salary of $149,291.75, demonstrating the value of cloud-based data technologies.
Looker appears in 186 jobs with an average salary of $147,538.02.
Neo4j appears in 32 jobs with an average salary of $163,971.09.
Hugging Face appears in 18 jobs with an average salary of $160,867.72, highlighting the value of modern AI and machine learning technologies.

These findings suggest that specialized technologies such as cloud platforms, workflow orchestration, business intelligence, graph databases, and modern AI tools can provide strong career value.

What I Learned

This project strengthened my ability to use SQL for practical Data Science career analysis.

Advanced SQL

Through the project, I worked with:

Multiple table joins
Common Table Expressions (CTEs)
GROUP BY
HAVING
COUNT()
AVG()
Filtering and sorting
Aggregating job and skill information
Combining demand and salary metrics
Data Analysis

Rather than simply querying the database, I learned how to translate career-related questions into measurable analytical problems.

For example, instead of asking which skills are "good," the analysis separates that question into:

How frequently is a skill requested?
What is the average salary associated with it?
Does the skill appear in enough jobs to make the result meaningful?
Which skills provide a balance between demand and compensation?
Analytical Thinking

The project also improved my ability to interpret job-market data and identify patterns across:

Salary
Skill demand
Programming languages
Cloud technologies
Data engineering tools
Machine learning technologies
Business intelligence platforms
Conclusions
Key Insights
Python is the dominant Data Science skill: Python appeared in 3,296 jobs, making it the most frequently requested skill in the analysis.
SQL remains highly relevant: SQL appeared in 2,395 jobs, demonstrating that database skills remain important for Data Scientists.
R continues to have significant demand: With 1,867 jobs, R remains an important statistical programming language.
Specialized skills can command higher salaries: Technologies such as Watson, Neo4j, dplyr, and Hugging Face were associated with high average salaries.
Cloud and data infrastructure skills are valuable: BigQuery, DynamoDB, and Airflow demonstrate the importance of modern data infrastructure.
Demand should be considered alongside salary: Skills such as Airflow, BigQuery, and Looker combine meaningful job demand with strong average compensation.
Final Takeaway

This project transformed job-posting data into a practical view of the Data Scientist job market in Madrid, Spain.

The results show that Python and SQL provide the strongest foundation, while cloud technologies, data engineering tools, machine learning frameworks, and specialized analytics platforms can further increase career opportunities.

For someone preparing for a Data Science career, the findings suggest building a progression around:

Python → SQL → Statistics & Machine Learning → Cloud & Data Engineering → Specialized AI/Analytics Technologies

Overall, this project strengthened my ability to use SQL to investigate real-world questions and turn raw job-market data into actionable insights for career and skill development.

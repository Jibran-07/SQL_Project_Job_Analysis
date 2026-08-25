SELECT 
    job_id,
    job_title,
    name as company_name,
    job_location,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Madrid, Spain'
ORDER BY salary_year_avg DESC
LIMIT 10
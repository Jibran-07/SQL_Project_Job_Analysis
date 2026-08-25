SELECT
    skills,
    COUNT(skills_job_dim.job_id) as total_jobs
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    salary_year_avg > 100000
GROUP BY skills
ORDER BY total_jobs DESC
LIMIT 3
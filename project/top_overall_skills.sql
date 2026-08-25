-- WITH top_skills AS(
--     SELECT
--         skills_dim.skill_id, 
--         skills, 
--         ROUND(AVG(salary_year_avg),2) AS average_salary
--     FROM job_postings_fact
--     INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--     INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE
--         job_title_short = 'Data Scientist' AND 
--         salary_year_avg IS NOT NULL
--     GROUP BY skills_dim.skill_id
-- ),

-- top_paid_skills AS(
--     SELECT
--         skills_job_dim.skill_id,
--         COUNT(skills_job_dim.job_id) as total_jobs
--     FROM job_postings_fact
--     INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
--     INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
--     WHERE
--         job_title_short = 'Data Scientist' AND
--         salary_year_avg IS NOT NULL
--     GROUP BY skills_job_dim.skill_id
-- )

-- SELECT
--     top_skills.skills,
--     top_skills.average_salary as avg_salary,
--     top_paid_skills.total_jobs
-- FROM top_skills
-- INNER JOIN top_paid_skills ON top_skills.skill_id = top_paid_skills.skill_id
-- WHERE total_jobs > 10
-- ORDER BY avg_salary DESC, total_jobs DESC
-- LIMIT 15

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as total_jobs,
    ROUND(AVG(salary_year_avg),2) AS average_salary
FROM skills_dim
INNER JOIN skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE 
    job_title_short = 'Data Scientist' AND
    salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY average_salary DESC, total_jobs DESC
LIMIT 15
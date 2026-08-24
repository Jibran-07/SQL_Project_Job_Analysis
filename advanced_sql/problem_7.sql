/*
Find the count of the number of remote job postings per skill
    - Display the top 3 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_data_scientist_skills AS (
    SELECT
        skills_to_job.skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings
        ON skills_to_job.job_id = job_postings.job_id
    WHERE job_postings.job_work_from_home = TRUE
      AND job_postings.job_title_short = 'Data Scientist'
    GROUP BY skills_to_job.skill_id
)

SELECT
    skills.skill_id,
    skills AS skill_name,
    remote_data_scientist_skills.skill_count
FROM remote_data_scientist_skills
INNER JOIN skills_dim AS skills
    ON skills.skill_id = remote_data_scientist_skills.skill_id
ORDER BY remote_data_scientist_skills.skill_count DESC
LIMIT 3;
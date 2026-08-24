/* 
Label new column as follows based on job_location:
- 'Anywhere' jobs as 'Remote'
- 'Chicago, IL' jobs as  'Local'
- Otherwise 'Onsite'
*/

SELECT 
	COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'Chicago, IL' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Scientist'
GROUP BY
    location_category
ORDER BY    
    number_of_jobs DESC;


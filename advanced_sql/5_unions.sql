-- Get jobs and companies from October
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	october_jobs

UNION ALL

-- Get jobs and companies from November 
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	november_jobs

UNION ALL

-- Get jobs and companies from December
SELECT 
	job_title_short,
	company_id,
	job_location
FROM
	december_jobs
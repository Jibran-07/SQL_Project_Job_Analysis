CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);

INSERT INTO job_applied (
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_sent,
    cover_letter_file_name,
    status
)
VALUES
    (1, '2024-02-01', TRUE, 'data_science_resume.pdf', TRUE, 'data_science_cover.pdf', 'application submitted'),
    (2, '2024-02-02', FALSE, 'standard_resume.pdf', FALSE, NULL, 'interview scheduled'),
    (3, '2024-02-03', TRUE, 'machine_learning_resume.pdf', TRUE, 'ml_cover_letter.pdf', 'no response'),
    (4, '2024-02-04', TRUE, 'analytics_resume.pdf', FALSE, NULL, 'application submitted'),
    (5, '2024-02-05', FALSE, 'general_resume.pdf', TRUE, 'general_cover_letter.pdf', 'application rejected');

ALTER TABLE job_applied
ADD COLUMN contact VARCHAR(50);

UPDATE job_applied
SET contact = 'Arjun Mehta'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Sameer Khan'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Harshad Mehta'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Ali Haroon'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Rohit Sharma'
WHERE job_id = 5;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;
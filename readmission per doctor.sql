WITH readmission AS (
    SELECT
        d.doctor_id,
        d.first_name,
        d.last_name,
        AVG(DATEDIFF(day, admit_date, discharge_date)) AS avg_length_of_stay,
        COUNT(admission_id) AS total_admissions,
        SUM(CASE WHEN is_readmitted = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(admission_id) AS readmission_percent
    FROM doctors d
    JOIN admissions a ON d.doctor_id = a.doctor_id
    GROUP BY d.doctor_id, d.first_name, d.last_name
    HAVING COUNT(admission_id) >= 3   )
SELECT 
    doctor_id,
    first_name,
    last_name,
    readmission_percent
FROM readmission
ORDER BY readmission_percent DESC;
use HospitalDB
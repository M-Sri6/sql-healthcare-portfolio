with admission_volume as
(SELECT 
PRIMARY_DIAGNOSIS, 
count(admission_id) as total_admissions,
cast(avg(datediff(day, admit_date, discharge_date))as decimal(5,1)) as avg_length_of_stay, 
CAST(
            SUM(CASE WHEN is_readmitted = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(admission_id) 
            AS DECIMAL(5,1)
        ) AS readmission_percent
        from admissions
        group by primary_diagnosis)

        select 
        primary_diagnosis,
        total_admissions,
        avg_length_of_stay,
        readmission_percent

        from admission_volume
        order by total_admissions desc ;
USE HospitalDB;

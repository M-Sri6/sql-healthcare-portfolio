CREATE PROCEDURE GetMonthlyReadmissionTrends
AS
BEGIN
    WITH readmissions AS (
        SELECT 
            FORMAT(admit_date, 'yyyy-MM') AS year_month,
            COUNT(admission_id) AS total_admissions,
            CAST(
                SUM(CASE WHEN is_readmitted = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(admission_id) 
                AS DECIMAL(5,1)
            ) AS readmission_percent
        FROM admissions
        GROUP BY FORMAT(admit_date, 'yyyy-MM')
    )
    SELECT 
        year_month,
        total_admissions,
        readmission_percent,
        LAG(readmission_percent) OVER (ORDER BY year_month) AS previous_month_rate
    FROM readmissions
    ORDER BY year_month;
END;

EXEC GetMonthlyReadmissionTrends;
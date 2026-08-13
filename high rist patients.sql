with risk_patients as
(select p.patient_id,
p.first_name,
p.last_name,
datediff(year, birth_date, getdate()) as patient_age,
count(admission_id)as total_admissions,
SUM(CASE WHEN is_readmitted = 1 THEN 1 ELSE 0 END) as total_readmissions
from patients p join admissions a
on p.patient_id = a.patient_id
group by p.patient_id,p.first_name, p.last_name,p.birth_date)

select 
patient_id, first_name, last_name,
patient_age, total_admissions, total_readmissions,

case when patient_age >= 65 or  total_readmissions >= 2 then 'high_risk'
      when patient_age between 50 and 65 or total_readmissions >= 1 then ' Medium_risk'

      else 'Low_risk' end as risk_category 
       from risk_patients ;

use HospitalDB

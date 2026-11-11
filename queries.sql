-- Clinical office no-show performance; for fictional synthetic data only.
SELECT c.clinic_name, COUNT(*) AS total_appointments,
 ROUND(100.0*AVG(a.no_show::INT),2) AS no_show_pct
FROM schraeder.appointments a JOIN schraeder.clinics c ON a.clinic_id=c.clinic_id
GROUP BY c.clinic_name ORDER BY no_show_pct DESC;

-- Monthly operations and no-shows.
SELECT appointment_month, COUNT(*) AS appointments,
 SUM(no_show::INT) AS no_shows,
 ROUND(100.0*AVG(no_show::INT),2) AS no_show_pct
FROM schraeder.appointments GROUP BY appointment_month ORDER BY appointment_month;

-- Synthetic clinical trial enrollment progress.
SELECT study_id, title, study_phase, enrolled, target,
 ROUND(100.0*enrolled/NULLIF(target,0),1) AS enrollment_pct
FROM schraeder.research_studies ORDER BY enrollment_pct DESC;

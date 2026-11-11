-- PostgreSQL example schema. All data for this project is synthetic.
CREATE SCHEMA IF NOT EXISTS schraeder;
CREATE TABLE IF NOT EXISTS schraeder.clinics (
 clinic_id VARCHAR(12) PRIMARY KEY, clinic_name TEXT NOT NULL,
 specialty TEXT NOT NULL, appointment_capacity_weekly INTEGER NOT NULL CHECK(appointment_capacity_weekly>=0));
CREATE TABLE IF NOT EXISTS schraeder.appointments (
 appointment_id VARCHAR(20) PRIMARY KEY, clinic_id VARCHAR(12) NOT NULL REFERENCES schraeder.clinics(clinic_id),
 appointment_month SMALLINT NOT NULL CHECK(appointment_month BETWEEN 1 AND 12),
 day_of_week SMALLINT NOT NULL CHECK(day_of_week BETWEEN 0 AND 6),
 lead_days INTEGER NOT NULL, prior_no_shows INTEGER NOT NULL,
 reminder_sent BOOLEAN NOT NULL, travel_minutes INTEGER NOT NULL,
 age_band VARCHAR(10) NOT NULL, no_show BOOLEAN NOT NULL);
CREATE TABLE IF NOT EXISTS schraeder.research_studies (
 study_id VARCHAR(20) PRIMARY KEY, title TEXT NOT NULL, study_phase TEXT NOT NULL,
 therapeutic_area TEXT NOT NULL, enrolled INTEGER NOT NULL CHECK(enrolled>=0),
 target INTEGER NOT NULL CHECK(target>0), status TEXT NOT NULL);
CREATE INDEX IF NOT EXISTS ix_appointment_clinic ON schraeder.appointments(clinic_id);
CREATE INDEX IF NOT EXISTS ix_appointment_month ON schraeder.appointments(appointment_month);
-- Import data with a client-side CSV import or ETL, mapping CSV headers to these columns.

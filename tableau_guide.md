# Tableau dashboard instructions (synthetic data)

Connect Tableau Desktop or Tableau Public to `data/monthly_operations.csv` (Text file). Optional second source: `data/appointments.csv`.

Create worksheets:

1. **Monthly Encounters** — Columns: `month` (discrete), Rows: `SUM(encounters)`; marks: bars.
2. **Mean Wait Time** — Columns: `month`; Rows: `AVG(avg_wait_minutes)`; marks: line.
3. **Patient Experience** — Columns: `month`; Rows: `AVG(patient_experience_pct)`; marks: line; axis labeled percent.
4. **Appointment No-show** — With appointments CSV, Columns: `clinic_id`; Rows: `AVG(no_show)` formatted as percent.
5. **Study Enrolment** — Connect `data/studies.json` (if your Tableau edition supports JSON) or export studies to CSV; use enrolment calculated field below.

Calculated fields in Tableau:

```text
// No-show Rate (appointments.csv; no_show is numeric 0/1)
AVG([no_show])

// Enrollment % (research studies table)
SUM([enrolled]) / SUM([target])

// Total Encounters (monthly CSV)
SUM([encounters])
```

Dashboard title: **The Peter, Paul, and Mary Schraeder Hospital — Synthetic Operations Dashboard**.

Place a highly visible notice: **FICTIONAL HOSPITAL · SYNTHETIC DATA · NOT FOR CLINICAL USE**.

A `.twb` workbook is not included because workbook authoring and publishing need Tableau; this guide provides reproducible Tableau-ready data and formulas.

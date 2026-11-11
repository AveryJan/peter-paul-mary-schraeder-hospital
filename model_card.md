# Synthetic No-show Model Card

**Purpose:** Demonstrate train/evaluate/package/monitor design. NOT for healthcare workflow, clinical decision making, or use on real people.

**Training data:** 600 generated appointment rows from `data/appointments.csv`, constructed using a toy synthetic probability rule. No real or de-identified patient data.

**Label:** `no_show` (synthetic binary).

**Features:** lead time, prior missed appointments, reminders, travel time, month and day of week.

**Method:** Random forest, stratified 75/25 holdout split, fixed random seed 42. Reports holdout ROC-AUC and accuracy. This does not validate predictive utility or fairness.

**Risks:** Synthetic bias, spurious correlations, small sample, no demographic or subgroup validation, potential disparate impacts. Do not use for triage, access restrictions or scheduling decisions.

**Future MLOps:** Add feature contracts, validation, fairness assessment, calibration, artifact registry, drift monitoring, rollback, access governance, human oversight and audit events before any real-world consideration.

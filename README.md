# The Peter, Paul, and Mary Schraeder Hospital

**A fictional, synthetic-data healthcare technology portfolio project — not a real hospital or patient service.**

A multi-service demonstrator with a hospital public website, clinical office scheduling data, pharmaceutical research studies, operational analytics, and an example MLOps pipeline. No real patients, staff, operational statistics, medical advice, or active clinical trials are represented.

## Quick start

1. Open `website/index.html` in a browser. It is fully self-contained and needs no server.
2. Run the Python analytics API (Python 3.11+): `pip install -r python_service/requirements.txt` then `uvicorn python_service.app:app --reload --port 8000`. Visit `/docs` or `/api/metrics`.
3. Run the Node API (Node 20+): `cd backend && npm install && npm start` (port 3001). MongoDB is optional: the API uses the packaged synthetic JSON when `MONGO_URI` is not defined.
4. Run the React application: `cd frontend && npm install && npm run dev` (Vite dev server). It fetches the Node API if running and otherwise displays local fallback data.
5. Generate an example research model: `pip install -r mlops/requirements.txt && python mlops/train.py`.
6. Run tests: `pip install -r python_service/requirements.txt && pip install pytest && pytest tests -q`.

## Contents

| Area | Files | Use |
| --- | --- | --- |
| Public-facing prototype | `website/` | Responsive static website (HTML/CSS/JS) |
| React dashboard | `frontend/` | Sample operational dashboards |
| Node.js Express API | `backend/` | Clinics, appointments, departments, research studies |
| Python FastAPI | `python_service/` | KPI analytics and sample risk prediction |
| SQL | `sql/schema.sql`, `sql/queries.sql` | PostgreSQL analytical database design and queries |
| MongoDB | `backend/seed.js` | Example document database seed script |
| R / RStudio | `analytics/analysis.R` | Exploratory summaries and PNG charts |
| Tableau | `analytics/tableau_guide.md` | CSV connection and calculated fields |
| MLOps | `mlops/`, `.github/workflows/` | Train, evaluate, model artifact and CI |
| Cloud-native | `docker-compose.yml`, `infra/k8s/` | Containers and example Kubernetes manifests |
| Synthetic sample data | `data/` | Visits, clinics, medication studies, summary metrics |

## Project scope

- Hospital operations: service lines, synthetic patient encounter volume, wait times and capacity.
- Clinical offices: clinic directory and sample appointment slots.
- Pharmaceutical R&D: **fictional** study portfolio, phase and enrolment progress; no indication of trial registration or recruitment.
- Data science: predicting **synthetic appointment no-show risk for demonstration only**, not diagnosis, triage or real-world decision support.
- Quality: testing, data provenance, monitoring proposals, simple model metrics.

## Safety and release limitations

- The website labels itself a **DEMO** throughout; do not portray it as a licensed hospital, operating clinic, pharmacy, or trial sponsor.
- **No real PHI**. Do not upload patient records or credentials to this repository. Never use synthetic IDs to imply HIPAA compliance.
- This is **not** an EHR, medical device, medical AI, clinical booking system, or GxP-validated research platform.
- Production deployment would require identity and RBAC, encryption, audit trails, input validation, monitoring, backups, legal/privacy review, HIPAA and applicable GxP/21 CFR Part 11 controls, IRB oversight where needed, and clinical validation.
- The sample APIs provide read-only data. They are not internet-hardened.

## GitHub Pages

Push this folder to a new repository, then set **Settings → Pages → Deploy from a branch → main → /docs**. GitHub Pages can host the static demonstration only, **not** Node/Python servers or databases. For GitHub Pages, relative website asset links are used.

## Suggested repository name

`peter-paul-mary-schraeder-hospital`

## Attribution

Created as a portfolio exercise. All entities, appointment data, study titles and metrics are invented for demonstration.

To populate MongoDB: `cd backend && node seed.js` (with MongoDB running).

# High-level architecture

```mermaid
flowchart LR
  Website[HTML/CSS/JS public demo] --> Browser[Browser]
  React[React operations dashboard] --> Node[Node.js Express API]
  Node --> Mongo[(MongoDB optional)]
  Node --> Fixtures[Synthetic JSON fixtures]
  Python[Python FastAPI analytics] --> CSV[Synthetic CSV fixtures]
  CSV --> R[RStudio analytics]
  CSV --> Tableau[Tableau workbook guide]
  CSV --> Train[Python MLOps training]
  Train --> Artifact[Model artifact + metrics]
  CI[GitHub Actions] --> Train
  Compose[Docker Compose] --> Node
  Compose --> Python
  K8s[Kubernetes demo manifest] --> Python
```

The frontend and Node API have a real integration. The static website is intentionally independent for GitHub Pages. The SQL schema and R/Tableau notebooks are companion analytics examples, not falsely depicted as live integrated EHR components. MongoDB is optional and must be seeded using `backend/seed.js` (run `cd backend && npm install && node seed.js`). For the simplest demo, leave `MONGO_URI` unset and use JSON fixtures.

No live interoperability, FHIR feed, patient identity integration, or production security posture is claimed.

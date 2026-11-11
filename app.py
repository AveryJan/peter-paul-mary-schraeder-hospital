"""Read-only, synthetic-only hospital operations API. Not for clinical decision making."""
from pathlib import Path
import json
import pandas as pd
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
BASE=Path(__file__).resolve().parent.parent/'data'
app=FastAPI(title='Schraeder Synthetic Healthcare Analytics',version='1.0.0',description='Fictional organization and synthetic demonstration data only.')
def read(name):return json.loads((BASE/f'{name}.json').read_text(encoding='utf-8'))
@app.get('/health')
def health():return {'ok':True,'synthetic':True}
@app.get('/api/metrics')
def metrics():return read('metrics')
@app.get('/api/clinics')
def clinics():return read('clinics')
@app.get('/api/studies')
def studies():return read('studies')
@app.get('/api/monthly')
def monthly():return pd.read_csv(BASE/'monthly_operations.csv').to_dict(orient='records')
@app.get('/api/research/enrollment')
def research_enrollment():return [{'study_id':s['id'],'percent_complete':round(s['enrolled']/s['target']*100,1)} for s in read('studies')]
class NoShowFactors(BaseModel):
    lead_days:int=Field(ge=0,le=365)
    prior_no_shows:int=Field(ge=0,le=20)
    reminder_sent:bool
    travel_minutes:int=Field(ge=0,le=300)
@app.post('/api/demo/no-show-score')
def illustrative_no_show_score(f:NoShowFactors):
    # Transparent heuristic, not a validated medical/operational prediction model.
    score=min(.85,max(.02,.05+.007*f.lead_days+.10*f.prior_no_shows+.002*f.travel_minutes-.09*int(f.reminder_sent)))
    return {'illustrative_probability':round(score,3),'clinical_use':False,'model':'synthetic toy heuristic'}

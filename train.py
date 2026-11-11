"""Train a toy no-show classifier on synthetic appointments; never for patient decisions."""
from pathlib import Path
import json
import pandas as pd
from joblib import dump
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import roc_auc_score, accuracy_score
ROOT=Path(__file__).resolve().parent.parent
rows=pd.read_csv(ROOT/'data'/'appointments.csv')
cols=['lead_days','prior_no_shows','reminder_sent','travel_minutes','month','day_of_week']
X=rows[cols];y=rows['no_show']
X_train,X_test,y_train,y_test=train_test_split(X,y,test_size=.25,random_state=42,stratify=y)
model=RandomForestClassifier(n_estimators=100,max_depth=5,min_samples_leaf=8,random_state=42)
model.fit(X_train,y_train)
proba=model.predict_proba(X_test)[:,1]
results={'synthetic_only':True,'rows':len(rows),'test_rows':len(y_test),'roc_auc':round(float(roc_auc_score(y_test,proba)),4),'accuracy':round(float(accuracy_score(y_test,model.predict(X_test))),4),'features':cols,'clinical_use':False}
output=ROOT/'mlops'/'artifacts';output.mkdir(exist_ok=True)
dump(model,output/'noshow_synthetic.joblib')
(output/'metrics.json').write_text(json.dumps(results,indent=2)+'\n')
print(json.dumps(results,indent=2))

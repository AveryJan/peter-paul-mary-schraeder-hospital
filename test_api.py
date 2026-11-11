from python_service.app import read, illustrative_no_show_score, NoShowFactors, monthly, research_enrollment

def test_synthetic_clinics():
    clinics=read('clinics')
    assert len(clinics)==6 and all(c['id'].startswith('CL-') for c in clinics)

def test_research_enrollment():
    assert len(research_enrollment())==4
    assert all(0<=s['percent_complete']<=100 for s in research_enrollment())

def test_no_show_demo_score():
    result=illustrative_no_show_score(NoShowFactors(lead_days=10,prior_no_shows=1,reminder_sent=True,travel_minutes=20))
    assert 0<=result['illustrative_probability']<=1 and result['clinical_use'] is False

def test_monthly_data():
    assert len(monthly())==12

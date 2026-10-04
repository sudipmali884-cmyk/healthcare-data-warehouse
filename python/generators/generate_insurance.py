import pandas as pd
import random
from faker import Faker
from datetime import date,timedelta


fake=Faker("en_IN")

random.seed(100)
Faker.seed(100)


TOTAL_INSURANCE = 40000
today=date.today()
patients_df=pd.read_csv("../../csv/patients.csv",parse_dates=["dob"])

patients_df["dob"]=pd.to_datetime(patients_df["dob"])
patient_records= patients_df[[
    "patient_id","patient_name","dob"
]].to_dict("records")
# patients_ids=(
#     patients_df["patient_id"].drop_duplicates().tolist()
# )

# Insurance Providers

providers = [

    "Star Health",
    "HDFC ERGO",
    "ICICI Lombard",
    "Niva Bupa",
    "Care Health",
    "Bajaj Allianz",
    "New India Assurance",
    "Aditya Birla Health",
    "Reliance General",
    "SBI General",
    "LIC",
    "IPPB"

]
provider_weights=[ 10,5,3,2,15,12,4,18,7,8,14,2]

#Policy status
# status=random.choices(
#     ["Active","Under Renovation","Closed"],
#     weights=[95,3,2]
# )            
status=random.choices(["Active","Expired","Cancelled"],
        weights=[85,10,5])[0]

# Generate Records
insurance_data=[]
for i in range(1,TOTAL_INSURANCE + 1):
    # patient = patients_df.sample(1).iloc[0]

    patient = random.choice(patient_records)

    patient_id = patient["patient_id"]
    patient_name = patient["patient_name"]
    dob = patient["dob"].date()
    insurance_id = f"I{i:06d}"
    patient_id=patient["patient_id"]

    patient_name=patient["patient_name"]
    provider=random.choices(providers,
                    weights=provider_weights)[0]



    policy_number=fake.bothify(text="POL########")

    coverage_amount = random.choice([100000,200000,300000,400000,500000,1000000,15000000,2000000])

    # Policy start (after birth)
    # dob = patient["dob"].date()
    eligible_date=dob+timedelta(days=200)
    insurance_start_date=fake.date_between(
        start_date=eligible_date,
        end_date="today"
    )
    # Policy valid for 1-10 years
    insurance_end_date= insurance_start_date + timedelta(
        days= random.randint(365,365*10)
    )

    # Record created in system (same day or after policy start)
    # Date when this insurance record was inserted
    # into the hospital/insurance database.
    created_date= fake.date_between(
        start_date=insurance_start_date,
        end_date=min(insurance_end_date, today)
    )

    # Record last updated after creation
    updated_date = fake.date_between(
        start_date=created_date,
        end_date=min(insurance_end_date, today)
    )

    status = random.choices(
        ["Active", "Expired", "Cancelled"],
        weights=[95, 3, 2])[0]
    insurance_data.append({

            "insurance_id": insurance_id,
            "patient_id": patient_id,
            "patient_name":patient_name,
            "provider": provider,
            "policy_number": policy_number,
            "coverage_amount": coverage_amount,
            "start_date": insurance_start_date,
            "end_date": insurance_end_date,
            "created_date": created_date,
            "updated_date": updated_date,
            "status": status

        })

df= pd.DataFrame(insurance_data)

# save_csv
df.to_csv("../../csv/insurance.csv",index=False)

print("Insurance Generated Successfully")
print(f"Total Records : {len(df)}")
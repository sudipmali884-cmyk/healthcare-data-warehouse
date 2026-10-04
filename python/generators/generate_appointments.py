import pandas as pd
import random
from faker import Faker
from datetime import  datetime,date

fake=Faker("en_IN")
random.seed(100)
Faker.seed(100)
TOTAL_APPOINTMENTS=400000

patient_df=pd.read_csv("../../csv/patients.csv")
doctor_df=pd.read_csv("../../csv/doctors.csv")
# hospitals_df=pd.read_csv("../../csv/hospitals.csv")


patient_df["dob"]=pd.to_datetime(patient_df["dob"])
doctor_df["joining_date"]= pd.to_datetime(
    doctor_df["joining_date"]
)
doctor_mapping = doctor_df[[
    "doctor_id","hospital_id","joining_date","doctor_name","consultation_fee"
]].to_dict("records")

patient_mapping=patient_df[[
    "patient_id","patient_name","dob","blood_group"
]].to_dict("records")

# appointment status here also can you write an din loop also

# Generate records
appointment_data=[]

for i in range(1, TOTAL_APPOINTMENTS +1):
    appointment_id = f"A{i:07d}"

    #Patient

    # patient=patient_mapping.sample(1).iloc[0]
    patient= random.choice(patient_mapping)
    patient_id=patient["patient_id"]

    dob=patient["dob"]

    patient_name=patient["patient_name"]
    blood_groups=patient["blood_group"]

    #Doctor
    # doctor=doctor_mapping.sample(1).iloc[0]
    doctor=random.choice(doctor_mapping)
    hospital_id = doctor["hospital_id"]
    doctor_id=doctor["doctor_id"]
    doctor_name=doctor["doctor_name"]
    joining_date = doctor["joining_date"]
    consultation_fee=doctor["consultation_fee"]

    #Appointment_date

    start_date=max(
        dob,joining_date
    ) #Appointment cannot happen before Patient Birth Date or Doctor Joining Date.
    appointment_date = fake.date_between(

        start_date=start_date,

        end_date="today"

    )
    # patient_age
    patient_age=(appointment_date - dob.date()).days // 365

    created_date = appointment_date

    updated_date = fake.date_between(

        start_date=created_date,

        end_date="today"

    )


    # waiting_time = random.randint(5, 180)
    waiting_time=random.choices(
        [5, 10, 15, 20, 30, 45, 60, 90, 120],
        weights = [10, 20, 25, 20, 10, 7, 5, 2, 1]
    )[0]
    # status = random.choice(appointment_status)
    # appointment_status=random.choices(["Completed","Pending","Cancelled","No Show"])
    consultation_type = random.choices(
        ["Walk-in", "Online", "Emergency", "Follow-up"],
        weights=[60, 20, 15, 5]
    )[0]

    appointment_status = random.choices(["Completed", "Pending", "Cancelled", "No show"],
                                        weights=[50, 30, 15, 5])[0]

    appointment_data.append({

        "appointment_id": appointment_id,
        "patient_id": patient_id,
        "patient_age":patient_age,
        "patient_name":patient_name,
        "blood_groups":blood_groups,
        "doctor_id": doctor_id,
        "doctor_name":doctor_name,
        "hospital_id": hospital_id,
        "appointment_date": appointment_date,
        "consultation_type": consultation_type,
        "consultation_fee": consultation_fee,
        "waiting_time_minutes": waiting_time,
        "appointment_status": appointment_status,
        "created_date": created_date,
        "updated_date": updated_date

    })

df=pd.DataFrame(appointment_data)

#Missing consultation type
rows = random.sample(range(len(df)), 100)

for r in rows:
    df.loc[r, "consultation_type"] = None #Creates NULL values.

# invalid patient ids
rows = random.sample(range(len(df)), 100)

for r in rows:
    df.loc[r, "patient_id"] = "P999999"

#invalid doctor ids
rows = random.sample(range(len(df)), 100)

for r in rows:
    df.loc[r, "doctor_id"] = "D999999"

df.to_csv("../../csv/appointments.csv", index=False)
print("Appointments Generated Successfully")
print(f" Total Records : {len(df)}")





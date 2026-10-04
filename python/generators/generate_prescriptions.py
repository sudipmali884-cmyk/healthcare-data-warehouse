import pandas as pd
import random
from faker import Faker

fake=Faker("en_IN")
random.seed(100)
Faker.seed(100)

TOTAL_PRESCRIPTIONS=500000

appointment_df=pd.read_csv("../../csv/appointments.csv",parse_dates=["appointment_date"])
print("Appointment data access successfully ")
print(f"Appointment Records : {len(appointment_df)}")
appointment_mapping = appointment_df[[
    "appointment_id","patient_id","patient_name","doctor_id","doctor_name","appointment_date"

]].to_dict("records")
#
# medicines = [
#
#     "Paracetamol",
#     "Azithromycin",
#     "Amoxicillin",
#     "Crocin",
#     "Dolo 650",
#     "Pantoprazole",
#     "Cetirizine",
#     "Metformin",
#     "Amlodipine",
#     "Atorvastatin",
#     "Insulin",
#     "Vitamin D3",
#     "ORS",
#     "Ibuprofen",
#     "Diclofenac",
#     "Omeprazole",
#     "Levocetirizine",
#     "Losartan",
#     "Aspirin",
#     "Montek LC"
#
# ]


medicine_map = {

    "Paracetamol": [
        "1 Tablet Once Daily",
        "1 Tablet Twice Daily",
        "SOS"
    ],

    "Azithromycin": [
        "1 Tablet Once Daily"
    ],

    "Amoxicillin": [
        "1 Tablet Twice Daily",
        "Every 8 Hours"
    ],

    "Crocin": [
        "1 Tablet Once Daily",
        "1 Tablet Twice Daily",
        "SOS"
    ],

    "Dolo 650": [
        "1 Tablet Twice Daily",
        "SOS"
    ],

    "Pantoprazole": [
        "1 Tablet Before Food"
    ],

    "Cetirizine": [
        "1 Tablet Once Daily",
        "1 Tablet At Night"
    ],

    "Metformin": [
        "1 Tablet After Food",
        "1 Tablet Twice Daily"
    ],

    "Amlodipine": [
        "1 Tablet Once Daily"
    ],

    "Atorvastatin": [
        "1 Tablet At Night"
    ],

    "Insulin": [
        "Injection"
    ],

    "Vitamin D3": [
        "1 Tablet Once Weekly",
        "1 Tablet Once Monthly"
    ],

    "ORS": [
        "5 ml Twice Daily",
        "10 ml Once Daily"
    ],

    "Ibuprofen": [
        "1 Tablet After Food",
        "1 Tablet Twice Daily"
    ],

    "Diclofenac": [
        "1 Tablet After Food",
        "Injection"
    ],

    "Omeprazole": [
        "1 Tablet Before Food"
    ],

    "Levocetirizine": [
        "1 Tablet At Night"
    ],

    "Losartan": [
        "1 Tablet Once Daily"
    ],

    "Aspirin": [
        "1 Tablet Once Daily"
    ],

    "Monte LC": [
        "1 Tablet At Night"
    ]
}


frequency = [

    "Morning",

    "Evening",

    "Morning & Night",

    "Every 8 Hours",

    "Every 12 Hours"

]

#Generate Records
prescription_data=[]

for i in range (1,TOTAL_PRESCRIPTIONS +1):

    prescription_id=f"PR{i:07d}"

    appointment=random.choice(appointment_mapping)
    appointment_id=appointment["appointment_id"]
    patient_id=appointment["patient_id"]
    patient_name=appointment["patient_name"]
    doctor_id=appointment["doctor_id"]
    doctor_name=appointment["doctor_name"]
    prescription_date=appointment["appointment_date"]



    # dosage=random.choice(dosages)
    medicine = random.choice(list(medicine_map.keys()))

    dosage = random.choice(
        medicine_map[medicine]
    )
    # if i <= 10:
    #     print(medicine)
    medicine_take=random.choice(frequency)
    duration_days=random.randint(1,30)
    if dosage =="1 Tablet Once Daily":
        quantity= duration_days
    elif dosage == "1 Tablet Twice Daily":
        quantity = duration_days * 2
    elif dosage == "Every 8 Hours":
        quantity = duration_days * 3

    elif dosage == "5 ml Twice Daily":
        quantity = duration_days * 2

    elif dosage == "10 ml Once Daily":
        quantity = duration_days
    else:
        quantity = duration_days
    instructions=random.choice([   "Take after food",

        "Take before food",

        "Drink plenty of water",

        "Complete full course",

        "Bed Rest",

        "Avoid alcohol"])
    prescription_data.append({
        "prescription_id": prescription_id,
        "appointment_id": appointment_id,
        "patient_id": patient_id,
        "patient_name":patient_name,
        "doctor_id": doctor_id,
        "doctor_name":doctor_name,
        "prescription_date": prescription_date,
        "medicine_name": medicine,
        "dosage": dosage,
        "frequency": medicine_take,
        "duration_days": duration_days,
        "quantity": quantity,
        "instructions": instructions
    })



df=pd.DataFrame(prescription_data)

# Missing medicine name
rows=random.sample(range(len(df)),100)
for r in rows:
    df.loc[r,"medicine_name"] = None

#Missing Dosage

rows=random.sample(range(len(df)),100)
for r in rows:
    df.loc[r, "dosage"]= None

# Missing Instructions

rows = random.sample(range(len(df)),100)
for r in rows:
    df.loc[r, "instructions"]= None

# Duplicate rows:
duplicate_rows = df.sample(500, random_state=100)
df = pd.concat([df, duplicate_rows], ignore_index=True)

#invalid appointment ids

rows = random.sample(range(len(df)),50)
for r in rows:
    df.loc[r,"appointment_id"]="A999999"
# invalid medicine name

bad_medicine_name=[
    "", "Unknown", "123456", "@@@@@",  None
]
rows = random.sample(range(len(df)), 100)
for r in rows:
    df.loc[r,"medicine_name"]= random.choice(bad_medicine_name)

df.to_csv("../../csv/prescriptions.csv", index=False)

print("Prescription Generated Successfully")
print(f"Total Records : {len(df)}")


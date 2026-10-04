import pandas as pd
import  random
from faker import Faker
from datetime import datetime,date



fake=Faker("en_IN")
random.seed(100)
Faker.seed(100)

TOTAL_PATIENTS= 200000

blood_groups = random.choices([
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
],
    weights=[12,8,14,6,25,15,11,9])[0]

from utils.map import (
    state_city_map
)
city_weights = {
    "Maharashtra": [30, 25, 15, 5, 10, 5, 6, 4],
    "Karnataka": [60, 15, 15, 10],
    "Gujarat": [40, 25, 20, 15],
    "Tamil Nadu": [50, 20, 15, 15],
    "Delhi": [70, 30],
    "Rajasthan": [45, 20, 20, 15],
    "Uttar Pradesh": [35, 20, 15, 15, 15],
    "West Bengal": [60, 20, 20],
    "Punjab": [40, 25, 20, 15],
    "Telangana": [60, 15, 15, 10]
}

patient_data=[]

for i in range(1, TOTAL_PATIENTS +1):
    patient_id=f"P{i:06d}"
    gender=random.choice(["Male","Female"])
    # blood_groups=random.choice(blood_groups)
    patient_name=fake.name_male() if gender=="Male" else fake.name_female()
    phone=str(random.randint(6666666666,9999999999))
    dob=fake.date_of_birth(
        minimum_age=1,
        maximum_age=90
    )
    created_date=fake.date_between(
        start_date=dob,
        end_date="today"
    )
    updated_date=fake.date_between(
        start_date=created_date,
        end_date="today"
    )

    # Calculate age
    today = date.today()
    age = today.year - dob.year - (
            (today.month, today.day) < (dob.month, dob.day)
    )

    # Height & Weight by age
    if age <= 2:
        height_cm = random.randint(50, 95)
        weight_kg = random.randint(3, 15)

    elif age <= 5:
        height_cm = random.randint(90, 120)
        weight_kg = random.randint(12, 25)

    elif age <= 12:
        height_cm = random.randint(115, 155)
        weight_kg = random.randint(20, 55)

    elif age <= 18:
        height_cm = random.randint(145, 185)
        weight_kg = random.randint(40, 85)

    elif age <= 60:
        height_cm = random.randint(150, 190)

        bmi = random.uniform(18.5, 30)
        weight_kg = round(bmi * ((height_cm / 100) ** 2))

    else:  # Senior citizens
        height_cm = random.randint(145, 185)

        bmi = random.uniform(18, 28)
        weight_kg = round(bmi * ((height_cm / 100) ** 2))

    # state = random.choice(list(states.keys()))
    state=random.choices(list(state_city_map.keys()),
             weights=[20,15,10,5,6,7,12,8,10,7])[0]
    # city = random.choice(states[state])
    city=random.choices(state_city_map[state], weights=city_weights[state])[0]

    pincode=random.randint(000000,999999)
    patient_data.append({
        "patient_id": patient_id,
        "patient_name":patient_name,
        "gender": gender,
        "dob": dob,
        "age": age,
        "phone": phone,
        "blood_group": random.choice(blood_groups),
        "height_cm": height_cm,
        "weight_kg": weight_kg,
        "city": city,
        "state": state,
        "pincode": pincode,
        "created_date": created_date,
        "updated_date": updated_date,

    })

df=pd.DataFrame(patient_data)


#duplicate rows
duplicate_rows = df.sample(500,random_state=100)
df=pd.concat([df,duplicate_rows],ignore_index=True)


#invalid blood groups

bad_blood_groups = [
    "AA+",
    "A++",
    "X",
    "ABC",
    "",
    None
]
rows = random.sample(range(len(df)), 250)
for r in rows:
    df.loc[r, "blood_group"] = random.choice(bad_blood_groups)
# case different

rows = random.sample(range(len(df)), 300)

for r in rows:
    style = random.choice(["upper", "lower", "title", "mixed"])

    if style == "upper":
        df.loc[r, "patient_name"] = df.loc[r, "patient_name"].upper()

    elif style == "lower":
        df.loc[r, "patient_name"] = df.loc[r, "patient_name"].lower()

    elif style == "title":
        df.loc[r, "patient_name"] = df.loc[r, "patient_name"].title()

    else:
        df.loc[r, "patient_name"] = " ".join(
            word.upper() if random.random() > 0.5 else word.lower()
            for word in df.loc[r, "patient_name"].split()
        )

# Invalid phones

bad_phone = [
    "123456",
   "abcde",
    "99999999999999",
    "",
    "0000000000"
]
rows = random.sample(range(len(df)),250)
for r in rows:
    df.loc[r,"phone"] = random.choice(bad_phone)

# Dataframe and save


df.to_csv("../../csv/patients.csv",index=False)

print("Patients Generated Successfully")
print(f"Total Patients {len(df)}")
import pandas as pd
import random
from faker import Faker
# from datetime import datetime


fake=Faker("en_IN")

random.seed(100)
Faker.seed(100)


TOTAL_DOCTORS = 20000
hospital_df=pd.read_csv("../../csv/hospitals.csv")
print("Total Hospitals : ",len(hospital_df))
# hospital_ids=(
#     hospital_df["hospital_id"]
#     .drop_duplicates()
#     .tolist()
# )
hospital_mapping=hospital_df[[ "hospital_id","hospital_name","city","state"]].to_dict("records")
specializations = [
    "Cardiology",
    "Neurology",
    "Orthopedics",
    "General Medicine",
    "Pediatrics",
    "Dermatology",
    "ENT",
    "Psychiatry",
    "Radiology",
    "Oncology",
    "Gynecology",
    "Urology",
    "Nephrology",
    "Dentistry"
]
specialization_weights=[10,5,15,7,3,4,6,8,2,9,11,7,6,7]

qualification_map = {
    "Cardiology":["MBBS","MD","DM Cardiology"],
    "Neurology":["MBBS","MD","DM Neurology"],
    "Orthopedics":["MBBS","MS Orthopedics"],
    "General Medicine":["MBBS","MD"],
    "Pediatrics":["MBBS","MD Pediatrics"],
    "Dermatology":["MBBS","MD Dermatology"],
    "ENT":["MBBS","MS ENT"],
    "Psychiatry":["MBBS","MD Psychiatry"],
    "Radiology":["MBBS","MD Radiology"],
    "Oncology":["MBBS","DM Oncology"],
    "Gynecology":["MBBS","MS Gynecology"],
    "Urology":["MBBS","MCh Urology"],
    "Nephrology":["MBBS","DM Nephrology"],
    "Dentistry":["BDS","MDS"]
}

doctor_data = []
print("Loop Started")
for i in range(1, TOTAL_DOCTORS +1):
    doctor_id = f"D{i:06d}"
    # hospital_id=random.choice(hospital_ids)
    hospital=random.choice(hospital_mapping)
    hospital_id=hospital["hospital_id"]
    hospital_name=hospital["hospital_name"]
    city=hospital["city"]
    state=hospital["state"]
    specialization= random.choices(specializations,
                       weights=specialization_weights)[0]
    qualification = random.choice(qualification_map[specialization])
    gender=random.choice(["Male","Female"])

    doctor_name=fake.name_male() if gender == "Male" else fake.name_female()
    phone=str(random.randint(6666666666,9999999999))
    email=(doctor_name.lower()+ "@gmail.com")

    experience=random.randint(1,25)
    # consultation_fee = random.randint(400,10000)
    if experience <= 3:
        consultation_fee = random.randint(500,1500)
    elif experience <=10:
        consultation_fee = random.randint(1500,5000)
    elif experience <= 20:
        consultation_fee=random.randint(3000,8000)
    else:
        consultation_fee=random.randint(5000,10000)

    joining_date=fake.date_between(
        start_date=f"-{experience}y",
        end_date="today"
    )


    doctor={
        "doctor_id":doctor_id,
        "hospital_id":hospital_id,
        "hospital_name":hospital_name,
        "city":city,
        "state":state,
        "doctor_name":doctor_name,
        "gender":gender,
        "specialization":specialization,
        "qualification":qualification,
        "experience_years":experience,
        "consultation_fee":consultation_fee,
        "phone":phone,
        "email":email,
        "joining_date":joining_date,
    }
    doctor_data.append(doctor)

# Data Frame
df=pd.DataFrame(doctor_data)

#duplicate rows
duplicate_rows = df.sample(200,random_state=100)
df=pd.concat([df,duplicate_rows],ignore_index=True)

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

# Save data
df.to_csv("../../csv/doctors.csv",index=False)

print("="*50)
print("Doctors Generated Successfully")
print(f"Total Records : {len(df)}")

print("="*50)




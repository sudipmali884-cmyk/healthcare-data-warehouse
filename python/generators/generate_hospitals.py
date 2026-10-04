# step 1 - import libraries
import pandas as pd
import random
from faker import Faker
from datetime import datetime

from python.generators.generate_patients import updated_date

#Step 2 - faker
fake=Faker("en_IN")
random.seed(100)
Faker.seed(100)


#Step 3 - configurations
TOTAL_HOSPITALS = 500

# Step 4 - hospitals names

hospital_prefix=[
"Apollo",
    "Fortis",
    "Medan",
    "Max",
    "Ruby Hall",
    "AIIMS",
    "KIMS",
    "Unique",
    "Manipal",
    "Jupiter",
    "Lotus",
    "Sunrise",
    "Lifeline",
    "Global",
    "Care",
    "Shree",
    "Unity",
    "Cambridge",
    "Wellness",
    "Hope",
    "Apex",
    "Sanjeevani"
]
hospital_suffix = [

    "Hospital",
    "Medical Center",
    "Institute",
    "Clinic",
    "Health Care",
    "Super Specialty Hospital"

]

hospital_type = [

    "Private",
    "Government",
    "Trust",
    "Charitable"

]
states = {

    "Maharashtra":[
        "Mumbai",
        "Pune",
        "Nagpur",
        "Nashik",
        "Solapur",
        "Kolhapur",
        "Sambhajinagar"
    ],

    "Karnataka":[
        "Bengaluru",
        "Mysuru",
        "Hubli",
        "Mangalore"
    ],

    "Gujarat":[
        "Ahmedabad",
        "Surat",
        "Vadodara",
        "Rajkot"
    ],

    "Tamil Nadu":[
        "Chennai",
        "Coimbatore",
        "Madurai",
        "Salem"
    ],

    "Delhi":[
        "New Delhi"
    ],

    "Telangana":[
        "Hyderabad",
        "Warangal"
    ]

}

#Step 6 - generate records

hospital_data=[]
for i in range (1, TOTAL_HOSPITALS + 1):
    hospital_id=f"H{i:06d}"
    state=random.choice(list(states.keys()))
    city=random.choice(states[state])
    name=random.choice(hospital_prefix)+ " "+ random.choice(hospital_suffix)
    phone=str(random.randint(6666666666,9999999999))
    email=name.lower().replace(" ", "")+ "@hospital.com"
    beds=random.randint(150,1000)

    established_date = fake.date_between(
        start_date="-70y",
        end_date="-1y"
    )

    created_date = fake.date_between(
        start_date=established_date,
        end_date="today"
    )
    # established=random.randint(1950,2024)
    # created_date = fake.date_between(
    #     start_date="-50y",
    #     end_date="today"
    # )

    updated_date=fake.date_between(
        start_date=created_date,
        end_date="today"
    )

    hospital_data.append({
        "hospital_id": hospital_id,
        "hospital_name": name,
        "hospital_type": random.choice(hospital_type),
        "city": city,
        "state": state,
        "phone": phone,
        "email": email,
        "bed_count": beds,
        "established_year": established_date,
        "created_date": created_date,
        "updated_date":updated_date
    })

df=pd.DataFrame(hospital_data)

#missing values

for col in ["city","phone","email"]:
    rows=random.sample(range(len(df)),15)
    df.loc[rows,col]=None

# -----------------------------
# Duplicate Rows
# -----------------------------

duplicate_rows = df.sample(10,random_state=100)
df=pd.concat([df,duplicate_rows],ignore_index=True)

# -----------------------------
# Mixed Case
# -----------------------------

rows = random.sample(range(len(df)),60)
for r in rows:
    value=df.loc[r,"hospital_type"]
    option=random.randint(1,3)
    if option == 1:
        df.loc[r,"hospital_type"] = value.upper()

    elif option == 2:

        df.loc[r,"hospital_type"] = value.lower()
    else:
        df.loc[r,"hospital_type"] = value.title()

# -----------------------------
# Invalid Phones
# -----------------------------

bad_phone = [

    "12345",
    "999999999999999",
    "abcdefghij",
    "0000000000",
    "",
    "98AB123456"
]
rows = random.sample(range(len(df)),20)

for r in rows:
    df.loc[r,"phone"] = random.choice(bad_phone)

# -----------------------------
# Invalid Emails
# -----------------------------

bad_email = [

    "abcgmail.com",
    "apollo@",
    "@gmail.com",
    "hospital",
    "",
    "abc#gmail.com"

]
rows = random.sample(range(len(df)),20)
for r in rows:
    df.loc[r,"email"] = random.choice(bad_email)


# Save csv
df.to_csv("../../csv/hospitals.csv",index=False)
print("="*50)
print("Hospitals Generated Successfully")
print("Total Records : ",len(df))
print("="*50)
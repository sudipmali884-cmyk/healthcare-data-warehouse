# Healthcare Data Warehouse & Analytics

An end-to-end Healthcare Data Warehouse and Analytics project built using Python, Snowflake, dbt, SQL, and Power BI.

## 🚀 Project Architecture

Python ↓ CSV Files ↓ Snowflake RAW ↓ dbt STAGING ↓ dbt INTERMEDIATE ↓ dbt MARTS ↓ Power BI

## 🛠️ Technologies Used

- Python
- Pandas
- Faker
- SQL
- Snowflake
- dbt
- Power BI
- DAX
- Git
- GitHub
- Azure

## 📊 Data Warehouse

The project contains data related to:

- Patients
- Doctors
- Hospitals
- Appointments
- Prescriptions
- Insurance

## 🏗️ dbt Data Models

### Dimensions

- dim_patients
- dim_doctors
- dim_hospitals
- dim_date

### Facts

- fact_appointments
- fact_prescriptions
- fact_insurance

## 🔄 Data Transformation

The data follows a layered architecture:

### RAW

Raw healthcare CSV data is loaded into Snowflake without major transformations.

### STAGING

Data cleaning, standardization, data type conversion, and basic validation are performed.

### INTERMEDIATE

Business logic, joins, calculations, and reusable transformations are applied.

### MARTS

Dimensional models and fact tables are created for analytics and reporting.

## 🔗 Data Relationships

The project maintains relationships between healthcare datasets.

Examples:

- Patients → Appointments
- Doctors → Appointments
- Hospitals → Doctors
- Hospitals → Appointments
- Patients → Prescriptions
- Doctors → Prescriptions
- Patients → Insurance

Referential integrity is validated using dbt tests and SQL validation queries.

## 📈 Power BI Dashboard

The Power BI dashboard contains:

1. Executive Dashboard
2. Patient Analytics
3. Doctor Analytics
4. Appointment Analytics
5. Hospital Analytics
6. Insurance Analytics Dashboard
7. Prescription Analytics

### Key KPIs

- Total Patients
- Total Doctors
- Total Hospitals
- Total Appointments
- Completed Appointments
- Cancelled Appointments
- Total Prescriptions
- Insurance Policies
- Insurance Coverage
- Consultation Revenue

## 🧹 Data Quality

The project includes realistic data-quality scenarios such as:

- Duplicate records
- NULL values
- Blank values
- Invalid phone numbers
- Invalid email addresses
- Incorrect data types
- Inconsistent formatting
- Extra spaces
- Mixed uppercase/lowercase values
- Negative values
- Invalid dates
- Future dates
- Invalid foreign-key relationships

dbt models and tests are used to clean, validate, and improve data quality and reliability.

## 🔐 Snowflake Security

The project also demonstrates Snowflake security concepts such as:

- Role-Based Access Control (RBAC)
- Masking Policies
- Row Access Policies
- Secure Views

These features help protect sensitive healthcare information and control data access.

## 🧪 Data Quality Testing

dbt tests are used to validate:

- Primary key uniqueness
- NOT NULL constraints
- Foreign key relationships
- Accepted values
- Referential integrity
- Data consistency

## 🎯 Key Learning Outcomes

Through this project, I practiced:

- ETL/ELT pipeline development
- Data warehouse architecture
- Python data generation
- Snowflake data loading
- SQL transformations
- dbt modeling
- Staging / Intermediate / Mart architecture
- Dimensional modeling
- Star schema
- Data quality testing
- Referential integrity
- Snowflake security
- Power BI dashboard development
- DAX
- Git and GitHub

## 👨‍💻 Author

Sudip Mali

GitHub: https://github.com/sudipmali884-cmyk
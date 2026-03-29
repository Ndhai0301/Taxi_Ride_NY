# 🚕 NYC Taxi Drives Data Modeling (dbt Project)

## 📌 Project Overview
This repository contains a data transformation project using **dbt (data build tool)**. The project processes and models the famous **New York City Taxi Trip Data** (Green and Yellow cabs), transforming raw transactional data into a clean, analytics-ready Star Schema for reporting and BI purposes.

## 🏗️ Data Architecture & Modeling

The project strictly follows dbt best practices, organizing models into distinct layers:

1. **Sources (`sources.yml`)**: Defines the raw data tables loaded into the data warehouse.
2. **Staging (`models/staging/`)**: 
   - `stg_green_tripdata.sql` & `stg_yellow_tripdata.sql`: Base views that handle renaming, type casting, and basic data cleaning.
3. **Intermediate (`models/intermediate/`)**: 
   - `int_trips_unioned.sql`: Unions the cleaned Yellow and Green taxi datasets into a single unified trips model.
4. **Marts (`models/marts/`)**: The core business logic layer forming a Star Schema.
   - **Dimensions**: `dim_vendors.sql`, `dim_zones.sql` (contextual data).
   - **Facts**: `fct_trips.sql` (transactional metrics).
5. **Reporting (`models/marts/reporting/`)**:
   - `monthly_revenue_per_locations.sql`: An aggregated model ready to be plugged into a BI tool for end-user analysis.

### 🌟 Key Features
- **Data Ingestion script:** Includes a custom `ingest.py` script to fetch and load raw data.
- **Macros:** Implements DRY (Don't Repeat Yourself) principles using custom macros like `get_vendors_names.sql`.
- **Seeds:** Uses `taxi_zone_lookup.csv` to map location IDs to actual NYC zones and boroughs.
- **Package Management:** Utilizes external dbt packages (configured in `packages.yml`).

---

## 📂 Repository Structure

```text
taxi_drives_ny/
├── analyses/                  # Ad-hoc analytical queries
├── macros/                    # Reusable SQL macros
│   └── get_vendors_names.sql
├── models/                    # dbt SQL models
│   ├── staging/               # Cleaned raw data
│   ├── intermediate/          # Complex transformations (unions, joins)
│   ├── marts/                 # Business-level entities (Fact & Dim tables)
│   │   └── reporting/         # Aggregated BI-ready tables
│   ├── sources.yml            # Source definitions
│   └── schema.yml             # Documentation and tests
├── seeds/                     # Static CSV data
│   └── taxi_zone_lookup.csv
├── tests/                     # Custom singular tests
├── ingest.py                  # Python script for raw data ingestion
├── dbt_project.yml            # dbt project configuration
└── packages.yml               # dbt package dependencies

---

🚀 Getting Started
⚙️ Prerequisites

Before running this project, make sure you have:

Python 3.8+
dbt-core and a compatible adapter
(e.g., dbt-duckdb, dbt-postgres, dbt-bigquery, dbt-snowflake)
A configured data warehouse environment
1️⃣ Clone the repository
git clone <your-repository-url>
cd taxi_drives_ny
2️⃣ Install dependencies

It is recommended to use a virtual environment:

python -m venv venv
venv\Scripts\activate   # Windows
# source venv/bin/activate  # Mac/Linux

pip install -r requirements.txt
3️⃣ Configure dbt profile

Ensure your dbt profile is correctly set up:

File location: ~/.dbt/profiles.yml
Profile name must match dbt_project.yml (e.g., taxi_drives_ny)
4️⃣ Ingest raw data

Run the ingestion script to load NYC Taxi data:

python ingest.py
5️⃣ Run dbt pipeline

Execute the following commands:

# Install dbt packages (e.g., dbt-utils)
dbt deps

# Load seed data (taxi zones)
dbt seed

# Run models
dbt run

# Run tests (data quality checks)
dbt test
📊 Documentation & Lineage

Generate and explore the dbt documentation:

dbt docs generate
dbt docs serve

👉 Open in browser: http://localhost:8080

You can explore:

Data lineage (DAG)
Model dependencies
Table documentation
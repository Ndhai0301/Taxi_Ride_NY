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

```

---
🚀 Getting Started
Prerequisites
Python 3.8+
dbt-core and the specific adapter for your Data Warehouse (e.g., dbt-postgres, dbt-bigquery, dbt-snowflake).
A running instance of your chosen Data Warehouse.
1. Clone the repository
code
Bash
git clone <your-repository-url>
cd taxi_drives_ny
2. Install dependencies
It is recommended to use a virtual environment:
code
Bash
python -m venv venv
source venv/bin/activate  # On Windows use: venv\Scripts\activate
pip install -r requirements.txt # Make sure dbt-core and your adapter are listed here
3. Configure your profile
Ensure your ~/.dbt/profiles.yml is configured to connect to your target data warehouse. The profile name should match the one defined in dbt_project.yml (e.g., taxi_drives_ny).
4. Ingest Raw Data
Run the ingestion script to download and load the raw NYC Taxi data into your data warehouse:
code
Bash
python ingest.py
5. Run dbt
Execute the following dbt commands to build the project:
code
Bash
---
# 1. Install dbt packages (e.g., dbt-utils)
```bash
dbt deps
```
# 2. Load the seed file (taxi zones) into the database
```bash
dbt seed
```

# 3. Run all models
```bash
dbt run
```
# 4. Test the models (Primary keys, null checks, accepted values, etc.)
```bash
dbt test
```
---
# 📊 Generating Documentation
To generate and view the project's data dictionary and lineage graph (DAG), run:
code
Bash
dbt docs generate
dbt docs serve
This will open a local web server (typically at http://localhost:8080) where you can explore the relationships between your source data, staging models, facts, dimensions, and reports.

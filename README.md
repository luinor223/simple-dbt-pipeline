# Simple DBT Pipeline

A data transformation pipeline built with dbt (data build tool).

## Getting Started

This project uses dbt to transform and model data. 

### Prerequisites

- Python 3.7+
- dbt-core
- A data warehouse (Snowflake, BigQuery, PostgreSQL, etc.)

### Installation

```bash
pip install dbt-core
# Install your specific adapter, e.g.:
# pip install dbt-snowflake
# pip install dbt-bigquery
# pip install dbt-postgres
```

### Setup

1. Clone this repository
2. Configure your `profiles.yml` file
3. Run `dbt deps` to install dependencies
4. Run `dbt run` to execute the models

## Project Structure

```
├── models/          # dbt models
├── macros/          # dbt macros
├── seeds/           # CSV files for dbt seed
├── snapshots/       # dbt snapshots
├── tests/           # dbt tests
└── dbt_project.yml  # dbt project configuration
```

## Usage

```bash
# Run all models
dbt run

# Run tests
dbt test

# Generate and serve documentation
dbt docs generate
dbt docs serve
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests
5. Submit a pull request

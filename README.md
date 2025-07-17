# Simple DBT Pipeline

A data transformation pipeline built with dbt (data build tool) and DuckDB.

## Getting Started

This project uses dbt to transform and model data with DuckDB as the database engine. DuckDB is an embedded analytical database that's perfect for local development and analytics.

### Prerequisites

- Python 3.7+
- dbt-duckdb

### Installation

```bash
# Create a virtual environment (recommended)
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install dbt with DuckDB adapter
pip install dbt-duckdb
```

### Setup

1. Clone this repository
2. Activate your virtual environment
3. Install dependencies: `pip install dbt-duckdb`
4. Test the setup: `dbt debug --profiles-dir .`
5. Run the models: `dbt run --profiles-dir .`

### Database Configuration

This project uses DuckDB with the following configuration:
- **Development database**: `data/dev.duckdb`
- **Production database**: `data/prod.duckdb`
- **Profile location**: `./profiles.yml` (in the project root)

## Project Structure

```
├── models/          # dbt models
├── macros/          # dbt macros
├── seeds/           # CSV files for dbt seed
├── snapshots/       # dbt snapshots
├── tests/           # dbt tests
├── data/            # DuckDB database files (gitignored)
├── profiles.yml     # dbt profile configuration
└── dbt_project.yml  # dbt project configuration
```

## Usage

```bash
# Run all models
dbt run --profiles-dir .

# Run tests
dbt test --profiles-dir .

# Generate and serve documentation
dbt docs generate --profiles-dir .
dbt docs serve --profiles-dir .

# Debug configuration
dbt debug --profiles-dir .
```

## DuckDB Benefits

- **No setup required**: DuckDB is embedded, no server installation needed
- **Fast analytics**: Optimized for analytical workloads
- **SQL compatible**: Standard SQL with analytics extensions
- **Portable**: Database files can be easily shared and backed up
- **Memory efficient**: Works well with limited resources

### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

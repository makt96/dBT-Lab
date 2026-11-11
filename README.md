## Production Deployment — dbt Cloud

### Overview

This lab demonstrates how to deploy a dbt project from a development branch to the `main` branch and execute dbt models through a production deployment job in dbt Cloud.

The deployment workflow follows a Git-based development and production process.

### Deployment Architecture

```text
Development Work
      |
      v
GitHub Feature Branch
      |
      v
Pull Request
      |
      v
Merge into main
      |
      v
dbt Cloud Production Environment
      |
      v
Production Deployment Job
      |
      v
dbt run
      |
      v
Snowflake
      |
      v
DBT_LEARNING_DB.DBT_MKADIR
```

### 1. GitHub Deployment Preparation

- Worked on the `feature/dbt-project-initialization` branch.
- Created a pull request targeting `main`.
- Reviewed the changes.
- Successfully merged the feature branch into `main`.

### 2. Production Environment Configuration

Created a deployment environment in dbt Cloud.

| Setting | Configuration |
|---|---|
| Environment | Production |
| Environment Type | Deployment |
| Deployment Type | PROD |
| dbt Version | v2 Stable |
| Connection Profile | production_profile |
| Authentication | Snowflake Key Pair |
| Database | DBT_LEARNING_DB |
| Schema | DBT_MKADIR |
| Warehouse | DBT_LAB_WH |
| Role | DBT_DEVELOPER_ROLE |

### 3. Production Job Configuration

Created a dbt Cloud deployment job with the following configuration:

| Setting | Value |
|---|---|
| Job Name | prod job |
| Environment | Production |
| Command | `dbt run` |
| Schedule | Off |
| Run Source Freshness | Disabled |
| Threads | 4 |
| Deferral | No deferral |

The job was executed manually using **Run now**.

### 4. Deployment Results

<details>
<summary>Successful deployment details</summary>

- Job status: Success
- Run ID: `70506184183250`
- dbt command: `dbt run`
- Models executed: 5
- Model failures: 0
- Model warnings: 0

Models successfully created or replaced as Snowflake views:

1. `trip_fact`
2. `station_dimension`
3. `date_dimension`
4. `dailyweather`
5. `weather_bike_correlation`

</details>

### 5. Snowflake Production Verification

Connected to Snowflake using SnowSQL and verified the deployed views.

```sql
USE DATABASE DBT_LEARNING_DB;

SHOW VIEWS IN SCHEMA DBT_MKADIR;
```

The command returned 6 rows.

Verified that the `WEATHER_BIKE_CORRELATION` view was queryable:

```sql
SELECT COUNT(*)
FROM DBT_LEARNING_DB.DBT_MKADIR.WEATHER_BIKE_CORRELATION;
```

**Result:** `17,548,339` rows.

### 6. Skills Practiced

- Git branching and pull requests
- Merging development work into `main`
- dbt Cloud deployment environments
- Snowflake key-pair authentication
- Production job configuration
- Automated dbt model execution
- Snowflake deployment verification
- Understanding the development-to-production workflow

### 7. Notes

The deployment environment was configured with the `DBT_MKADIR` schema. This lab did not create a separate production schema.

The deployment logs also showed non-blocking configuration warnings about unused schema YAML entries and an unused dbt project configuration path. These did not prevent the deployment from succeeding.

---

**Lab Status:** Successfully completed

**Technologies:** GitHub | dbt Cloud | dbt | Snowflake | SnowSQL

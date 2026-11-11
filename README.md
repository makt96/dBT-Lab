## Production Deployment — dbt Cloud

### Overview

This lab demonstrates a Git-based dbt deployment workflow using GitHub, dbt Cloud, and Snowflake.

The project was developed in a feature branch, reviewed through a pull request, merged into `main`, and deployed using a dbt Cloud production job.

### 1. GitHub Workflow

- Development branch: `feature/dbt-project-initialization`
- Production branch: `main`
- Created a pull request targeting `main`.
- Reviewed and merged the changes.
- Committed the staging-layer implementation and updated model dependencies.

### 2. Production Environment

Configured a deployment environment in dbt Cloud.

| Configuration | Value |
|---|---|
| Environment | Production |
| Environment type | Deployment |
| Deployment type | PROD |
| dbt version | v2 Stable |
| Connection | Snowflake |
| Connection profile | production_profile |
| Authentication | Key Pair |
| Database | DBT_LEARNING_DB |
| Schema | DBT_MKADIR |
| Warehouse | DBT_LAB_WH |
| Role | DBT_DEVELOPER_ROLE |

### 3. Production Job

Created a dbt Cloud deployment job named `prod job`.

| Setting | Value |
|---|---|
| Job name | prod job |
| Environment | Production |
| Command | `dbt run` |
| Schedule | Disabled |
| Threads | 4 |
| Deferral | No deferral |

The job was executed manually using **Run now**.

### 4. Updated dbt Architecture

Introduced a staging layer to clean raw bike data before downstream transformations.

**Bike data pipeline:**

```text
demo.bike
    |
    v
stg_bike
    |
    |------ date_dimension
    |
    |------ station_dimension
    |
    |------ trip_fact
                 |
                 |
                 v
       weather_bike_correlation
```

**Weather data pipeline:**

```text
demo.weather
      |
      v
 dailyweather
      |
      |
      v
weather_bike_correlation
```

The final correlation model combines the bike trip data with daily weather data.

### 5. Final dbt Models

The project contains six SQL models:

| Model | Purpose |
|---|---|
| `stg_bike` | Cleans and standardizes raw bike data |
| `date_dimension` | Creates date-related analytical attributes |
| `station_dimension` | Builds station-level dimensional data |
| `trip_fact` | Creates the bike trip fact model |
| `dailyweather` | Aggregates daily weather information |
| `weather_bike_correlation` | Combines bike trip and weather data |

### 6. Production Deployment Results

After merging the updated models into `main`, the production deployment job was executed again.

**Verified deployment results:**

- Environment: Production
- Job: `prod job`
- Execution status: Success
- Execution time: 14 seconds
- dbt version: v2 Stable
- All six models displayed successful execution status in the lineage view.

### 7. Snowflake Verification

The deployed models were previously verified in Snowflake using:

```sql
USE DATABASE DBT_LEARNING_DB;

SHOW VIEWS IN SCHEMA DBT_MKADIR;
```

The `WEATHER_BIKE_CORRELATION` view was also queried:

```sql
SELECT COUNT(*)
FROM DBT_LEARNING_DB.DBT_MKADIR.WEATHER_BIKE_CORRELATION;
```

Previously observed result:

**17,548,339 rows**

### 8. Skills Practiced

- Git branching and pull request workflows
- dbt staging-layer architecture
- dbt `source()` and `ref()` dependencies
- SQL-based data transformation
- dbt lineage and dependency analysis
- dbt Cloud deployment environments
- Snowflake Key Pair authentication
- Production job configuration
- Production execution monitoring
- Snowflake model verification

### 9. Important Environment Note

The dbt Cloud environment is named `Production`, but the configured Snowflake schema is `DBT_MKADIR`. A separate production schema was not created in this lab.

The successful deployment confirms that the six models executed successfully. Separate data-quality test results should be documented after running `dbt test`.

---

**Deployment Status:** Successfully deployed

**Technologies:** GitHub | dbt Cloud | dbt | Snowflake | SnowSQL

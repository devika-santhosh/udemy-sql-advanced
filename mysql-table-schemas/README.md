# MySQL Table Schemas

MySQL CREATE TABLE statements for a baseball statistics database.

## Tables

| Table | Description |
|-------|-------------|
| `players` | Player information (birth, death, name, physical stats) |
| `salaries` | Player salary data by year and team |
| `schools` | Player-school relationships |
| `school_details` | School information |

## Usage

Run all schemas:

```sql
SOURCE setup.sql;
```

Or run individual schemas:

```sql
USE maven_advanced_sql;
SOURCE schemas/players.sql;
SOURCE schemas/salaries.sql;
SOURCE schemas/schools.sql;
SOURCE schemas/school_details.sql;
```

## Schema

- **players**: 22 columns (playerID as primary key)
- **salaries**: 5 columns (composite primary key: yearID, teamID, playerID)
- **schools**: 3 columns (composite primary key: playerID, schoolID, yearID)
- **school_details**: 5 columns (schoolID as primary key)

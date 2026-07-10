# ALTICO_5G Data cleaning

## Project Overview
This project builds a structured MySQL database to analyze ALTICO's telecom performance across Indian cities, focused on comparing market performance before and after 5G rollout. It consolidates plan revenue, user activity/ARPU, and market share data by city to support strategic decisions around 5G expansion and competitive positioning.

## Dataset Description
Four related tables make up the schema:
- **plan**: Plan-level data — city, month, generation (gen, e.g. 4G/5G), plan type, plan revenue (in crores), and plan description.
- **users_activeness**: User activity data — active users, unsubscribed users, ARPU (Average Revenue Per User), ATLICO revenue, company, city, month, and time period.
- **before_vs_after_5g**: Market comparison data — total market value (TMV) per city, market share percentage, company, city, month, and generation, enabling before/after 5G comparisons.
- **city**: A lookup table mapping city codes to city names, used to standardize city references across the other three tables.

## Data Cleaning & Preparation
- **City code standardization**: Numeric city codes (e.g. 110001, 122001) were mapped to readable city names (Ahmedabad, Bangalore, Chandigarh, etc.) across all three main tables.
- **Date conversion**: String-formatted date columns were converted to proper `DATE` types across all three tables (handling multiple different string date formats).
- **Currency/number cleanup**: Columns stored as strings with `$` symbols (e.g. `tmv_city_crores`, `atlico_revenue_crores`, `arpu`) were cleaned and cast to proper integer types.
- **Referential integrity**: Foreign key constraints were added linking `city_code` (and city name) across `plan`, `users_activeness`, and `before_vs_after_5g` back to the `city` table, ensuring consistent city references throughout the database.

## Key Findings / Analysis Output
A unified view (`v_ATLICO_data`) was created joining `plan`, `users_activeness`, and `before_vs_after_5g` on city code — bringing together plan revenue, market TMV, ATLICO revenue, and ARPU into a single queryable dataset per city, per month, per generation (4G vs 5G). This view is the foundation for comparing:
- Plan revenue trends by city and generation
- ATLICO's revenue and ARPU relative to overall market TMV per city
- How performance shifted before vs. after 5G rollout, city by city

## Recommendation / Tool
The `v_ATLICO_data` view acts as a ready-made analytical base table — instead of re-joining plan, user activity, and market data every time, analysts or BI tools (e.g. Power BI, Tableau) can query this single view directly to build dashboards comparing:
- Revenue and ARPU growth after 5G rollout by city
- Which cities show the strongest/weakest 5G adoption relative to market size
- Plan performance segmented by generation (4G vs 5G) and city

## Tools & Technology
- MySQL
- Foreign key constraints for data integrity across normalized tables
- Views for reusable, join-free analytical querying

## Notes
- Line 139 (`ALTER TABLE plan DROP new_city_name;`) references a column that doesn't appear to have been created — earlier in the script the column added and updated is `city_code_name`, not `new_city_name`. This line will likely error and should be corrected to `DROP city_code_name` (or removed if not intended).
- Line 163 (`ALTER TABLE users_activeness DROP city;`) drops a `city` column that was never explicitly created in the original `CREATE TABLE users_activeness` statement — worth double-checking this against the actual table structure to confirm it doesn't error.
- Company/table naming is inconsistent between "ALTICO" (repo/file name) and "ATLICO" (used throughout the SQL script, e.g. `atlico_revenue_crores`) — worth standardizing to one spelling before sharing publicly.

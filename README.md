# HR Attrition Analysis

A SQL + Power BI analysis of employee attrition, exploring which departments, recruitment sources, performance levels, and attendance patterns are most associated with employees leaving the company.

## Problem Statement

What factors are most strongly associated with employee attrition, and which departments or hiring channels carry the highest retention risk?

## Dataset

**Human Resources Data Set (HRDataset_v14)**
- 311 employee records, 36 columns including department, salary, performance score, recruitment source, termination reason, and attendance data
- Source: Dr. Carla Patalano and Dr. Rich Huebner, available on [Kaggle](https://www.kaggle.com/datasets/rhuebner/human-resources-data-set)
- License: CC-BY-NC-ND — dataset is not redistributed in this repository; please download directly from the source link above

## Tools Used

- **PostgreSQL** — data storage and SQL analysis
- **Power BI** — dashboard and visualization

## Data Cleaning

- Loaded CSV export into a PostgreSQL table with explicit column typing
- Verified row count and column integrity post-import
- Created a derived `Status` column (Active/Terminated) in Power BI for readability

## SQL Analysis

Full queries available in [`queries.sql`](./queries.sql). Eight analyses were performed:
1. Attrition rate by department
2. Average salary comparison (terminated vs. active)
3. Attrition rate by recruitment source
4. Attrition rate by performance score
5. Attendance/lateness comparison (terminated vs. active)
6. Department attrition ranking (CTE + window function)
7. Engagement/satisfaction comparison (terminated vs. active)
8. Average tenure before leaving, by department

## Dashboard

Built in Power BI, connected live to PostgreSQL. Three pages:
- **Dashboard** — KPI cards (Total Employees, Overall Attrition Rate), Attrition by Department, Attrition by Recruitment Source, Attrition by Performance Score
- **Deep Analysis** — Average tenure before leaving by department, Engagement/Satisfaction comparison (Active vs. Terminated)
- **Insights** — Key findings and recommendations, in plain language

See screenshots: [`dashboard_1.png`](./dashboard_1.png), [`dashboard_2.png`](./dashboard_2.png)

## Key Insights

1. **Production is the highest-risk department** — it holds 67% of the workforce (209 of 311 employees) and has the highest attrition rate at 39.71%, making it the single largest source of turnover.
2. **Pay may be linked to attrition** — employees who left earned ₹65,690 on average, about ₹5,000 less than active employees (₹70,694).
3. **Recruitment source strongly predicts retention** — employees hired via Google Search left at 61.22%, nearly 4x higher than those hired via Employee Referral (16.13%).
4. **Performance and attrition are linked, but not the full story** — attrition drops as performance improves (55.56% for "Needs Improvement" vs 21.62% for "Exceeds"), yet even solid performers ("Fully Meets," 78% of workforce) show a high 33.33% attrition rate.
5. **Attendance patterns may signal early disengagement** — employees who left were late over 2x more often in their last 30 days (0.66 vs 0.29 average) than active employees.
6. **Engagement/satisfaction scores don't predict attrition** — self-reported engagement and satisfaction scores were nearly identical between active and terminated employees (4.12 vs 4.09, 3.89 vs 3.88), suggesting these survey metrics are not reliable predictors of who leaves — unlike pay, recruitment source, and attendance.
7. **Production shows slow attrition, Admin Offices shows fast attrition** — despite having the highest overall attrition rate, Production employees who leave typically stay nearly 4 years first, suggesting gradual disengagement. Admin Offices employees leave fastest (~13 months average), potentially pointing to onboarding or early role-fit issues.

## Limitations

Sample size is modest (311 employees), and some categories (e.g., Executive Office, n=1) have too few records for reliable conclusions and were excluded from key insights. Findings here are correlational, not causal — further investigation (e.g., exit interviews, manager input) would be needed to confirm actual drivers of attrition rather than coincidental patterns.

## Recommendations

1. Conduct targeted exit interviews and manager reviews within the Production department.
2. Review compensation bands for high-turnover roles to assess competitiveness.
3. Shift recruitment investment toward Employee Referral programs; reduce reliance on Google Search sourcing.
4. Introduce an early-warning system using attendance/lateness trends to flag at-risk employees.

## How to Reproduce

1. Download the dataset from the [Kaggle source link](https://www.kaggle.com/datasets/rhuebner/human-resources-data-set) above
2. Create a PostgreSQL database and run the table creation script at the top of `queries.sql`
3. Import the CSV into the `employees` table (e.g., using pgAdmin's Import/Export Data tool)
4. Run the analysis queries in `queries.sql`
5. Connect Power BI Desktop to the PostgreSQL database (Get Data → PostgreSQL database) and open `HR_Attrition_Dashboard.pbix`, or rebuild the visuals using the query results directly

## Files in This Repository

- `queries.sql` — all SQL queries used in the analysis
- `dashboard_screenshot.png` — screenshot of the Power BI dashboard (main page)
- `deep_analysis_screenshot.png` — screenshot of the Deep Analysis page
- `insights_screenshot.png` — screenshot of the Insights & Recommendations page
- `HR_Attrition_Dashboard.pbix` — the full Power BI file
- `README.md` — this file

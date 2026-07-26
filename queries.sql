-- HR Attrition Analysis - SQL Queries
-- Dataset: Human Resources Data Set (HRDataset_v14)
-- Source: Dr. Carla Patalano & Dr. Rich Huebner, Kaggle
-- Tool: PostgreSQL

-- ============================================
-- Table Creation
-- ============================================
CREATE TABLE employees (
    Employee_Name VARCHAR(100),
    EmpID INT,
    MarriedID INT,
    MaritalStatusID INT,
    GenderID INT,
    EmpStatusID INT,
    DeptID INT,
    PerfScoreID INT,
    FromDiversityJobFairID INT,
    Salary INT,
    Termd INT,
    PositionID INT,
    Position VARCHAR(100),
    State VARCHAR(10),
    Zip VARCHAR(20),
    DOB VARCHAR(20),
    Sex VARCHAR(5),
    MaritalDesc VARCHAR(50),
    CitizenDesc VARCHAR(50),
    HispanicLatino VARCHAR(10),
    RaceDesc VARCHAR(50),
    DateofHire VARCHAR(20),
    DateofTermination VARCHAR(20),
    TermReason VARCHAR(100),
    EmploymentStatus VARCHAR(50),
    Department VARCHAR(100),
    ManagerName VARCHAR(100),
    ManagerID INT,
    RecruitmentSource VARCHAR(100),
    PerformanceScore VARCHAR(50),
    EngagementSurvey DECIMAL(4,2),
    EmpSatisfaction INT,
    SpecialProjectsCount INT,
    LastPerformanceReview_Date VARCHAR(20),
    DaysLateLast30 INT,
    Absences INT
);

-- ============================================
-- Query 1: Attrition rate by department
-- Finds which department loses the most employees, as a percentage
-- ============================================
SELECT department,
       COUNT(*) AS total_employees,
       SUM(CASE WHEN termd = 1 THEN 1 ELSE 0 END) AS terminated,
       ROUND(SUM(CASE WHEN termd = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY department
ORDER BY attrition_rate_pct DESC;

-- ============================================
-- Query 2: Average salary - terminated vs active employees
-- Checks whether pay level relates to who leaves
-- ============================================
SELECT 
    CASE WHEN termd = 1 THEN 'Terminated' ELSE 'Active' END AS status,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY termd;

-- ============================================
-- Query 3: Recruitment source vs attrition
-- Checks whether hiring channel affects retention
-- ============================================
SELECT 
    recruitmentsource,
    COUNT(*) AS total_hired,
    SUM(CASE WHEN termd = 1 THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN termd = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY recruitmentsource
ORDER BY attrition_rate_pct DESC;

-- ============================================
-- Query 4: Performance score vs attrition
-- Checks whether performance rating relates to who leaves
-- ============================================
SELECT 
    performancescore,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN termd = 1 THEN 1 ELSE 0 END) AS left_company,
    ROUND(SUM(CASE WHEN termd = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_pct
FROM employees
GROUP BY performancescore
ORDER BY attrition_rate_pct DESC;

-- ============================================
-- Query 5: Absences and lateness - terminated vs active employees
-- Checks whether attendance patterns precede departure
-- ============================================
SELECT 
    CASE WHEN termd = 1 THEN 'Terminated' ELSE 'Active' END AS status,
    ROUND(AVG(absences), 2) AS avg_absences,
    ROUND(AVG(dayslatelast30), 2) AS avg_days_late
FROM employees
GROUP BY termd;

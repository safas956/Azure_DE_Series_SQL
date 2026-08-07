# 📅 SQL Date Functions — Hands-On Practice

## ☁️ Azure Data Engineering Journey | Day 4

This repository contains my hands-on SQL practice focused on **Date & Time Functions in SQL Server**.

The objective was not just to understand the syntax of date functions, but to apply them to real datasets and understand how they can be used in **data analysis, reporting, filtering, trend analysis, SLA calculations, and dashboard development**.

The practice was performed using **Azure SQL Database** and **SSMS**, with E-Commerce and Superstore datasets.

---

## 🎯 Learning Objectives

Through this practice, I worked on:

* Extracting individual components from dates
* Working with current date and time
* Extracting readable and numeric date parts
* Adding and subtracting time intervals
* Finding month boundaries
* Calculating differences between dates
* Building dynamic Year-to-Date (YTD) filters
* Applying nested date functions to real-world queries

---

## 🛠️ Environment & Tools

| Tool                                    | Purpose                                       |
| --------------------------------------- | --------------------------------------------- |
| ☁️ Azure SQL Database                   | Cloud-based SQL environment                   |
| 🖥️ SQL Server Management Studio (SSMS) | Query execution and database management       |
| 🗃️ E-Commerce Dataset                  | Customer orders, shipping and regional sales  |
| 📊 Superstore Dataset                   | Product sales, profit and order-date analysis |

The `ORDERS` table was used as the primary table for practicing the date functions.

---

# 📚 Date Functions Practiced

## 1️⃣ Current Date & Time Functions

### `CURRENT_TIMESTAMP`

Returns the current date and time.

```sql
SELECT CURRENT_TIMESTAMP AS CURRENT_TIMESTAMP_;
```

### `GETDATE()`

Returns the current local server date and time.

```sql
SELECT GETDATE() AS DATE_;
```

### `GETUTCDATE()`

Returns the current UTC date and time.

```sql
SELECT GETUTCDATE() AS UTC;
```

### `SYSDATETIME()`

Returns the current server date and time with higher fractional-second precision than `GETDATE()`.

```sql
SELECT SYSDATETIME() AS SERVER_TIME;
```

The practice also covered converting the server timestamp to **IST (+05:30)** using `SWITCHOFFSET()`.

---

## 2️⃣ Extracting Date Parts

### `YEAR()`

Extracts the year from a date.

```sql
SELECT
    [ORDER DATE],
    YEAR([ORDER DATE]) AS YEAR_
FROM ORDERS;
```

### `MONTH()`

Extracts the month number.

```sql
SELECT
    [ORDER DATE],
    MONTH([ORDER DATE]) AS MONTH_
FROM ORDERS;
```

### `DAY()`

Extracts the day of the month.

```sql
SELECT
    DAY([ORDER DATE]) AS DAY_
FROM ORDERS;
```

These functions are useful for **yearly analysis, monthly trends, filtering, and date-based reporting**.

---

## 3️⃣ Reading Date Parts

### `DATENAME()`

Returns a date part as a **readable string**.

```sql
SELECT
    [ORDER DATE],
    DATENAME(WEEKDAY, [ORDER DATE]) AS WEEKDAY_
FROM ORDERS;
```

Example use:

* Monday
* Tuesday
* Wednesday

### `DATEPART()`

Returns a date part as an **integer**.

```sql
SELECT
    [ORDER DATE],
    DATEPART(WEEKDAY, [ORDER DATE]) AS WEEKDAY_
FROM ORDERS;
```

### 🔍 DATENAME vs DATEPART

| Function     | Output  | Example Use                        |
| ------------ | ------- | ---------------------------------- |
| `DATENAME()` | String  | Report labels / dashboards         |
| `DATEPART()` | Integer | Filtering / sorting / calculations |

Both functions support date parts such as `YEAR`, `MONTH`, `DAY`, `WEEKDAY`, and `QUARTER`.

---

## 4️⃣ Shifting Dates with `DATEADD()`

`DATEADD()` adds or subtracts a specified interval from a date.

### Syntax

```sql
DATEADD(datepart, number, date)
```

### Previous Year

```sql
SELECT
    [ORDER DATE],
    DATEADD(YEAR, -1, [ORDER DATE]) AS PREVIOUS_YEAR
FROM ORDERS;
```

### Next Year

```sql
SELECT
    [ORDER DATE],
    DATEADD(YEAR, 1, [ORDER DATE]) AS NEXT_YEAR
FROM ORDERS;
```

### Previous Month

```sql
SELECT
    [ORDER DATE],
    DATEADD(MONTH, -1, [ORDER DATE]) AS PREVIOUS_MONTH
FROM ORDERS;
```

### 💡 Real-world applications

* Previous vs. next period comparisons
* Rolling time windows
* Due-date calculations
* SLA deadlines

---

# 🗓️ 5️⃣ Month Boundaries

## `DATEFROMPARTS()`

Creates a date from individual year, month, and day values.

The practice used it to calculate the **start of the month**:

```sql
SELECT
    DATEFROMPARTS(
        YEAR([ORDER DATE]),
        MONTH([ORDER DATE]),
        1
    ) AS START_OF_MONTH
FROM ORDERS;
```

## `EOMONTH()`

Returns the last calendar day of the month.

```sql
SELECT
    EOMONTH([ORDER DATE]) AS END_OF_MONTH_DATE
FROM ORDERS;
```

It can also shift to another month's end:

```sql
EOMONTH([ORDER DATE], 1)
```

### 📌 Practical Applications

* Monthly reporting
* Month-end processing
* Financial closing
* Period-based analysis
* Calendar-based data pipelines

---

# ⏱️ 6️⃣ Measuring Date Differences with `DATEDIFF()`

`DATEDIFF()` calculates the difference between two dates based on a selected date part.

### Syntax

```sql
DATEDIFF(datepart, startdate, enddate)
```

### Example — Year Difference

```sql
SELECT
    [ORDER DATE],
    DATEDIFF(YEAR, [ORDER DATE], GETDATE()) AS YEAR_DIFF
FROM ORDERS;
```

### Example — Month Difference

```sql
SELECT
    [ORDER DATE],
    DATEDIFF(MONTH, [ORDER DATE], GETDATE()) AS MONTH_DIFF
FROM ORDERS;
```

### 💡 Real-world applications

* Order age
* Fulfillment time
* SLA tracking
* Turnaround time
* Customer tenure
* Cohort analysis

> **Important:** `DATEDIFF()` counts date-part boundary crossings rather than complete elapsed periods.

---

# 📈 7️⃣ Real-World Application — YTD Filtering

One of the key exercises was creating a **dynamic Year-to-Date (YTD) filter**.

The query combined multiple functions:

* `DATEADD()`
* `GETDATE()`
* `YEAR()`
* `CONCAT()`

```sql
SELECT
    [ORDER DATE],
    SALES
FROM ORDERS
WHERE [ORDER DATE] >=
      DATEADD(
          YEAR,
          -4,
          CONCAT(YEAR(GETDATE()), '-', '01-01')
      )
  AND [ORDER DATE] <=
      DATEADD(YEAR, -4, GETDATE())
ORDER BY [ORDER DATE] ASC;
```

Because the Superstore dataset contains historical dates, the query shifts the current date back by four years so that the dynamic YTD window aligns with the available data.

### 🚀 Why This Matters

This exercise demonstrated how multiple SQL functions can be combined to create **dynamic date boundaries without hardcoding dates**.

This pattern can be useful for:

* 📊 YTD dashboards
* 📈 Sales reporting
* 🔄 Dynamic reporting periods
* 📅 Time-based filtering
* ☁️ Data engineering pipelines

---

# 🧠 Key Takeaways

### Date & Time

`CURRENT_TIMESTAMP` → `GETDATE()` → `GETUTCDATE()` → `SYSDATETIME()`

### Date Parts

`YEAR()` → `MONTH()` → `DAY()`

### Read Date Parts

`DATENAME()` → Readable string
`DATEPART()` → Integer

### Shift Dates

`DATEADD()`

### Month Boundaries

`DATEFROMPARTS()` → Start of month
`EOMONTH()` → End of month

### Measure Gaps

`DATEDIFF()`

### Real-World Application

**Dynamic YTD filtering**

This complete toolkit was practiced against live data in Azure SQL Database.

---

# 📂 Repository Structure

```text
SQL-Date-Functions/
│
├── README.md
│
├── Date Functions.pdf
│
└── Date_Functions.sql

```

> If you have a separate `.sql` file containing the queries, place it inside the `SQL Queries` folder.

---

# 🎯 What I Practiced

* ✅ `CURRENT_TIMESTAMP`
* ✅ `GETDATE()`
* ✅ `GETUTCDATE()`
* ✅ `SYSDATETIME()`
* ✅ `YEAR()`
* ✅ `MONTH()`
* ✅ `DAY()`
* ✅ `DATENAME()`
* ✅ `DATEPART()`
* ✅ `DATEADD()`
* ✅ `DATEFROMPARTS()`
* ✅ `EOMONTH()`
* ✅ `DATEDIFF()`
* ✅ Dynamic YTD filtering
* ✅ Azure SQL Database + SSMS workflow
* ✅ Hands-on practice with E-Commerce & Superstore datasets

---

# 🚀 Learning Progress

This practice strengthened my understanding of how SQL date functions move beyond simple syntax and become building blocks for **analytics, reporting, and real-world data engineering workflows**.

> **Learning SQL one query at a time. Building data engineering skills one concept at a time.** ☁️📊

---

## 🔗 Topics Covered

`SQL` • `T-SQL` • `Azure SQL Database` • `SSMS` • `Date Functions` • `Date & Time` • `YTD Analysis` • `Data Engineering` • `Data Analytics`

⭐ If this repository helps you with SQL revision, feel free to star it!

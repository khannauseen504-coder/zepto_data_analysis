# 🛒 Zepto Quick Commerce — SQL Data Analysis Project


> A comprehensive SQL-based analysis of Zepto's product catalogue — covering data cleaning, pricing intelligence, discount analysis, inventory optimisation, and revenue estimation.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Dataset Description](#-dataset-description)
- [Database Schema](#-database-schema)
- [Project Workflow](#-project-workflow)
- [Analysis Modules](#-analysis-modules)
- [Key Insights](#-key-insights)
- [SQL Queries Summary](#-sql-queries-summary)
- [How to Run](#-how-to-run)
- [Skills Demonstrated](#-skills-demonstrated)
- [Report](#-report)
- [Author](#-author)

---

## 📖 Project Overview

**Zepto** is one of India's fastest-growing quick-commerce platforms, promising grocery and household item delivery in under 10 minutes. This project analyses Zepto's product catalogue data using **SQL (PostgreSQL/MySQL)** to extract actionable business intelligence across pricing, discounts, inventory, and revenue.

The project simulates the end-to-end workflow of a real-world data analyst:
- Schema design and data loading
- Data quality checks and cleaning
- Exploratory data analysis (EDA)
- Business-focused query development
- Insight generation and recommendations

---

## 📦 Dataset Description

| Field | Description |
|---|---|
| `sku_id` | Unique product identifier (Primary Key) |
| `category` | Product category (e.g., Snacks, Dairy, Beverages) |
| `name` | Product name |
| `mrp` | Maximum Retail Price (₹) |
| `discountPercent` | Discount offered (%) |
| `availableQuantity` | Units currently in stock |
| `discountedSellingPrice` | Final price after discount (₹) |
| `weightInGms` | Product weight in grams |
| `outOfStock` | Boolean — TRUE if out of stock |
| `quantity` | Pack quantity |

**Dataset size:** 3,000+ SKU records across multiple product categories.

> ⚠️ **Note:** Raw data had prices stored in **paise** (1 INR = 100 paise). Data cleaning converts all price fields to INR.

---

## 🗄️ Database Schema

```sql
CREATE DATABASE zepto;

CREATE TABLE zepto (
    sku_id                 SERIAL PRIMARY KEY,
    category               VARCHAR(150),
    name                   VARCHAR(150) NOT NULL,
    mrp                    NUMERIC(8,2),
    discountPercent        NUMERIC(5,2),
    availableQuantity      INT,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms            INT,
    outOfStock             BOOLEAN,
    quantity               INT
);
```

---

## 🔄 Project Workflow

```
Raw Data
   │
   ▼
Schema Design (DDL)
   │
   ▼
Data Loading
   │
   ▼
Data Exploration  ──► Row counts, category counts, NULL checks, duplicates
   │
   ▼
Data Cleaning  ──► Remove zero-price rows, convert paise → INR
   │
   ▼
Business Analysis  ──► Pricing, Discounts, Inventory, Revenue, Segmentation
   │
   ▼
Insights & Recommendations
```

---

## 📊 Analysis Modules

### 1. 🔍 Data Exploration
- Total row count and distinct category count
- NULL value detection across all columns
- Products appearing more than once (variant/duplicate check)
- Stock status distribution (in-stock vs out-of-stock)

### 2. 🧹 Data Cleaning
- Deleted records where `mrp = 0` (invalid entries)
- Converted `mrp` and `discountedSellingPrice` from paise to INR
- Verified data integrity post-cleaning

### 3. 💰 Pricing & Discount Analysis
- Top 10 products by highest discount percentage
- Products with MRP > ₹500 but discount < 10% (full-margin premium items)
- Top 5 categories by average discount offered

### 4. 📦 Inventory & Revenue Analysis
- Estimated revenue per category (`discountedSellingPrice × availableQuantity`)
- High-value out-of-stock products (MRP > ₹300) — revenue leakage
- Total inventory weight per category (warehouse load analysis)

### 5. ⚖️ Value & Weight Analytics
- Price per gram for products ≥ 100g (unit value benchmarking)
- Weight-based segmentation: **Low** (<1kg) / **Medium** (1–5kg) / **Bulk** (>5kg)

---

## 💡 Key Insights

| # | Insight | Action |
|---|---|---|
| 1 | Premium products (MRP >₹300) are frequently out of stock | Prioritise restocking high-value SKUs |
| 2 | Some products have >50% discount — possible pricing errors or clearance | Implement quarterly discount audit |
| 3 | Category revenue is concentrated in a few segments | Build inventory buffers for top revenue categories |
| 4 | Bulk items (>5kg) consume disproportionate dark store space | Reduce low-revenue bulk SKUs, favour medium-weight |
| 5 | Price/gram varies widely within the same category | Use as a procurement negotiation benchmark |

---

## 🗒️ SQL Queries Summary

| # | Query Purpose | Key SQL Concepts |
|---|---|---|
| 1 | Total row count | `COUNT(*)` |
| 2 | Distinct category count | `COUNT(DISTINCT)` |
| 3 | NULL value check | `IS NULL`, `OR` |
| 4 | Duplicate product names | `GROUP BY`, `HAVING` |
| 5 | Stock status split | `GROUP BY outOfStock` |
| 6 | Remove zero-price records | `DELETE WHERE` |
| 7 | Currency normalisation | `UPDATE SET` |
| 8 | Top 10 discounted products | `ORDER BY DESC`, `LIMIT` |
| 9 | High MRP, low discount filter | `WHERE`, `AND` |
| 10 | Category average discount | `AVG`, `ROUND`, `GROUP BY` |
| 11 | Estimated revenue by category | `SUM`, `GROUP BY` |
| 12 | Out-of-stock premium products | `WHERE`, `ORDER BY` |
| 13 | Price per gram | `ROUND`, arithmetic division |
| 14 | Weight segmentation | `CASE WHEN` |
| 15 | Total inventory weight | `SUM`, `GROUP BY` |

---

## ▶️ How to Run

### Prerequisites
- PostgreSQL or MySQL installed
- A SQL client (pgAdmin, DBeaver, MySQL Workbench, or terminal)

### Steps

```bash
# 1. Clone this repository
git clone https://github.com/your-username/zepto-sql-analysis.git
cd zepto-sql-analysis

# 2. Open your SQL client and connect to your database server

# 3. Create the database and table
psql -U postgres -f schema.sql

# 4. Load the dataset
psql -U postgres -d zepto -f data.sql

# 5. Run the analysis queries
psql -U postgres -d zepto -f analysis.sql
```

### File Structure

```
zepto-sql-analysis/
│
├── README.md                        # This file
├── schema.sql                       # CREATE DATABASE + TABLE statements
├── data.sql                         # Dataset insert statements
├── analysis.sql                     # All analysis queries
├── data_cleaning.sql                # Cleaning queries (separate)
└── Zepto_SQL_Analysis_Report.docx   # Full project report
```

---

## 🛠️ Skills Demonstrated

**SQL / Database**
- DDL: `CREATE`, `ALTER`, `DROP`, `TRUNCATE`
- DML: `SELECT`, `INSERT`, `UPDATE`, `DELETE`
- Aggregation: `COUNT`, `SUM`, `AVG`, `ROUND`
- Filtering: `WHERE`, `HAVING`, `BETWEEN`, `AND/OR`
- Grouping & Sorting: `GROUP BY`, `ORDER BY`, `LIMIT`
- Conditional Logic: `CASE WHEN THEN ELSE END`
- Data Types: `SERIAL`, `VARCHAR`, `NUMERIC`, `INT`, `BOOLEAN`

**Data Analysis**
- Exploratory Data Analysis (EDA)
- Data Cleaning & Validation
- Revenue & Inventory Estimation
- Discount & Pricing Strategy Analysis
- Product Segmentation
- Business Insight Generation

---

## 📄 Report

A full professional report (`Zepto_SQL_Analysis_Report.docx`) is included in this repository. It covers:
- Project overview and schema design
- All cleaning steps with rationale
- Query-by-query analysis with insights
- Business recommendations
- ATS-friendly resume project description

---

## 👤 Author

**Your Name**
- 📧 your.email@example.com
- 💼 [LinkedIn](https://linkedin.com/in/your-profile)
- 🐙 [GitHub](https://github.com/your-username)

---

## ⭐ If you found this project helpful, give it a star!

> *"Data is the new oil — SQL is the refinery."*

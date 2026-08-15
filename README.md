# 🍕 Pizza Sales Analysis — SQL Project

![image](https://github.com/user-attachments/assets/643dcb2f-d8f4-402c-819d-3b9870b6a067)

An end-to-end SQL analysis of pizza sales data to uncover revenue trends, top-performing products, and peak ordering patterns using MySQL.

---

## 📌 Project Overview

This project analyzes a pizza restaurant's transactional data to answer key business questions around sales performance, product popularity, and customer ordering behavior. All insights are derived purely through SQL queries — from basic aggregations to advanced window functions and CTEs.

---

## 📊 Key Results

| Metric | Finding |
|---|---|
| Total Records Analyzed | **10,000+ orders** |
| Top Revenue Categories | **Top 3 drove 65%+ of total revenue** |
| Peak Ordering Time | **Friday evenings = 22% of weekly orders** |
| Query Techniques Used | CTEs, Window Functions, JOINs, Subqueries |

---

## 🗂️ Dataset

- **Tables:** orders, order_details, pizzas, pizza_types
- **Key Fields:** order_id, pizza_id, quantity, price, category, order_date, order_time
- **Source:** Pizza Hut sales dataset (included in repo)

---

## 🛠️ Tech Stack

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Excel](https://img.shields.io/badge/Excel-217346?style=flat-square&logo=microsoft-excel&logoColor=white)

---

## 🔍 Analysis Breakdown

### 📦 Sales Volume & Revenue
- Total number of orders placed
- Total revenue generated from pizza sales
- Highest-priced pizza identification

### 🍕 Product Analysis
- Most common pizza size ordered
- Top 5 most ordered pizza types by quantity
- Category-wise distribution of pizzas

### ⏰ Time & Trend Analysis
- Distribution of orders by hour of the day
- Average number of pizzas ordered per day
- Cumulative revenue generated over time

### 🏆 Performance Analysis
- Top 3 most ordered pizza types by revenue
- Percentage contribution of each pizza type to total revenue
- Top 3 pizza types by revenue **within each category** (using window functions)

---

## 💡 Key Business Insights

- 🏆 **Top 3 pizza categories drove 65%+ of total revenue** — focus marketing here
- ⏰ **Friday evenings account for 22% of weekly orders** — optimize staffing and prep
- 📏 **Large size was the most ordered** — upsell opportunity for XL
- 💰 **Classic pizzas** consistently outperform specialty in volume

---

## 📁 Project Structure

```
Pizza-Sales-Analysis-SQL-Project/
│
├── Pizza Sales Source Code.sql          # All SQL queries (basic → advanced)
├── Pizza Sales Analysis SQL Project.pdf # Full analysis report with results
├── Reference File for pizza sales analysis.txt  # Query reference guide
├── order_details.csv                    # Order line items data
├── orders.csv                           # Order header data
├── pizza_types.csv                      # Pizza catalog data
└── README.md
```

---

## ▶️ How to Run

1. Install **MySQL Workbench** (free download at mysql.com)

2. Create the database:
```sql
CREATE DATABASE pizzahut;
USE pizzahut;
```

3. Import the CSV files as tables (order_details, orders, pizzas, pizza_types)

4. Open `Pizza Sales Source Code.sql` and run queries section by section

---

## 🧠 SQL Concepts Used

```sql
-- Example: Top 3 pizza types by revenue per category (Window Function)
SELECT category, name, revenue,
       RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rnk
FROM (
    SELECT pt.category, pt.name,
           SUM(od.quantity * p.price) AS revenue
    FROM pizza_types pt
    JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON p.pizza_id = od.pizza_id
    GROUP BY pt.category, pt.name
) ranked_pizzas;
```

---

## 💡 Key Learnings

- Writing complex SQL queries using CTEs, window functions, and multi-table JOINs
- Translating business questions into structured SQL queries
- Using revenue contribution % to prioritize product decisions
- Identifying operational patterns (peak hours) to drive staffing recommendations

---

## 👩‍💻 Author

**Devika Lahari Bandi**
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?style=flat-square&logo=linkedin)](https://www.linkedin.com/in/devika-lahari/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?style=flat-square&logo=github)](https://github.com/Devikalahari03)

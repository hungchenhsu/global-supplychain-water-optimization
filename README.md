# Global Supply Chain Water Optimization – XYZ Corporation

This project was developed as part of a **Global Supply Chain Case Competition**, where our team was tasked with minimizing water supply costs at XYZ Corporation's headquarters, Building T. By leveraging SAS Viya, we built forecasting models and an optimization algorithm to strategically allocate water usage between two sources—maximizing efficiency and cost-effectiveness under real-world constraints.

---

## 📌 Table of Contents

- [Background](#Background)
- [Technology Stack](#technology-stack)
- [Process Overview](#process-overview)
- [Repository Contents](#repository-contents)
- [Key Results](#key-results)

---

## 🏢 Background

XYZ Corporation obtains water from:
1. **The Water Co.** — a third-party supplier offering contract tiers with different prices and minimum purchase requirements.
2. **Internal Water Storage Tank** — collects precipitation and incurs treatment costs.

The objective was to **forecast future water demand** and **optimize water allocation** between these sources over a four-week period, while satisfying operational constraints.

---

## 🛠️ Technology Stack

- **SAS Viya**: Used throughout the project for data processing, modeling, and optimization.
- **Forecasting Models**: Including Stacked Model (Neural Network + Time Series), Hierarchical Forecasting, and Regression.
- **PROC OPTMODEL**: SAS procedure used to model and solve the linear optimization problem.

---

## ⚙️ Process Overview

1. **Forecasting**:
   - Built multiple time series forecasting pipelines.
   - Selected the **Stacked Model** as the best performer based on WMAPE and WRMSE.

2. **Optimization**:
   - Defined constraints for inventory levels, tank usage, and minimum contract requirements.
   - Iterated over all contract tiers to determine the lowest-cost solution.

3. **Validation**:
   - Confirmed that constraints were satisfied.
   - Verified that our solution was the most cost-effective option.

---

## 📁 Repository Contents

- `forecast_data`: Input data containing water demand, treatment costs, and precipitation by week.
- `contract_data`: Price tier structure and purchase limits from The Water Co.
- `optimization_model.sas`: Main code using PROC OPTMODEL to solve the allocation problem.
- `README.md`: Project documentation (this file).

---

## 💡 Key Results

- **Winning Tier**: **Tier09**
- **Minimized Cost**: **$29,706.84**
- **Constraints Met**:
  - Weekly demand fully satisfied
  - Ending inventory > 30,000 gallons
  - ≥ 25% of weekly usage from the Water Storage Tank
- **Cost Savings**: Up to **$21,680** compared to the highest-cost tier

---

🏆 *This solution was built and submitted for the 2025 Global Supply Chain Case Competition.*

📬 *For questions or collaboration, feel free to connect via GitHub or LinkedIn.*

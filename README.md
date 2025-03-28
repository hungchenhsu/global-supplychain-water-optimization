# Global Supply Chain Water Optimization – using SAS Viya

This project was developed as part of the **2025 Global Supply Chain Case Competition**, hosted by Purdue University’s Daniels School of Business, CSCMP Chicago Roundtable, and SAS. Our team was tasked with minimizing water supply costs at XYZ Corporation's headquarters, Building T. Using SAS Viya, we built forecasting models and an optimization algorithm to strategically allocate water usage between two sources—maximizing efficiency and cost-effectiveness under real-world constraints.

🔗 Official Website: [2025 Global Supply Chain Case Competition](https://business.purdue.edu/news/features/2025/gsc-competition.php)

---

## 📌 Table of Contents

- [Background](#-background)
- [Technology Stack](#%EF%B8%8F-technology-stack)
- [Process Overview](#%EF%B8%8F-process-overview)
- [Repository Contents](#-repository-contents)
- [Key Results](#-key-results)

---

## 🏢 Background

XYZ Corporation obtains water from:
1. **The Water Co.** — a third-party supplier offering contract tiers with different prices and minimum purchase requirements.
2. **Internal Water Storage Tank** — collects precipitation and incurs treatment costs.

The objective was to **forecast future water demand** and **optimize water allocation** between these sources over a four-week period, while satisfying operational constraints.

> ⚠️ **Note:** Due to competition rules, the raw dataset used in this project cannot be uploaded to the public repository.

---

## 🛠️ Technology Stack

- **SAS Viya**: Used throughout the project for data processing, modeling, and optimization.
- **Forecasting Models**: Including Stacked Model (Neural Network + Time Series).
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

- `forecast_data`: Input data containing water demand, treatment costs, and precipitation by week. (*Included in the code*)
- `contract_data`: Price tier structure and purchase limits from The Water Co. (*Included in the code*)
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

🏆 *This solution was built and submitted for the 2025 Global Supply Chain Case Competition.*

---

## 🖼️ Project Presentation

For a full overview of this project in presentation format, please see:  
[📃 SAS 2025 Global Supply Chain Case Competition – StArS Presentation (PDF)](/sas_case2025_StArS_presentation.pdf)

This presentation was created by **StArS**,  
a team led by **Hung-Chen Hsu**.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Citation

If you find this repository helpful in your research, teaching, or other work,  
please consider citing or linking back to the repository:

Hung-Chen Hsu. Global Supply Chain: Water Allocation Optimization for Building T using SAS Viya. GitHub, 2025.
Repository: https://github.com/hungchenhsu/global-supplychain-water-optimization

This helps acknowledge the original work and supports open sharing in the ML community 🙌

---

Created with 💻 and 🎯 by Hung-Chen Hsu

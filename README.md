# 🏗️ Concrete Compressive Strength Prediction

### Regression Analysis Project

## 📌 Overview

This project focuses on predicting the **compressive strength of concrete** using **Multiple Linear Regression**. By analyzing key ingredients of concrete such as cement, water, aggregates, and curing age, the model aims to support safer and more efficient construction practices.

---

## 🎯 Objective

* Develop a **predictive regression model** for concrete compressive strength
* Identify **significant factors** affecting strength
* Evaluate model performance and assumptions
* Improve decision-making in construction engineering

---

## 📊 Dataset Information

* **Source:** Kaggle – Concrete Compressive Strength Dataset
* **Observations:** 1030
* **Features:** 9 (8 inputs + 1 output)

### 🔢 Variables

**Independent Variables (Inputs):**

* Cement
* Blast Furnace Slag
* Fly Ash
* Water
* Superplasticizer
* Coarse Aggregate
* Fine Aggregate
* Age (days)

**Dependent Variable (Output):**

* Compressive Strength (MPa)

---

## 🧹 Data Preprocessing

The dataset was cleaned and prepared using the following steps:

* ✔️ Handling missing values
* ✔️ Removing duplicates (25 rows identified)
* ✔️ Outlier treatment using:

  * Winsorization
  * Log Transformation
  * Capping

---

## 📈 Data Visualization

* Histograms for distribution analysis
* Scatter plots to identify relationships
* Residual plots for model diagnostics

---

## 🤖 Model Development

### 🔹 Train-Test Split

* 70% Training
* 30% Testing

### 🔹 Model Used

* **Multiple Linear Regression**

### 🔹 Regression Equation

```
y = 31.923121 
  + 0.080926x1 
  + 2.050732x2 
  + 0.010824x3 
  - 0.239150x4 
  + 1.729594x5 
  - 0.001006x6 
  - 0.014195x7 
  + 8.671532x8
```

---

## 📊 Model Performance

### 🔹 R² Score

* **80.78%** of the variation explained

### 🔹 Key Insights

* Age → Most influential factor
* Cement & Slag → Strong positive impact
* Water → Negative impact
* Other variables → Minor effects

---

## 🧪 Statistical Evaluation

### ✔️ ANOVA

* All predictors are statistically significant (p < 0.05)

### ✔️ Assumption Checks

* Linearity → Slight deviations observed
* Normality → Satisfied (Shapiro-Wilk & Q-Q plot)
* Homoscedasticity → Violated (heteroscedasticity present)
* Independence → Violated (Durbin-Watson test)

---

## 🔍 Model Diagnostics

### Residual Analysis

* Identified:

  * Non-linearity
  * Heteroscedasticity
  * Correlated residuals

### Multicollinearity

* Checked using **VIF**
* All values between 1–5 → Acceptable range

---

## 🧠 Variable Selection

### Methods Used

* Stepwise Regression (Backward Selection)

### Evaluation Metrics

* AIC (Akaike Information Criterion)
* BIC (Bayesian Information Criterion)

### Outcome

* Optimal model retained key variables:

  * Cement
  * Blast Furnace Slag
  * Water
  * Superplasticizer
  * Age

---

## 📌 Results & Conclusion

* The model provides **reliable predictions** of concrete strength
* Explains ~80% of variability → Strong performance
* Identifies **critical influencing factors**
* Highlights areas for improvement:

  * Non-linear modeling
  * Handling heteroscedasticity

---

## 🚀 Future Improvements

* Apply non-linear models (e.g., polynomial regression)
* Use machine learning models (Random Forest, XGBoost)
* Improve feature engineering
* Address residual correlation

---

## 👥 Team Members

* B.M.D.C. Maluddeniya
* D. Tharushi Navoda
* O.M. Kavishan
* H.N.K. Wijethunga
* S.A.H.I. Piyathilaka
* K.K.A.S.C.W. Bandara

---

## 📚 References

* Kaggle Dataset
* YouTube Tutorials on Regression
* R Documentation (olsrr package)
* Statistical learning resources on regression assumptions

---


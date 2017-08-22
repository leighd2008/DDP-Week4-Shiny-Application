---
title       : Carbon Dioxide Uptake in Grass Plants
subtitle    : Reproducible Pitch Presentation
author      : "Diane Leigh"
job         : "Student"
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---

## Carbon Dioxide Uptake in Grass Plants - App

The Carbon Dioxide (CO2) Uptake in Grass Plants App allows the user to examine the difference in CO2 uptake between Mississippi and Quebec, as well as between chilled and non-chilled plants.

The APP can be found at https://leighd2008.shinyapps.io/DDP-Week4/.

The R code and documentation can be found at: https://github.com/leighd2008/DDP-Week4-Shiny-Application.

---

## Carbon Dioxide Uptake in Grass Plants - Data

The CO2, uptake of six plants from Quebec and six plants from Mississippi was measured at several levels of ambient CO2 concentration. Half the plants of each type were chilled overnight before the experiment was conducted.

Polynomial regression was used to fit a model for each of the four Location - Treatment conditions.

- Mississippi - Chilled
- Mississippi - Nonchilled
- Quebec - Chilled
- Quebec - Nonchilled


--- 
## Carbon Dioxide Uptake in Grass Plants - Model fit
ANOVA output for polynomial regression fit. The highest order fit showing significance for each Location - Treatment group was choosen as the model

```
## Analysis of Variance Table
## 
## Model 1: uptake ~ conc
## Model 2: uptake ~ poly(conc, 2)
## Model 3: uptake ~ poly(conc, 3)
## Model 4: uptake ~ poly(conc, 4)
## Model 5: uptake ~ poly(conc, 5)
##   Res.Df    RSS Df Sum of Sq       F    Pr(>F)    
## 1     19 835.48                                   
## 2     18 431.80  1    403.68 42.3087 9.952e-06 ***
## 3     17 172.66  1    259.14 27.1605 0.0001054 ***
## 4     16 145.88  1     26.78  2.8063 0.1146123    
## 5     15 143.12  1      2.76  0.2896 0.5983566    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

--- 
## Carbon Dioxide Uptake in Grass Plants - Prediction
The prediction tab allows provides a slider bar for the user to choose an ambient CO2 concentration and then displays the CO2 uptake for each of the four Location - Treatment groups based on their individual model fit.



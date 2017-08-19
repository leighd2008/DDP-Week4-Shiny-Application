# DDP-Week4-Shiny-Application

This REPO contains a SHINY app created for the Developing Data Products course (Week 4) which is part of the Data Science Specialization on Coursera. Instructions for this course project can be found in the Assignment Instructions file in this REPO.

The app utilizes the CO2 datasets in R. Below is the documentation for this dataset.

## Carbon Dioxide Uptake in Grass Plants

### Description

The CO2 data frame has 84 rows and 5 columns of data from an experiment on the cold tolerance of the grass species Echinochloa crus-galli.

### Usage

CO2

### Format

An object of class c("nfnGroupedData", "nfGroupedData", "groupedData", "data.frame") containing the following columns:

**Plant
an ordered factor with levels Qn1 < Qn2 < Qn3 < ... < Mc1 giving a unique identifier for each plant.

**Type
a factor with levels Quebec Mississippi giving the origin of the plant

**Treatment
a factor with levels nonchilled chilled

**conc
a numeric vector of ambient carbon dioxide concentrations (mL/L).

**uptake
a numeric vector of carbon dioxide uptake rates (umol/m^2 sec).

### Details

The CO2 uptake of six plants from Quebec and six plants from Mississippi was measured at several levels of ambient CO2 concentration. Half the plants of each type were chilled overnight before the experiment was conducted.

This dataset was originally part of package nlme, and that has methods (including for [, as.data.frame, plot and print) for its grouped-data classes.

Source

Potvin, C., Lechowicz, M. J. and Tardif, S. (1990) “The statistical analysis of ecophysiological response curves obtained from experiments involving repeated measures”, Ecology, 71, 1389–1400.

Pinheiro, J. C. and Bates, D. M. (2000) Mixed-effects Models in S and S-PLUS, Springer.
# A tutorial on using time-to-event regression to analyse material strength data in mechanical engineering  

Code repository for: A tutorial on using time-to-event regression to analyse material strength data in mechanical engineering  

MSc dissertation, Gregor McAlpine, September 2021  

This dissertation project is intended as a tutorial for mechanical engineers on conducting time-t-event regression analysis with material strength data in R. The "tensile_data.csv" file contains the data used in this tutorial which is simply a typed up version of the experimental data tables from (Naresh, Shankar, Velmurugan, 2018). 

The full .Rmd file contains the full code for the tutorial, this has been uploaded in order to allow for recreating plots and other outputs.

The R script files contain wrapper functions used in the tutorial and are free to access.

"qextr.R" is a simple function to obtain probabilities from an extreme value distribution in the same way that one would using `qnorm` or `qlogis` in R.

"gatherAFTpred.R" is a wrapper function used to create a dataframe of predicted survival function values for accelerated failure time models. A `survreg` object from the `survival` R package is used with `predict` and the resulting data frame can be passed to `ggsurvplot` from the `survminer` package to plot the predicted survival curves for each group in the data on top of the Kaplan-meier curves. A proper demonstration of the use of this function can be found in the tutorial.

"gatherCoxpred.R" works in much the same way as its AFT counterpart but estimates different quantities though `predict.coxph`. This is used to gather equivalent predictions of survival probabilities for Cox proportional hazards models and the use of the function can again be found in the tutorial.

"gofplot.R" is a wrapper function used to plot the log "survival times" against the inverse survival distributions used. the distributions are limited to "lognormal", "loglogistic" and "weibull". This serves as a simple goodness of fit plot for accelerated failure time models.

Data origin:

Naresh, K., Shankar, K. and Velmurugan, R., 2018. Reliability analysis of tensile strengths using Weibull distribution in glass/epoxy and carbon/epoxy composites. Composites Part B: Engineering, 133, pp.129-144.  

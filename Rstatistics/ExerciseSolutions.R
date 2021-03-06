#' ---
#' jupyter:
#'   jupytext_format_version: '1.0'
#'   jupytext_formats: ipynb,Rmd:rmarkdown,R:spin
#'   kernelspec:
#'     display_name: R
#'     language: R
#'     name: ir
#'   language_info:
#'     codemirror_mode: r
#'     file_extension: .r
#'     mimetype: text/x-r-source
#'     name: R
#'     pygments_lexer: r
#'     version: 3.5.1
#'   toc:
#'     base_numbering: 1
#'     nav_menu: {}
#'     number_sections: true
#'     sideBar: true
#'     skip_h1_title: true
#'     title_cell: Table of Contents
#'     title_sidebar: Contents
#'     toc_cell: false
#'     toc_position: {}
#'     toc_section_display: true
#'     toc_window_display: true
#' ---

#' R regression modeling exercises
#' ============
#'
#' Exercise 0: least squares regression
#' ------------------------------------
#'
#' Use the *states.rds* data set. Fit a model predicting energy consumed per capita (energy) from the percentage of residents living in metropolitan areas (metro). Be sure to
#'
#' 1.  Examine/plot the data before fitting the model
#' 2.  Print and interpret the model `summary`
#' 3.  `plot` the model to look for deviations from modeling assumptions
#'
#' Select one or more additional predictors to add to your model and repeat steps 1-3. Is this model significantly better than the model with *metro* as the only predictor?

#' Exercise 1: interactions and factors
#' ------------------------------------
#'
#' Use the states data set.
#'
#' 1.  Add on to the regression equation that you created in exercise 1 by generating an interaction term and testing the interaction.
#'
#' 2.  Try adding region to the model. Are there significant differences across the four regions?

#' Exercise 2: logistic regression
#' -------------------------------
#'
#' Use the NH11 data set that we loaded earlier.
#'
#' 1.  Use glm to conduct a logistic regression to predict ever worked (everwrk) using age (age<sub>p</sub>) and marital status (r<sub>maritl</sub>).
#' 2.  Predict the probability of working for each level of marital status.
#'
#' Note that the data is not perfectly clean and ready to be modeled. You will need to clean up at least some of the variables before fitting the model.

#' Exercise 3: multilevel modeling
#' -------------------------------
#'
#' Use the dataset, bh1996: src<sub>R</sub>\[\]{data(bh1996, package="multilevel")}
#'
#' From the data documentation:
#'
#' > Variables are Cohesion (COHES), Leadership Climate (LEAD), Well-Being (WBEING) and Work Hours (HRS). Each of these variables has two variants - a group mean version that replicates each group mean for every individual, and a within-group version where the group mean is subtracted from each individual response. The group mean version is designated with a G. (e.g., G.HRS), and the within-group version is designated with a W. (e.g., W.HRS).
#'
#' 1.  Create a null model predicting wellbeing ("WBEING")
#' 2.  Calculate the ICC for your null model
#' 3.  Run a second multi-level model that adds two individual-level predictors, average number of hours worked ("HRS") and leadership skills ("LEAD") to the model and interpret your output.
#' 4.  Now, add a random effect of average number of hours worked ("HRS") to the model and interpret your output. Test the significance of this random term.
#'

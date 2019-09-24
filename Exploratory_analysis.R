##############################
## Exploratory data analysis
##
## Matt Brachmann (PhDMattyB)
##
## 2019-09-20
##
##############################

# set working directory
# setwd('~/PhD/R users group/')
getwd()

# load required packages
library(tidyverse)
library(wesanderson)
library(patchwork)
library(devtools)
library(rsed)
library(data.table)

# set plotting theme
theme_set(theme_bw())


# Matt’s contribution -----------------------------------------------------

#install.packages("janitor", dependencies = TRUE)
library(janitor)
clean_names(iris, case = "screaming_snake")

#install.packages("skimr", dependencies = TRUE)
library(skimr)

data("iris") ## don't really need to load data this way

summary(iris)
summary(iris$Sepal.Length)
summary(iris$Species)

as_tibble(iris)

skim(iris) ## waaaay more information than summary

skim(iris) %>% 
  skimr::kable()  #a bit of nicer format
  # skimr::pander() will get a warning message on windows

iris %>%
  dplyr::group_by(Species) %>% 
  skim()

skim(iris) %>% 
  dplyr::filter(stat == 'mean') ## skimr masks dplyrs filter function


# Karl’s contribution -----------------------------------------------------

# link to "A protocol for data exploration to avoind common statistical problems"
# https://besjournals.onlinelibrary.wiley.com/doi/full/10.1111/j.2041-210X.2009.00001.x

# link to some ggplot versions of the Zuur approach
# https://archetypalecology.wordpress.com/2018/02/17/explanatory-data-exploration-in-r-after-zuur-et-al-2010/


# Joey’s contribution -----------------------------------------------------

## using the iris dataset, we want to explore whether the 
## different continuous variables (sepal length and width, 
## and petal length and width) are correlated with each
## other, both overall and within species

# load required package
devtools::install_github("ggobi/ggally") ## the developer version
install.packages("GGally") ## version available on CRAN
library(GGally)
## See details: https://ggobi.github.io/ggally/#ggallyggduo

# make plot
GGally::ggpairs(iris, 
               ggplot2::aes(colour = Species, 
                            alpha = 0.6), 
               lower = list(continuous = "points", 
                            combo = "dot_no_facet"), 
               title = "Correlations between flower traits", 
               xlab = "Trait X (cm)", 
               ylab = "Trait Y (cm)")

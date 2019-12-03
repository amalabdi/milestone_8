# loading libraries
library(readxl)
library(fs)
library(tidyverse)

# Copying xlsx f file into my shiny directory from my computer
# so it is accessible from everywhere for shiny

file_copy("eviction_lab_export.xlsx", "milestone_8/data.xlsx")

file_copy("counties.csv", "milestone_8/counties.csv")

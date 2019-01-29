library(shiny)
library(readr)
library(tidyr)
library(plotly)
library(leaflet)
library(maps)
library(shinyWidgets)
library(tidyverse)

data <- read_csv(file = "data/athlete_events.csv",col_types = cols(
  ID = col_character(),
  Name = col_character(),
  Sex = col_factor(levels = c("M","F")),
  Age =  col_integer(),
  Height = col_double(),
  Weight = col_double(),
  Team = col_character(),
  NOC = col_character(),
  Games = col_character(),
  Year = col_integer(),
  Season = col_factor(levels = c("Summer","Winter")),
  City = col_character(),
  Sport = col_character(),
  Event = col_character(),
  Medal = col_factor(levels = c("Gold","Silver","Bronze")))) %>%
  drop_na()

data1 <- read_csv((file = "data/noc_regions.csv"))


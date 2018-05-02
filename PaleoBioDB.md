---
title: "PaleoBioDB"
author: "Jon Tennant"
date: "2 May 2018"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Introduction

This is a markdown script for downloading and analysing fossil occurrence data from the [Paleobiology Database](https://paleobiodb.org/)


### A note on markdown format

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <https://rmarkdown.rstudio.com/authoring_basics.html>.


## Installing the palebioDB package

Rather than using the downloader within the Paleobiology Database, let's try playing with the [paleobioDB](https://github.com/ropensci/paleobioDB) package for R.

Installation is simple from CRAN:

```{r}
install.packages("paleobioDB")
library(paleobioDB)
```
## Downloading fossil occurrences

We want to download raw fossil occurrence data from the Paleobiology Database. Let's go with dinosaurs for now, as the data for them are quite complete. And because dinosaurs are awesome.

For this, we'll set no limit on the number of occurrences, and constrain occurrences to the Mesozoic period.

```{r}
data<-pbdb_occurrences(limit="all",base_name="Dinosauria",interval="Mesozoic")
write.csv(data,file="data.csv")
head(data)
```
### A cautionary note

If you use data like this without checking it beforehand, you're going to have a bad time. These data are not perfect, but a representation of the current state of the published research literature. Please make sure to critically evaluate the data before any subsequent analyses.

## Some quick plots of the data

This following code will return: 

1. A map of the species occurrences distribution; 
2. A map based on the sampling effort with the resolution based on the number of fossil occurrences per cell;
3. A map of the species-level richness distribution.

```{r}
pbdb_map(data)

pbdb_map_occur(data,res=5)

pbdb_map_richness(data, res=5, rank="species")
```

## Explore the data a bit
```{r}
# Returns a dataframe and plot with the time span of the species
pbdb_temp_range(data, rank="species")

# Returns a dataframe and plot with the species richness across time
pbdb_richness(data, rank="species", temporal_extent=c(0,10), res=1)

# Returns a dataframe and plot based on the origin and extinction (first and last occurrences)
 across time
pbdb_orig_ext(data, rank="species", orig_ext=1, temporal_extent=c(0,10), res=1)

# Returns a dataframe and plot with the number of taxa subsets
pbdb_subtaxa(data, do.plot=TRUE)         

# Returns a dataframe and plot with a summary of the temporal resolution of the occurrence records
pbdb_temporal_resolution(data)
```

### Citations
Sara Varela, Javier Gonzalez-Hernandez and Luciano Fabris Sgarbi (2016). paleobioDB: an R-package for downloading, visualizing and processing data from the Paleobiology Database. R package version 0.5. https://github.com/ropensci/paleobioDB

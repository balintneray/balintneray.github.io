---
layout: page
title: "Teaching"
date: 2014-10-21
modified: 2014-10-21
excerpt: "Teaching materials"
tags: [teaching, resources, sociology, sna]
image:
  feature: theatre.jpg
---
<section id="table-of-contents" class="toc">
  <header>
    <h3>Overview</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->


## 1. Introduction Exponential Random Graph Models (ERGM)

#### Foreword

This course introduces the basic concepts of ERGM, gives examples of why it is used, and shows how to conduct basic ERGM analyses. Although ERGM is a statistical approach that was developed to handle the inherent non-independence of network data, the possibility to include node attributes and dyadic covariates in the model makes it a very useful method for examining social systems.

While no prior experience with ERGMs will be assumed during the course, participants will be expected to understand fundamental social network concepts and terminology, and to have some knowledge of basic concepts in statistical inference.

#### Technicalities

Participants will be expected to bring their own portable laptop computer. The software package MPnet will be used extensively throughout the workshop and can be downloaded from the [MelNet Social Network Research Group website](http://www.swinburne.edu.au/fbl/research/transformative-innovation/our-research/MelNet-social-network-group/). Click on “PNet software”, download “MPNet for multilevel networks” and make sure you have a the required dependences installed within your Windows environment.

MPNet can be made to run native in Macintosh environment thanks to James Hollway who has put the standalone Windows software ‘MPNet’ into a wrapper that makes it possible to use it on Macintosh computers. In order to make it work, you can download the wrapped .app from [James' website](http://www.jameshollway.com/mpnet-for-mac/mpnet/), and also make sure to have a [Wine bottler](https://wiki.winehq.org/MacOSX) installed on your Mac.

The well-known R and RStudio will also be useful during the course and a text editor software as well as MS Excel might also come in handy. You can find help about the installation  [here](http://balintneray.github.io/install-R/).

#### Schedule

- [Day 1 / 1st lab]({{ site.url }}/teaching/introduction to ergm/) on ERGM rationale
- [Day 1 / 2nd lab]({{ site.url }}/teaching/introduction to ergm/) on Dependence assumptions and simple ERGMs
- [Day 1 / 3rd lab]({{ site.url }}/teaching/introduction to ergm/) on Some technical details about simulation and estimation of ERGMs
- [Day 1 / 4th lab]({{ site.url }}/teaching/introduction to ergm/) Empirical example
- Questions and Answers

- [Day 2 / 1st lab]({{ site.url }}/teaching/introduction to ergm/) on Goodness of fit
- [Day 2 / 2nd lab]({{ site.url }}/teaching/introduction to ergm/) on Understanding ERGM parameters
- [Day 2 / 3rd lab]({{ site.url }}/teaching/introduction to ergm/) on Estimating models with attributes and covariates
- [Day 2 / 4th lab]({{ site.url }}/teaching/introduction to ergm/) Empirical example
- Questions and Answers
- If we have time:
  - Fitting bipartite ERGMs including attributes and GoF,
  - Fitting ERGM on a organizational multilevel network,
  - Simple ERGM example using R (statnet))

## 2. Introduction to R

This course material is intended to give an introduction to R for social scientists. The basics of R, data manipulation, elemental methods and data visualization is covered. All the course material is in the scripts. So please download the lab files as well as the data sets before starting the course. You can read about installing R [here](http://balintneray.github.io/install-R/) if you need some help.

- [1st lab]({{ site.url }}/teaching/introduction to r/intro_to_R.R) on R basics: R as a calculator and different object types: vector, matrix, data frame, list and array.
- [2nd lab]({{ site.url }}/teaching/introduction to r/data_frames.R) on data handling: how to to load the data, set up local environment, browse, build and handle data. For example this data:
  - [Toy Data1]({{ site.url }}/teaching/introduction to r/exampleData.RData),
  - [Toy Data2]({{ site.url }}/teaching/introduction to r/exampleData.txt),
  - [Toy Data3]({{ site.url }}/teaching/introduction to r/test_ESS.dta)
- [3rd lab]({{ site.url }}/teaching/introduction to r/descriptives.R) on a lot of descriptive statistics, basic data visualization and bivariate relations.
- [4th lab]({{ site.url }}/teaching/introduction to r/multivariate_analysis.R) on regression analysis: simple linear, logistic models, hierarchical models and outputting the results.
  - Will use [this data]({{ site.url }}/teaching/introduction to r/resgression_data.RData) among many other.
- [5th lab]({{ site.url }}/teaching/introduction to r/functions.R) on some useful functions.

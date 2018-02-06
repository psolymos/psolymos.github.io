---
title: "PVA: Publication Viability Analysis, round 3"
layout: default
category: Etc
tags: [PVA, publications, PVAClone, intrval, R, Hungary]
published: true
disqus: petersolymos
promote: true
---

A friend and colleague of mine<!--, [P&eacute;ter Bat&aacute;ry](https://sites.google.com/site/pbatary/)-->
has circulated news from [Nature](https://www.nature.com/articles/d41586-018-01374-x)
magazine about the EU freezing innovation funds to Bulgaria.
The article had a figure about publication trends for
Bulgaria, compared with Romania and Hungary.
As I have blogged about such trends in ecology before
([here](http://okologiablog.hu/node/219) and 
[here](http://peter.solymos.org/etc/2016/08/30/my-first-blog-post-was-a-guest-post.html)), 
I felt the need to update my PVA models
with two years worth of data from [WoS](https://webofknowledge.com/).

After downloading the yearly publications numbers
using filters `ADDRESS=HUNGARY; CATEGORIES=ECOLOGY`,
I started where I left off few years ago. I fit Ricker growth model
to two time intervals of the data: 1978&ndash;1997, and 1998&ndash;2017.

The R code below uses the [**PVAClone**]( https://CRAN.R-project.org/package=PVAClone) package
that I wrote with [Khurram Nadeem](https://www.researchgate.net/profile/Khurram_Nadeem),
and is based on fitting state-space models using 
MCMC and [data cloning](http://datacloning.org/) with [JAGS](http://mcmc-jags.sourceforge.net/).
The other [**intrval**](https://CRAN.R-project.org/package=interval) package is pretty new but handy little helper
(see related posts [here](http://peter.solymos.org/tags.html#intrval))

```R
library(PVAClone)
library(intrval)

## the data from WoS
x <- structure(list(years = 1973:2017, records = c(1, 0, 4, 0, 0,
    6, 2, 5, 4, 7, 5, 7, 3, 5, 9, 11, 20, 8, 10, 15, 29, 24, 53,
    12, 13, 30, 32, 36, 45, 39, 42, 43, 50, 62, 95, 106, 113, 83,
    108, 99, 89, 117, 111, 134, 127)), .Names = c("years", "records"
    ), row.names = c(NA, 45L), class = "data.frame")

## fit the 2 models
ncl <- 10 # number of clones
m1 <- pva(x$records[x$years %[]% c(1978, 1997)], ricker("none"), ncl)
m2 <- pva(x$records[x$years %[]% c(1998, 2017)], ricker("none"), ncl)

## organize estimates
cf <- data.frame(t(sapply(list(early=m1, late=m2), coef)))
cf$K <- with(cf, -a/b)

## growth curve: early period
yr1 <- 1978:1997
pr1 <- numeric(length(yr1))
pr1[1] <- log(x$records[x$years==1978])
for (i in 2:length(pr1))
    pr1[i] <- pr1[i-1] + cf["early", "a"] + cf["early", "b"]*exp(pr1[i-1])
pr1 <- exp(pr1)

## growth curve: late period
yr2 <- 1998:2017
pr2 <- numeric(length(yr2))
pr2[1] <- log(x$records[x$years==1998])
for (i in 2:length(pr2))
    pr2[i] <- pr2[i-1] + cf["late", "a"] + cf["late", "b"]*exp(pr2[i-1])
pr2 <- exp(pr2)

## and finally the figure using base graphics
op <- par(las=2)
barplot(x$records, names.arg = x$years, space=0,
    ylab="# of publications", xlab="years",
    col=ifelse(x$years < 1998, "grey", "gold"))
lines(yr1-min(x$years)+0.5, pr1, col=4)
abline(h=cf["early", "K"], col=4, lty=3)
lines(yr2-min(x$years)+0.5, pr2, col=2)
abline(h=cf["late2017", "K"], col=2, lty=3)
par(op)
```

<img src="{{ site.baseurl }}/images/2018/02/06/pva-3.png" class="img-responsive" alt="PVA">

Here are the model parameters for the two Ricker models:

|                |  *a*|  *b*| *sigma*|     *K*|
|:---------------|----:|-----:|------:|-------:|
|1978&ndash;1997 | 0.38| -0.03|   0.60|   13.85|
|1998&ndash;2017 | 0.21|  0.00|   0.16|  119.00|

The *K* carrying capacity used to be 100 based on 
1998&ndash;2012 data, but now *K* = 119, which is
a significant improvement &mdash; heartfelt kudos to the ecologists in Hungary!
The growth rate hasn't changed (*a* = 0.21).
So we can conclude that if the rate remained constant
but carrying capacity increased, the change must be
related to resource availability
(i.e. increased funding, more jobs, improved infrastructure).

This is good news to me! Let me know what you think by leaving a comment below!

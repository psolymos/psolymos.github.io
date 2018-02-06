---
title: "The progress bar just got a lot cheaper"
layout: default
published: true
category: Code
tags: [R, pbapply, progress bar, processing time]
disqus: petersolymos
promote: true
---

The [**pbapply**](http://cran.r-project.org/package=pbapply) R package that adds progress bar to vectorized functions has been know to accumulate overhead when calling `parallel::mclapply` with forking (see [this post](http://peter.solymos.org/code/2016/09/11/what-is-the-cost-of-a-progress-bar-in-r.html) for more background on the issue). Strangely enough, a [GitHub issue](https://github.com/psolymos/pbapply/issues/30) held the key to the solution that I am going to outline below. Long story short: forking is no longer expensive with **pbapply**, and as it turns out, it never was.

The issue mentioned `parallel::makeForkCluster` as the way to set up a Fork cluster, which, according to the help page, '_is merely a stub on Windows. On Unix-alike platforms it creates the worker process by forking_'.
So I looked at some timings starting with one of the examples on the `?pbapply` help page:

``` r
library(pbapply)
set.seed(1234)
n <- 200
x <- rnorm(n)
y <- rnorm(n, crossprod(t(model.matrix(~ x)), c(0, 1)), sd = 0.5)
d <- data.frame(y, x)

mod <- lm(y ~ x, d)
ndat <- model.frame(mod)
B <- 100
bid <- sapply(1:B, function(i) sample(nrow(ndat), nrow(ndat), TRUE))
fun <- function(z) {
    if (missing(z))
        z <- sample(nrow(ndat), nrow(ndat), TRUE)
    coef(lm(mod$call$formula, data=ndat[z,]))
} 

## forking with mclapply
system.time(res1 <- pblapply(1:B, function(i) fun(bid[,i]), cl = 2L))
##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed = 01s
##   user  system elapsed 
##  0.587   0.919   0.845 

## forking with parLapply
cl <- makeForkCluster(2L)
system.time(res2 <- pblapply(1:B, function(i) fun(bid[,i]), cl = cl))
##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed = 00s
##   user  system elapsed 
##  0.058   0.009   0.215 
stopCluster(cl)

## Socket cluster (need to pass objects to workers)
cl <- makeCluster(2L)
clusterExport(cl, c("fun", "mod", "ndat", "bid"))
system.time(res3 <- pblapply(1:B, function(i) fun(bid[,i]), cl = cl))
##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed = 00s
##   user  system elapsed 
##  0.053   0.008   0.169 
stopCluster(cl)
```

Forking with `mclapply` is still pricey, but the almost equivalent `makeForkCluster` trick, that does not require objects to be passed to workers due to the shared memory nature of the process, is pretty close to the ordinary Socket cluster option.

What if I used this trick in the package? I would then create a Fork cluster 
(`cl <- makeForkCluster(cl)`), run `parLapply(cl, ...)`, and destroy the cluster with `on.exit(stopCluster(cl), add = TRUE)`. So I created a [branch](https://github.com/psolymos/pbapply/tree/fork-cluster-speedup) to do some tests:

``` r
ncl <- 2
B <- 1000
fun <- function(x) {
    Sys.sleep(0.01)
    x^2
}
library(pbmcapply)
(t1 <- system.time(pbmclapply(1:B, fun, mc.cores = ncl)))
##  |========================================================| 100%, ETA 00:00
##   user  system elapsed 
##  0.242   0.114   5.461 

library(pbapply) # 1.3-4 CRAN version
(t2 <- system.time(pblapply(1:B, fun, cl = ncl)))
##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed = 07s
##   user  system elapsed 
##  0.667   1.390   6.547 

library(pbapply) # 1.3-5 fork-cluster-speedup branch
(t3 <- system.time(pblapply(1:B, fun, cl = ncl)))
##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% elapsed = 06s
##   user  system elapsed 
##  0.225   0.100   5.710 
```

Really nice so far: **pbapply** caught up to forking based timings with **pbmcapply**. Let's see a bit more extensive runs to see how the number of progress bar updates affects the timings. If things work as I hope,
there shouldn't be an increase with the new forking idea:

``` r
timer_fun <- function(X, FUN, nout = 100, ...) {
    pbo <- pboptions(nout = nout)
    on.exit(pboptions(pbo))
    unname(system.time(pblapply(X, FUN, ...))[3])
}
timer_NULL <- list(
    nout1  = timer_fun(1:B, fun, nout = 1,       cl = NULL),
    nout10  = timer_fun(1:B, fun, nout = 10,     cl = NULL),
    nout100  = timer_fun(1:B, fun, nout = 100,   cl = NULL),
    nout1000  = timer_fun(1:B, fun, nout = 1000, cl = NULL))
unlist(timer_NULL)
##   nout1   nout10  nout100 nout1000 
##  12.221   11.899   11.775   11.260 

cl <- makeCluster(ncl)
timer_cl <- list(
    nout1  = timer_fun(1:B, fun, nout = 1,       cl = cl),
    nout10  = timer_fun(1:B, fun, nout = 10,     cl = cl),
    nout100  = timer_fun(1:B, fun, nout = 100,   cl = cl),
    nout1000  = timer_fun(1:B, fun, nout = 1000, cl = cl))
stopCluster(cl)
unlist(timer_cl)
##   nout1   nout10  nout100 nout1000 
##   6.033    6.091    6.011    6.273 


## forking with 1.3-4 CRAN version
timer_mc <- list(
    nout1  = timer_fun(1:B, fun, nout = 1,       cl = ncl),
    nout10  = timer_fun(1:B, fun, nout = 10,     cl = ncl),
    nout100  = timer_fun(1:B, fun, nout = 100,   cl = ncl),
    nout1000  = timer_fun(1:B, fun, nout = 1000, cl = ncl))
unlist(timer_mc)
##   nout1   nout10  nout100 nout1000 
##   5.563    5.659    6.620   10.692 

## forking with 1.3-5 fork-cluster-speedup branch
timer_new <- list(
    nout1  = timer_fun(1:B, fun, nout = 1,       cl = ncl),
    nout10  = timer_fun(1:B, fun, nout = 10,     cl = ncl),
    nout100  = timer_fun(1:B, fun, nout = 100,   cl = ncl),
    nout1000  = timer_fun(1:B, fun, nout = 1000, cl = ncl))
unlist(timer_new)
##   nout1   nout10  nout100 nout1000 
##   5.480    5.574    5.665    6.063 
```

The new implementation with the Fork cluster trick hands down beat the old implementation using `mclapply`. I wonder what is causing the
wildly different timings results. Is it due to all the other 
`mclapply` arguments that give control over pre-scheduling, cleanup, and RNG seeds?

The new branch can be installed as:

``` r
devtools::install_github("psolymos/pbapply", ref = "fork-cluster-speedup")
```

I am a bit reluctant of merging the new branch for the following reasons:

* `makeForkCluster` was already an option before by explicitly stating the cluster to be a Fork;
* by hiding the process of creating and destroying the cluster, user options are restricted (i.e. no control over RNGs, which can be a major drawback for simulations);
* `mclapply` wasn't so bad to begin with, because the number of updates were capped by the `nout` option.

I would recommend the following workflow that is based purely on the stable CRAN version:

``` r
cl <- makeForkCluster(2L)
output <- pblapply(..., cl = cl)
stopCluster(cl)
```

As always, <!-- check if this shows up -->I am keen on hearing what you think: either in the comments or on [GitHub](https://github.com/psolymos/pbapply/issues/31).

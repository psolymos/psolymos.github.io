---
title: "Timer progress bar added to pbapply package"
layout: default
published: true
category: Code
tags: [R, pbapply, tutorials]
disqus: petersolymos
promote: false
---

[pbapply]({{ site.baseurl }}/code.html#code-pbapply)
is a lightweight [R](http://www.r-project.org) extension package
that adds progress bar to vectorized R functions (`*apply`).
The latest addition in version 1.2-0
is the `timerProgressBar` function which adds a text based
progress bar with timer that all started with
[this pull request](https://github.com/psolymos/pbapply/pull/4).

This package is the least scientifically sophisticated piece of software
that I have worked on, but still it seems to be popular based on
reverse dependencies and download statistics.
The reason for the buzz is probably related to the packages
solving a common frustration. The frustration stems in the
fact that (1) vectorized functions do not provide any feedback
about how long the process is going to take;
and (2) there is no unified interface to progress bars.

Hadley Wickham's [plyr](https://cran.r-project.org/web/packages/plyr/index.html) package came to the rescue. But to my taste that was an overkill. And honestly,
what is the fun in using a package that someone else wrote?
So I decided to integrate the available progress bar types in a single
lightweight package, with options to manipulate the type and style.

Let us see an example from the package help pages:

```r
library(pbapply) # load package
set.seed(1234) # for reproducibility
n <- 200 # sample size
x <- rnorm(n) # predictor
y <- rnorm(n, model.matrix(~x) %*% c(0,1), sd=0.5) # observations
d <- data.frame(y, x) # data
mod <- lm(y ~ x, d) # call to lm
ndat <- model.frame(mod)
B <- 100 # number of bootstrap samples
## bootstrap IDs
bid <- sapply(1:B, function(i) sample(nrow(ndat), nrow(ndat), TRUE))
## bootstrap function
fun <- function(z) {
    if (missing(z))
        z <- sample(nrow(ndat), nrow(ndat), TRUE)
    coef(lm(mod$call$formula, data=ndat[z,]))
}
```

The `fun`ction takes a resampling vector as argument (here we use
columns from the pre-defined `bid` matrix). When the argument is missing,
it generates the vector itself. This way we can use the same
function in different vectorized functions.

First let's look at the standard `*apply` functions, printing out
system time for comparison.

```r
system.time(res1 <- lapply(1:B, function(i) fun(bid[,i])))
##   user  system elapsed
##  0.123   0.008   0.095
system.time(res2 <- sapply(1:B, function(i) fun(bid[,i])))
##   user  system elapsed
##  0.095   0.000   0.096
system.time(res3 <- apply(bid, 2, fun))
##   user  system elapsed
##  0.097   0.002   0.099
system.time(res4 <- replicate(B, fun()))
##   user  system elapsed
##  0.091   0.001   0.092
```

Here is the `pb*apply` implementation, trying different types and
styles of progress bar. Available progress bar types are timer, text,
Windows (on Windows only), TclTk, or none.

```r
## the default is the shiny new timer progress bar
op <- pboptions(type="timer")
system.time(res1pb <- pblapply(1:B, function(i) fun(bid[,i])))
##   |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% ~00s         
##   user  system elapsed
##  0.163   0.010   0.173
pboptions(op) # reset defaults

## text progress bar with percentages
pboptions(type="txt")
system.time(res2pb <- pbsapply(1:B, function(i) fun(bid[,i])))
##  |++++++++++++++++++++++++++++++++++++++++++++++++++| 100%
##   user  system elapsed
##  0.164   0.007   0.174
pboptions(op)

## alternative style with '=' as character
pboptions(type="txt", style=1, char="=")
system.time(res3pb <- pbapply(bid, 2, fun))
##==================================================
##   user  system elapsed
##  0.144   0.006   0.155
pboptions(op)

## now we use ':' isn't it nice?
pboptions(type="txt", char=":")
system.time(res4pb <- pbreplicate(B, fun()))
##  |::::::::::::::::::::::::::::::::::::::::::::::::::| 100%
##   user  system elapsed
##  0.152   0.007   0.162
pboptions(op)
```

There is clearly an overhead when comparing system times.
Which is not a surprise. More calculations take more time.
The good news is that the overhead do not increase
with the size of the problem, so it only takes an extra second or so.

Install the package from your nearest
[CRAN mirror](https://cran.r-project.org/mirrors.html)
by `install.packages("pbapply")` and
let me know any issues you might run into
on the [GitHub development site](https://github.com/psolymos/pbapply/issues).

**UPDATE**
Elapsed and remaining time is now shown with progress bar or throbber.
Currently in development version on [GitHub](https://github.com/psolymos/pbapply).

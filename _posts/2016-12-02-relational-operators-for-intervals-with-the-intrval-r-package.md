---
title: "Relational operators for intervals with the intrval R package"
layout: default
published: true
category: Code
tags: [R, functions, special, intrval]
disqus: petersolymos
promote: true
---

I recently posted a piece about [how to write and document special functions in R](http://peter.solymos.org/code/2016/11/26/how-to-write-and-document-special-functions-in-r.html). I meant that as a prelude for the topic I am writing about in this post. Let me start at the beginning. The other day Dirk Eddelbuettel tweeted about the new release of the [**data.table**](https://cran.r-project.org/package=data.table) package (v1.9.8).
There were [new features announced](https://cran.r-project.org/web/packages/data.table/news.html) for joins based on `%inrange%` and `%between%`. That got me thinking: it would be really cool to generalize this idea for different intervals, for example as `x %[]% c(a, b)`.

## Motivation

We want to evaluate if values of `x` satisfy the condition `x >= a & x <= b` given that `a <= b`. Typing `x %[]% c(a, b)` instead of the previous expression is not much shorter (14 vs. 15 characters with counting spaces). But considering the `a <= b` condition as well, it becomes a saving (`x >= min(a, b) & x <= mmax(a, b)` is 31 characters long). And sorting is really important, because by flipping `a` and `b`, we get quite different answers:

```
x <- 5
x >= 1 & x <= 10
# [1] TRUE
x >= 10 & x <= 1
# [1] FALSE
```

Also, `min` and `max` will not be very useful when we want to vectorize the expression. We need to use `pmin` and `pmax` for obvious reasons:

```
x >= min(1:10, 10:1) & x <= max(10:1, 1:10)
# [1] TRUE
x >= pmin(1:10, 10:1) & x <= pmax(10:1, 1:10)
# [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE
```

If interval endpoints can also be open or closed, and allowing them to flip around makes the semantics of left/right closed/open interval definitions hard. We can thus all agree that there is a need for an expression, like `x %[]% c(a, b)`, that is _compact_, _flexible_, and _invariant_ to endpoint sorting. This is exactly what the [**intrval**](https://github.com/psolymos/intrval) package is for!

## What's in the package

Functions for evaluating if values of vectors are within
different open/closed intervals
(`x %[]% c(a, b)`), or if two closed
intervals overlap (`c(a1, b1) %[o]% c(a2, b2)`).
Operators for negation and directional relations also implemented.

### Value-to-interval relations

Values of `x` are compared to interval endpoints `a` and `b` (`a <= b`).
Endpoints can be defined as a vector with two values (`c(a, b)`): these values will be compared as a single interval with each value in `x`.
If endpoints are stored in a matrix-like object or a list,
comparisons are made element-wise.

```
x <- rep(4, 5)
a <- 1:5
b <- 3:7
cbind(x=x, a=a, b=b)
x %[]% cbind(a, b) # matrix
x %[]% data.frame(a=a, b=b) # data.frame
x %[]% list(a, b) # list
```

If lengths do not match, shorter objects are recycled. Return values are logicals.
Note: interval endpoints are sorted internally thus ensuring the condition
`a <= b` is not necessary.

These value-to-interval operators work for numeric (integer, real) and ordered vectors, and object types which are measured at least on ordinal scale (e.g. dates).

#### Closed and open intervals

The following special operators are used to indicate closed (`[`, `]`) or open (`(`, `)`) interval endpoints:

Operator | Expression       | Condition
---------|------------------|-------------------
 `%[]%`  | `x %[]% c(a, b)` | `x >= a & x <= b`
 `%[)%`  | `x %[)% c(a, b)` | `x >= a & x < b`
 `%(]%`  | `x %(]% c(a, b)` | `x > a & x <= b`
 `%()%`  | `x %()% c(a, b)` | `x > a & x < b`

#### Negation and directional relations

Eqal     | Not equal | Less than | Greater than
---------|-----------|-----------|----------------
 `%[]%`  | `%)(%`    | `%[<]%`   | `%[>]%`
 `%[)%`  | `%)[%`    | `%[<)%`   | `%[>)%`
 `%(]%`  | `%](%`    | `%(<]%`   | `%(>]%`
 `%()%`  | `%][%`    | `%(<)%`   | `%(>)%`

The helper function `intrval_types` can be used to
print/plot the following summary:

<img src="https://github.com/psolymos/intrval/raw/master/extras/intrval.png" class="img-responsive" alt="Interval types">


### Interval-to-interval relations

The overlap of two closed intervals, [`a1`, `b1`] and [`a2`, `b2`],
is evaluated by the `%[o]%` operator (`a1 <= b1`, `a2 <= b2`).
Endpoints can be defined as a vector with two values
(`c(a1, b1)`)or can be stored in matrix-like objects or a lists
in which case comparisons are made element-wise.
Note: interval endpoints
are sorted internally thus ensuring the conditions
`a1 <= b1` and `a2 <= b2` is not necessary.

```
c(2:3) %[o]% c(0:1)
list(0:4, 1:5) %[o]% c(2:3)
cbind(0:4, 1:5) %[o]% c(2:3)
data.frame(a=0:4, b=1:5) %[o]% c(2:3)
```

If lengths do not match, shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates).

`%)o(%` is used for the negation,
directional evaluation is done via the operators `%[<o]%` and `%[o>]%`.

Eqal      | Not equal  | Less than  | Greater than
----------|------------|------------|----------------
 `%[0]%`  | `%)0(%`    | `%[<0]%`   | `%[0>]%`

### Operators for discrete variables

The previous operators will return `NA` for unordered factors.
Set overlap can be evaluated by the base `%in%` operator and its negation
`%nin%`. (This feature is really [redundant](http://peter.solymos.org/code/2016/11/26/how-to-write-and-document-special-functions-in-r.html), I know, but decided to include regardless...)

## Install

Install development version from GitHub (not yet on CRAN):

```R
library(devtools)
install_github("psolymos/intrval")
```

The package is licensed under [GPL-2](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).

## Examples

<img src="https://github.com/psolymos/intrval/raw/master/extras/examples.png" class="img-responsive" alt="Interval examples">

```
library(intrval)

## bounding box
set.seed(1)
n <- 10^4
x <- runif(n, -2, 2)
y <- runif(n, -2, 2)
d <- sqrt(x^2 + y^2)
iv1 <- x %[]% c(-0.25, 0.25) & y %[]% c(-1.5, 1.5)
iv2 <- x %[]% c(-1.5, 1.5) & y %[]% c(-0.25, 0.25)
iv3 <- d %()% c(1, 1.5)
plot(x, y, pch = 19, cex = 0.25, col = iv1 + iv2 + 1,
    main = "Intersecting bounding boxes")
plot(x, y, pch = 19, cex = 0.25, col = iv3 + 1,
     main = "Deck the halls:\ndistance range from center")

## time series filtering
x <- seq(0, 4*24*60*60, 60*60)
dt <- as.POSIXct(x, origin="2000-01-01 00:00:00")
f <- as.POSIXlt(dt)$hour %[]% c(0, 11)
plot(sin(x) ~ dt, type="l", col="grey",
    main = "Filtering date/time objects")
points(sin(x) ~ dt, pch = 19, col = f + 1)

## QCC
library(qcc)
data(pistonrings)
mu <- mean(pistonrings$diameter[pistonrings$trial])
SD <- sd(pistonrings$diameter[pistonrings$trial])
x <- pistonrings$diameter[!pistonrings$trial]
iv <- mu + 3 * c(-SD, SD)
plot(x, pch = 19, col = x %)(% iv +1, type = "b", ylim = mu + 5 * c(-SD, SD),
    main = "Shewhart quality control chart\ndiameter of piston rings")
abline(h = mu)
abline(h = iv, lty = 2)


## Annette Dobson (1990) "An Introduction to Generalized Linear Models".
## Page 9: Plant Weight Data.
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2, 10, 20, labels = c("Ctl","Trt"))
weight <- c(ctl, trt)

lm.D9 <- lm(weight ~ group)
## compare 95% confidence intervals with 0
(CI.D9 <- confint(lm.D9))
#                2.5 %    97.5 %
# (Intercept)  4.56934 5.4946602
# groupTrt    -1.02530 0.2833003
0 %[]% CI.D9
# (Intercept)    groupTrt
#       FALSE        TRUE

lm.D90 <- lm(weight ~ group - 1) # omitting intercept
## compare 95% confidence of the 2 groups to each other
(CI.D90 <- confint(lm.D90))
#            2.5 %  97.5 %
# groupCtl 4.56934 5.49466
# groupTrt 4.19834 5.12366
CI.D90[1,] %[o]% CI.D90[2,]
# 2.5 %
#  TRUE

DATE <- as.Date(c("2000-01-01","2000-02-01", "2000-03-31"))
DATE %[<]% as.Date(c("2000-01-151", "2000-03-15"))
# [1]  TRUE FALSE FALSE
DATE %[]% as.Date(c("2000-01-151", "2000-03-15"))
# [1] FALSE  TRUE FALSE
DATE %[>]% as.Date(c("2000-01-151", "2000-03-15"))
# [1] FALSE FALSE  TRUE
```

For more examples, see the [unit-testing script](https://github.com/psolymos/intrval/blob/master/tests/tests.R).

## Feedback

Please check out the package and use the [issue tracker](https://github.com/psolymos/intrval/issues)
to suggest a new feature or report a problem.

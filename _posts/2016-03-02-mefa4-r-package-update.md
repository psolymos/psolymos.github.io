---
title: "mefa4 R package update"
layout: default
published: true
category: Code
tags: [R, mefa4, tutorials]
disqus: petersolymos
promote: false
---

The [mefa4]({{ site.baseurl }}/code.html#code-mefa4)
[R](http://www.r-project.org) package is aimed at efficient manipulation
of *very big* data sets leveraging sparse matrices thanks to
the [Matrix](https://cran.r-project.org/web/packages/Matrix/index.html) package.
The recent update (version 0.3-3) of the package includes a
bugfix and few new functions
to compare sets and finding dominant features in compositional data
as described in the [ChangeLog](https://cran.r-project.org/web/packages/mefa4/ChangeLog).

The first new function is `compare_sets`. It comes really handy when
one needs to compare row names for two matrix like objects. Such as when
trying to merge two tables which come from different sources. This
facilitates checking the data and troubleshooting.
The function takes two arguments which are
then compared both in terms of `unique` values, and in terms of
levels when input is a factor (referred to as `labels`).
The function combines the functionality of
`length` (as in `length(unique(...))`), `nlevels`, `union`, `intersect`,
and `setdiff`.
In the first example let us compare two numeric vectors:

```r
compare_sets(x = 1:10, y = 8:15)
##        xlength ylength intersect union xbutnoty ybutnotx
## labels      10       8         3    15        7        5
## unique      10       8         3    15        7        5
```
Now let us have a look at two factors, one with 'zombie'/empty/unused levels.
In this case the two rows differ for obvious reasons:

```r
compare_sets(x = factor(1:10, levels=1:10), y = factor(8:15, levels=1:15))
##        xlength ylength intersect union xbutnoty ybutnotx
## labels      10      15        10    15        0        5
## unique      10       8         3    15        7        5
```

The second function is called `find_max`. No, it is not a dog locator,
and it has nothing to do with [Ruby](https://www.youtube.com/watch?v=GA4nh9_3cZM).
It takes a matrix-like object
as its argument and finds the maximum value and column ID for each row.
Such a function is handy when for example one is looking for a dominant
feature type in a matrix of compositional data. For example
the area of discrete habitats is summarized in buffers around
point locations using some GIS application.
As a result, we have a matrix where rows sum to 1
(note: this is not a criteria for the function to work):

```r
mat <- matrix(runif(10 * 5, 0, 1), 10, 5)
set.seed(1)
mat <- matrix(runif(10 * 5, 0, 1), 10, 5)
mat <- mat / rowSums(mat)
colnames(mat) <- paste0("V", 1:5)
mat
round(mat, 3)
##          V1    V2    V3    V4    V5
##  [1,] 0.098 0.076 0.345 0.178 0.303
##  [2,] 0.185 0.088 0.106 0.299 0.322
##  [3,] 0.180 0.216 0.204 0.155 0.246
##  [4,] 0.421 0.178 0.058 0.086 0.256
##  [5,] 0.078 0.297 0.103 0.319 0.204
##  [6,] 0.277 0.154 0.119 0.206 0.244
##  [7,] 0.379 0.288 0.005 0.319 0.009
##  [8,] 0.252 0.379 0.146 0.041 0.182
##  [9,] 0.189 0.114 0.261 0.217 0.220
## [10,] 0.027 0.340 0.149 0.180 0.303
```

The `find_max` function output has an index column with the
column names where values were maximum, and the value itself.
Numeric column indices can be recovered by coercing the values in the
index column to integers:

```r
(m <- find_max(mat))
##    |++++++++++++++++++++++++++++++++++++++++++++++++++| 100% ~00s         
##    index     value
## 1     V3 0.3450096
## 2     V5 0.3223295
## 3     V5 0.2455856
## 4     V1 0.4210278
## 5     V4 0.3187309
## 6     V1 0.2772785
## 7     V1 0.3788923
## 8     V2 0.3785517
## 9     V3 0.2607874
## 10    V2 0.3404492
as.integer(m$index)
##  [1] 3 5 5 1 4 1 1 2 3 2
```

You might wonder what the third function `find_min` might do.
Install the package from your nearest
[CRAN mirror](https://cran.r-project.org/mirrors.html)
by `install.packages("mefa4")` to find out!
Let me know if you find these updates and the package useful, or
have feature requests, find issues etc.
on the [GitHub development site](https://github.com/psolymos/mefa4/issues).

A next post will tell more about what that `~00s` at the end of
the progress is all about (hint: the
[pbapply](http://cran.r-project.org/package=pbapply)
package is now a dependency).

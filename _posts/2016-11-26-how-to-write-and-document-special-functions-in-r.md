---
title: "How to write and document &#37;special&#37; functions in R"
layout: default
published: true
category: Code
tags: [R, functions]
disqus: petersolymos
promote: true
---

I spend a considerable portion of my working hours with data processing where I often use the `%in%` R function as `x %in% y`. Whenever I need the negation of that, I used to write `!(x %in% y)`. Not much of a hassle, but still, wouldn't it be nicer to have `x %notin% y` instead? So I decided to code it for my [**mefa4**](https://CRAN.R-project.org/package=mefa4) package that I maintain primarily to make my data munging time shorter and more efficient. Coding a `%special%` function was no big deal. But I had to do quite a bit of research and trial-error until I figured out the proper documentation. So here it goes.

## The function

The function name needs quotes and exactly two arguments, one for the left and one for the right hand side of the operator in the middle:

```
"%notin%" <- function(x, table) !(match(x, table, nomatch = 0) > 0)
```

Let us see what it does:

```
1:4 %in% 3:5
## [1] FALSE FALSE  TRUE  TRUE
1:4 %notin% 3:5
## [1]  TRUE  TRUE FALSE FALSE
```

## The NAMESPACE entry

We need to export the function, so just add the following entry to the `NAMESPACE` file:

```
export("%notin%")
```

## The Rd file

This is where things get are a bit more interesting. The LaTeX engine needs the percent sign to be escaped (`\%`) throughout the whole documentation. Also pay close attention to the usage section (`x \%notin\% table`).

```
\name{\%notin\%}
\alias{\%notin\%}
\title{
Negated Value Matching
}
\description{
\code{\%notin\%} is the negation of \code{\link{\%in\%}},
which returns a logical vector indicating if there is a non-match or not
for its left operand.
}
\usage{
x \%notin\% table
}
\arguments{
  \item{x}{
vector or \code{NULL}: the values to be matched.
}
  \item{table}{
vector or \code{NULL}: the values to be matched against.
}
}
\value{
A logical vector, indicating if a non-match was located for each element of
\code{x}: thus the values are \code{TRUE} or \code{FALSE} and never \code{NA}.
}
\author{
Peter Solymos <solymos@ualberta.ca>
}
\seealso{
All the opposite of what is written for \code{\link{\%in\%}}.
}
\examples{
1:10 \%notin\% c(1,3,5,9)
sstr <- c("c","ab","B","bba","c",NA,"@","bla","a","Ba","\%")
sstr[sstr \%notin\% c(letters, LETTERS)]
}
\keyword{manip}
\keyword{logic}
```

**UPDATE**

Some updates from the comments:

* From Marcin: One can use [**roxygen2**](https://cran.r-project.org/package=roxygen2) for writing package documentation, see the [**magrittr**](https://cran.r-project.org/package=magrittr) package docs on the [`%>%` (pipe)](https://github.com/tidyverse/magrittr/blob/master/R/pipe.R) operator.
* From Andrey: The [**Hmisc**](https://cran.r-project.org/package=Hmisc) package also has a similar `%nin%` function (`{match(x, table, nomatch = 0) == 0}`). (Note that the unexported `Matrix:::"%nin%"` is defined as `{is.na(match(x, table))}`.)

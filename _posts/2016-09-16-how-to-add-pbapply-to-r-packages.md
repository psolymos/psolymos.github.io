---
title: "How to add pbapply to R packages"
layout: default
published: true
category: Code
tags: [R, pbapply, progress bar, R packages, dependencies]
disqus: petersolymos
promote: true
---

As of today, there are 20 R packages that reverse depend/import/suggest (3/14/3)
the [**pbapply**](http://cran.r-project.org/package=pbapply) package. Current and future package developers
who decide to incorporate the progress bar using **pbapply**
might want to customize the type and style of the progress bar
in their packages to better suit the needs of certain functions
or to create a distinctive look.
Here is a quick guide to help in setting up and customizing the progress bar.

![](https://github.com/psolymos/pbapply/raw/master/images/pbapply-01.gif)

## Adding pbapply

The **pbapply** package has no extra (non `r-base-core`) dependencies and is lightweight,
so adding it as dependency does not represent a major overhead.
There are two alternative ways of adding the **pbapply** package to another
R package: *Suggests*, or *Depends/Imports*. Here are the recommended and
tested ways of adding a progress bar to other R packages
(see the [*Writing R Extensions*](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Package-Dependencies) manual for an official guide).

### 1. Suggests: pbapply

The user decides whether to install **pbapply** and the function behavior changes accordingly. This might be preferred if there are only few functions that utilize a progress bar.

**pbapply** needs to be added to the `Suggests` field in the `DESCRIPTION` file and
use conditional statements in the code to fall back on a base functions
in case of **pbapply** is not being installed:

```
out <- if (requireNamespace("pbapply", quietly = TRUE))
   pbapply::pblapply(X, FUN, ...) else lapply(X, FUN, ...)
```

See a small R package [here](https://github.com/psolymos/pbapplySuggests)
for an example (see `R CMD check` log on Travis CI: [![Build Status](https://travis-ci.org/psolymos/pbapplySuggests.svg?branch=master)](https://travis-ci.org/psolymos/pbapplySuggests)).


### 2. Depends/Imports: pbapply

In this second case, **pbapply** needs to be installed and called explicitly
via `::` or `NAMESPACE`. This might be preferred if many functions utilize
the progress bar.

**pbapply** needs to be added to the `Depends` or `Imports` field
in the `DESCRIPTION` file.
Use **pbapply** functions either as `pbapply::pblapply()` or specify them in the `NAMESPACE` (e.g. `importFrom(pbapply, pblapply)`) and
use it as `pblapply()` (without the `::`).

See a small R package [here](https://github.com/psolymos/pbapplyDepends)
for an example (see `R CMD check` log on Travis CI: [![Build Status](https://travis-ci.org/psolymos/pbapplyDepends.svg?branch=master)](https://travis-ci.org/psolymos/pbapplyDepends)).

## Customizing the progress bar

Other than aesthetical reasons, there are cases when customizing the
progress bar is truly necessary.
For example, when working with a GUI, the default text based progress
bar might not be appropriate and developers want a Windows or Tcl/Tk
based progress bar.

In such cases, one can specify the progress bar options in the
`/R/zzz.R` file of the package. The following example
shows the default settings, but any of those list elements
can be modified (see `?pboptions` for acceptable values):

```
.onAttach <- function(libname, pkgname){
    options("pboptions" = list(
        type = if (interactive()) "timer" else "none",
        char = "-",
        txt.width = 50,
        gui.width = 300,
        style = 3,
        initial = 0,
        title = "R progress bar",
        label = "",
        nout = 100L))
    invisible(NULL)
}
```

Specifying the progress bar options this way will set the options
before **pbapply** is loaded. **pbapply** will not override these
settings. It is possible to specify a partial list of options
(from **pbapply** version 1.3-0 and above).

## Suppressing the progress bar

Suppressing the progress bar is sometimes handy.
By default, progress bar is suppressed when `!interactive()`.
This is an important feature, so that **Sweave**, **knitr**,
and R markdown documents are not polluted with a really long
printout of the progress bar.
(Although, it is possible to turn the progress bar back on within such documents.)

In an interactive session, put this inside a function to disable the
progress bar (and reset it when exiting the function):

```
pbo <- pboptions(type = "none")
on.exit(pboptions(pbo))
```

I hope that this little tutorial helps getting a progress bar where it belongs.
Suggestions and feature requests are welcome.
Leave a comment or visit the [GitHub repo](https://github.com/psolymos/pbapply/issues).

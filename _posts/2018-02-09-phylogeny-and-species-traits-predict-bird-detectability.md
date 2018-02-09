---
title: "Phylogeny and species traits predict bird detectability"
layout: default
published: true
category: Code
tags: [R, lhreg, phylogeny, detectability]
disqus: petersolymos
promote: true
---

It all started with [this](http://onlinelibrary.wiley.com/doi/10.1111/2041-210X.12106/abstract) paper in *Methods in Ecol. Evol.* where we looked at
detectability of many species. So we wanted to use life history
traits to validate our results. But we had to cut the manuscript,
and there was this leftover with some neat patterns, but without much focus.
It took a few years, and the [most positive peer-review experience ever](https://twitter.com/psolymos/status/903634823906033664),
and the paper is now early view in [*Ecography*](http://onlinelibrary.wiley.com/doi/10.1111/ecog.03415/abstract). This post is a quick summary of the goodies stuffed inside the [**lhreg**](https://github.com/borealbirds/lhreg#readme) R package that makes the whole analysis reproducible, and provides some functions for similar PGLMM models.

The R package is hosted on [GitHub](https://github.com/borealbirds/lhreg) 
(no CRAN version yet),
please submit any issues [here](https://github.com/borealbirds/lhreg/issues).
The package is also archived on Zenodo with DOI [10.5281/zenodo.596410](http://doi.org/10.5281/zenodo.596410).
To install the package, use 
`devtools::install_github("borealbirds/lhreg")`.


Here, I am going to skim the implementation based on the more
complete supporting information of the paper which has all the
reproducible code (try `vignette(topic = "lhreg", package = "lhreg")` after
installing and loading the package).
Here is the rendered [html](https://borealbirds.github.io/lhreg/) version.

The most important function is `lhreg` which takes the following main arguments:

* `Y`: response vector,
* `X`: model matrix for the mean.
* `SE`: standard error estimate (observation error) for the response,
* `V`: correlation matrix,

and fits a Multivariate Normal model to the observed `Y` vector
with phylogenetically based (or any other known) correlations 
and optionally with observation error (`SE`), and covariate effects (`X`).
The function is pretty bare-bones (i.e. no formula interface,
the design matrix `X` needs to be properly specified through
e.g. `model.matrix()`). The `lambda` argument
is a non-negative number modifying the strength of phylogenetic effects. 
`lambda = 0` is equivalent to `lm` with
`weights = 1/(SE^2)`, `lambda = 1` implies Brownian motion evolution,
`lambda = NA` lets the function estimate it based on the data.

In terms of optimization, besides the algorithms from `stats::optim`,
we also have differential evolution algorithm based on the
[**DEoptim**](https://cran.r-project.org/package=DEoptim) package (a bit time consuming but very reliable).
The output object class has some methods defined (like `logLik` and `summary`)
and as a result AIC/BIC will work out of the box.The vignette also 
describes a few techniques which are pretty nice to have in
a multivariate setting (i.e. profile likelihood, parametric bootstrap)
to support avanced hypothesis testing and model selection.

We used leave one out cross-validation to see how well we could predict the 
values based on data from the other species, traits and phylogeny.
The conditional distribution we used for that is described in the paper which
made this exercise very straightforward.
Maybe it is just ignorance, but I couldn't find another paper
that would have described it in a nice and useful manner,
however, if one wishes to make trait/phylogeny based
predictions for detectability, this formula is going to be
very useful (look inside the `loo2` function for implementation).

At the end of the vignette, there is a hack based on `phytools::contMap`
function to produce *non-rainbow* colors. 
(It was surprisingly *non-straightforward* to hack the code &mdash;
[modular code](https://en.wikipedia.org/wiki/Unix_philosophy#Doug_McIlroy_on_Unix_programming) please!) 
The following figure shows the two input data vectors mirrored side-by-side:

<img src="https://github.com/borealbirds/lhreg/raw/master/tree.png" class="img-responsive" alt="lhreg inputs">

I realize this is not a very detailed post, but the paper
and the vignette should satisfy your curiosity.
If you still have unanswered questions, feel free to ask them below!

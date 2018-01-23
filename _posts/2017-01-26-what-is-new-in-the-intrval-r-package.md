---
title: "What is new in the intrval R package?"
layout: default
published: true
category: Code
tags: [R, functions, special, intrval]
disqus: petersolymos
promote: false
---

An update (v 0.1-1) of the [**intrval**](https://github.com/psolymos/intrval) package was recently published on CRAN. The package simplifies interval related logical operations (read more about the motivation in [this](http://peter.solymos.org/code/2016/12/02/relational-operators-for-intervals-with-the-intrval-r-package.html) post).
So what is new in this version? Some of the inconsistencies in the 1st CRAN release have been cleaned up, and I have been pushed hard (see GitHub [issue](https://github.com/psolymos/intrval/issues/6) to implement all the 16 
interval-to-interval operators.
These operators define the open/closed nature of the lower/upper
limits of the intervals on the left and right hand side of the `o`
in the middle as in `c(a1, b1) %[]o[]% c(a2, b2)`.

Interval 1:  | Interval 2: `[]` |  `[)` |  `(]` |  `()`
-----------------|--------------|--------------|--------------|--------------
`[]` | `%[]o[]%`    | `%[]o[)%`    | `%[]o(]%`    | `%[]o()%`
`[)` | `%[)o[]%`    | `%[)o[)%`    | `%[)o(]%`    | `%[)o()%`
`(]` | `%(]o[]%`    | `%(]o[)%`    | `%(]o(]%`    | `%(]o()%`
`()` | `%()o[]%`    | `%()o[)%`    | `%()o(]%`    | `%()o()%`

The overlap of two closed intervals, [a1, b1] and [a2, b2],
is evaluated by the `%[]o[]%` (`%[o]%` is an alias)
operator (`a1 <= b1`, `a2 <= b2`).
Endpoints can be defined as a vector with two values
(`c(a1, b1)`) or can be stored in matrix-like objects or a lists
in which case comparisons are made element-wise.

If lengths do not match, shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates).
Note that interval endpoints
are sorted internally thus ensuring the conditions
`a1 <= b1` and `a2 <= b2` is not necessary.

```
c(2, 3) %[]o[]% c(0, 1)
list(0:4, 1:5) %[]o[]% c(2, 3)
cbind(0:4, 1:5) %[]o[]% c(2, 3)
data.frame(a=0:4, b=1:5) %[]o[]% c(2, 3)
```

If lengths do not match, shorter objects are recycled.
These value-to-interval operators work for numeric (integer, real)
and ordered vectors, and object types which are measured at
least on ordinal scale (e.g. dates).

`%)o(%` is used for the negation of two closed interval overlap (`%[o]%`),
directional evaluation is done via the operators
`%[<o]%` and `%[o>]%`.
The overlap of two open intervals
is evaluated by the `%(o)%` (alias for `%()o()%`).
`%]o[%` is used for the negation of two open interval overlap,
directional evaluation is done via the operators
`%(<o)%` and `%(o>)%`.
Overlap operators with mixed endpoint do not have
negation and directional counterparts.

Equal     | Not equal  | Less than  | Greater than
----------|------------|------------|----------------
 `%[o]%`  | `%)o(%`    | `%[<o]%`   | `%[o>]%`
 `%(o)%`  | `%]o[%`    | `%(<o)%`   | `%(o>)%`

Thanks for all the feedback so far and please keep'em coming: 
leave a comment below or use the [issue tracker](https://github.com/psolymos/intrval/issues)
to provide feedback or report a problem.


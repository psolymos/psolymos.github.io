---
title: "Testing the features"
output: html_document
layout: default
theme: flatly
navbar: inverse
excerpt: A simple template.
---

>## Table of Contents
>
>* [Always start with a header](#always-start-with-a-header)
>* [Workflow](#workflow)
>* [Showcase](#showcase)

Display math:

$$ Y_{i+1} = \lambda_{i+1} $$

`$$ Y_{i+1} = \lambda_{i+1} $$`

\\[ Y_{i+1} = \lambda_{i+1} \\]

`\\[ Y_{i+1} = \lambda_{i+1} \\]`

Inline math: $Y_{i+1} = \lambda_{i+1}$, \\( Y_{i+1} = \lambda_{i+1} \\),
`\\( Y_{i+1} = \lambda_{i+1} \\)`, $$Y_{i+1} = \lambda_{i+1}$$,
`$$Y_{i+1} = \lambda_{i+1}$$`, \\[ Y_{i+1} = \lambda_{i+1} \\].

Solution to MathJax parsing problem:

* Use `$$` for display and inline math.
* Use `$` for inline math when subscript does not need braces, because:
  $Y_i$, $Y_100$, $Y_{i,j}$, $Y_{i}$, $Y_{i+1}$, $Y_{100}$, should look like
  $$Y_i$$, $$Y_100$$, $$Y_{i,j}$$, $$Y_{i}$$, $$Y_{i+1}$$, $$Y_{100}$$.
* Use empty line above and below display math, so that display math
  is defined as newline+`$$` and `$$`+newline.
* Inline math is then defined as:
  non-whitespace+`$$` or `$$`+non-whitespace.

RStudo parsing before knitr should take care of these:

* replace triple backtick and `r` with `{r}`
* replace inline `$$` with `$`

Note: slides work OK, no need to tweak inline math

## Always start with a header

This `Rmd` file demonstrates how we intend to host text/math/code
on the website. We have 3 aims:

1. Folks can read the text/code/math on the web and
  copy/paste for themselves.
  The web design is taken care of GitHub and jekyll pages
  (including Markdown formatting, liquid templating,
  syntax highlight and MathJax notation).
2. The file opens up in [Rstudio](http://rstudio.com),
  code runs natively in R
  and can be turned into some other format (like `pdf`, `html`, slides, etc.),
  while still properly displaying text formatting, code (with
  syntax highlight), and math (using local MathJax client side rendering).
2. We can delop text/code/math without polluting our workspace
  with ugly html stuff.

## Workflow

1. Create a new `Rmd` ([R Markdown](http://rmarkdown.rstudio.com))file.
2. Use the source of this file (`test.Rmd`) as template,
  espacially as concerns the yaml header. That is the lines between
  the `---` triple dashes. It tells the website how to display
  the content, while it gives directions to the `knitr` R package
  about how to turn the code into html. For different output,
  the `output` tag value can be edited. The only important
  thing really is the `layout`.
 3. Following the syntax rules below.
 4. Save and commit to the `datacloning.github.io` project
  (or create a pull request). Make sure to push to the
  master branch. Of course, we need to figure out
  placement in the directory tree -- this is under construction.
 5. This way the source code can be edited online as well
  through GitHub. Any changes should be visible on the website
  almost instantly (might have to refresh the browser).

## Showcase

This is plain text. This is footnote<sup><a href="#footnote-1">1</a></sup> and
this is reference <a href="#Smith2000">Smith 2000</a>. References can be
treated as abbreviations, but that is not too $\LaTeX$ friendly, like
<abbr title="Smith 2000. The best paper ever. Journal, 1-2.">Smith 2000</abbr>

### Footnotes

This is [an example][^id] reference-style link.
[^id]: http://example.com/  "Optional Title Here"

This is some text[^1]. Other text[^footnote].
This is some text[^other-note]. Other text[^codeblock-note].

[^1]: Some *crazy* footnote definition.

[^footnote]:
    > Blockquotes can be in a footnote.

        as well as code blocks

    or, naturally, simple paragraphs.

[^other-note]:       no code block here (spaces are stripped away)

[^codeblock-note]:
        this is now a code block (8 spaces indentation)

### Formatting

This text is *italics* and _italics_, while this is
**bold** and __bold__.

### Mathematics

For superscript$^2$, use inline math, such as these: $A = \pi*r^{2}$
(written as `$A = \pi*r^{2}$`).

$$ a = \sqrt{b^2 + c^2} $$

Test if single dollar sign works: $a^2 = \sum{z}$.\\
Forced new line.

This [link](http://peter.solymos.org) takes you to a site.

# Header 1

## Header 2

### Header 3

#### Header 4

##### Header 5

###### Header 6

endash: --

emdash: ---

ellipsis: ...

image: ![Alt text](favicon.ico)

horizontal rule (or slide break):

***


## Lists

* unordered list
* item 2
 + sub-item 1
 + sub-item 2

1. ordered list
2. item 2
 + sub-item 1
 + sub-item 2


## Definition lists

Term 1

:   Definition 1

Term 2 with *inline markup*

:   Definition 2

        { some code, part of Definition 2 }

    Third paragraph of definition 2.



## Table formatting

| Table Header | Second Header |
| ------------ | ------------- |
| Table Cell   | Cell 2        |
| Cell 3       | Cell 4        |


Another table:

| Option |                                                               Description |
| :----: | ------------------------------------------------------------------------: |
|  data  | path to data files to supply the data that will be passed into templates. |
| engine |    engine to be used for processing templates. Handlebars is the default. |
|  ext   |                                      extension to be used for dest files. |

## Code blocks

Make a code chunk with three back ticks followed
by R (this helps figuring out highlight rules).
End the chunk with three back ticks:

```r
paste("Hello", "World!")
```

Place code inline with a single back ticks, like
this `paste("Hello", "World!")`.

### Few more code blocks

Using `nohighlight`:

```nohighlight
lapply <-
function (X, FUN, ...)
{
    FUN <- match.fun(FUN)
    if (!is.vector(X) || is.object(X))
        X <- as.list(X)
    .Internal(lapply(X, FUN))
}
a <- c(1,2,3) # x y z
b <- c(TRUE, FALSE)
## k c z
k <- c("a", "b")
```

Using blank:

```
lapply <-
function (X, FUN, ...)
{
    FUN <- match.fun(FUN)
    if (!is.vector(X) || is.object(X))
        X <- as.list(X)
    .Internal(lapply(X, FUN))
}
a <- c(1,2,3) # x y z
b <- c(TRUE, FALSE)
## k c z
k <- c("a", "b")
```

Using `r`:

```r
lapply <-
function (X, FUN, ...)
{
    FUN <- match.fun(FUN)
    if (!is.vector(X) || is.object(X))
        X <- as.list(X)
    .Internal(lapply(X, FUN))
}
a <- c(1,2,3) # x y z
b <- c(TRUE, FALSE)
## k c z
k <- c("a", "b")
```

### GFM options (that don't work, but left here for testing anyway):

superscript^2^

~~strikeout~~


* [X] done
* [ ] to do.

- [X] done
- [ ] to do.

> This is a paragraph.
>
> > A nested blockquote.
>
> ## Headers work
>
> * lists too
>
> and all other block-level elements


$$
\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}
$$

This is a ***text with light and strong emphasis***.
This **is _emphasized_ as well**.
This *does _not_ work*.
This **does __not__ work either**.

This is a R code fragment `x = 1 + c(a, 2)`{:.language-R}

This *is*{:.underline} some `code`{:#id}{:.class}.
A [link](test.html){:rel='something'} and some **tools**{:.tools}.


## Bootstrap tags

These tags can be used to track changes in code:

* <del>This line of text is meant to be treated as deleted text.</del>
* <s>This line of text is meant to be treated as no longer accurate.</s>
* <ins>This line of text is meant to be treated as an addition to the document.</ins>
* <u>This line of text will render as underlined</u>


Other cool features

* <abbr title="attribute">attr</abbr>
* <p class="text-lowercase">Lowercased text.</p>
* <p class="text-uppercase">Uppercased text.</p>
* <p class="text-capitalize">Capitalized text.</p>
* <var>y</var> = <var>m</var><var>x</var> + <var>b</var>

These backgrounds can be used to highlight topics

<p class="bg-primary">&nbsp;<i class="fa fa-pencil"></i> primary</p>

<p class="bg-primary">&nbsp;<i class="fa fa-pencil"></i> primary</p>
<p class="bg-success">&nbsp;<i class="fa fa-check-square-o"></i> success</p>
<p class="bg-info">&nbsp;<i class="fa fa-info-circle"></i> info</p>
<p class="bg-warning">&nbsp;<i class="fa fa-warning"></i> warning</p>
<p class="bg-danger">&nbsp;<i class="fa fa-bolt"></i> danger</p>

#### Emphasis classes

<p class="text-muted">Fusce dapibus, tellus ac cursus commodo, tortor mauris nibh.</p>
<p class="text-primary">Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
<p class="text-warning">Etiam porta sem malesuada magna mollis euismod.</p>
<p class="text-danger">Donec ullamcorper nulla non metus auctor fringilla.</p>
<p class="text-success">Duis mollis, est non commodo luctus, nisi erat porttitor ligula.</p>
<p class="text-info">Maecenas sed diam eget risus varius blandit sit amet non magna.</p>

> ### Use headings in quote block?
>
> Why not!
>
> That is the whole point!

Also:

> #### &nbsp;<i class="fa fa-warning"></i> Warning
>
> This is a warning.


## References

<a id="Smith2000"></a>Smith 2000. The best paper ever. *Journal*, 1-2.

<a id="footnote-1">1.</a> Footnote 1.

Kramdown syntax guide: http://kramdown.gettalong.org/syntax.html

## Bootswatch

<ul class="pager">
  <li><a href="#">Previous</a></li>
  <li><a href="#">Next</a></li>
</ul>

<ul class="pagination">
  <li class="disabled"><a href="#"><i class="fa fa-backward"></i></a></li>
  <li class="active"><a href="#">1</a></li>
  <li><a href="#">2</a></li>
  <li><a href="#">3</a></li>
  <li><a href="#">4</a></li>
  <li><a href="#">5</a></li>
  <li><a href="#"><i class="fa fa-forward"></i></a></li>
</ul>

<div class="alert alert-dismissible alert-warning">
<button type="button" class="close" data-dismiss="alert"><i class="fa fa-close"></i></button>
#### Warning!

Best check yo self, you're not looking too good. Nulla vitae elit libero, a pharetra augue.
</div>

<div class="jumbotron">
# Jumbotron

This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.
<p><a class="btn btn-primary btn-lg">Learn more</a></p>
</div>

<div class="panel panel-success">
<div class="panel-heading">
<i class="fa fa-check-square-o"></i> Panel primary
</div>
<div class="panel-body">
Panel content
<pre><code class="language-R">paste("Hello", "World!")
</code></pre>
</div>
</div>

<div class="panel panel-success">
<div class="panel-heading">
<i class="fa fa-check-square-o"></i> Panel primary
</div>
<div class="panel-body">
Panel content
<pre><code class="language-R">paste("Hello", "World!")
</code></pre>
</div>
</div>

<div class="well">
  Look, I'm in a well!
</div>


```r
## defining a website compatible palette
dcpal_flatly <- list(
    "red"="#c7254e",
    "palered"="#f9f2f4",
    "primary"="#2c3e50",
    "success"="#18bc9c",
    "info"="#3498db",
    "warning"="#f39c12",
    "danger"="#e74c3c",
    "pre_col"="#7b8a8b",
    "pre_bg"="#ecf0f1",
    "pre_border"= "#cccccc"
)
dcpal_reds <- colorRampPalette(c("#f9f2f4", "#c7254e"))
dcpal_ogrd <- colorRampPalette(c("#f39c12", "#e74c3c"))
dcpal_grbu <- colorRampPalette(c("#18bc9c",
    "#3498db", "#2c3e50"))

op <- par(las=2, mar=c(6,5,2,2), mfrow=c(2,2))
barplot(1:length(dcpal_flatly),
    names=names(dcpal_flatly),
    border=dcpal_flatly$pre_border,
    col=unlist(dcpal_flatly))
barplot(1:10, col=dcpal_reds(10), main="Reds")
barplot(1:10, col=dcpal_grbu(10), main="Green-Blue")
barplot(1:10, col=dcpal_ogrd(10), main="Orange-Red")
par(op)
```
![]({{ site.url }}/images/480x.png)

> ## Learning Objectives
>
> * Learning objective 1
> * Learning objective 2
{: .objectives}


```r
a <- list("a", 1, FALSE, function(x) x+1) # no
## yes
```

```{r}
a <- list("a", 1, FALSE, function(x) x+1) # no
## yes
```

### How to edit a blog post:

**Updated:** *This is new stuff.*

~~Previous stuff~~ *(Edit: as XY pointed out in the comments the previous stuff was incorrect)*

### This is iframe

<iframe src="http://206.167.180.241:3838/qcc/" frameborder="0" height="400" width="100%"></iframe>

### This is modal

<p><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-MCMT">Mean cold month (January) temperature</button></p>

<div class="modal fade" id="modal-MCMT" tabindex="-1" role="dialog" aria-labelledby="modal-MCMT-label">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="modal-lichens-label">Climate map: Mean cold month (January) temperature</h4>
      </div>
      <div class="modal-body">
        <img src="http://species.abmi.ca/contents/2016/geospatial/climate/MCMT.png" class="img-responsive" alt="Climate map: Mean cold month (January) temperature" />
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <a class="btn btn-primary" href="http://ftp.public.abmi.ca/species.abmi.ca/geospatial/climate/climate_grid.zip">Download <i class="fa fa-download"></i></a>
      </div>
    </div>
  </div>
</div>


<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Large Modal</button>

<!-- Modal -->
<div class="modal fade" id="myModal" role="dialog">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Modal Header</h4>
      </div>
      <div class="modal-body">
        <p>This is a large modal.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-app">Try app</button>

<div class="modal fade" id="modal-app" tabindex="-1" role="dialog" aria-labelledby="modal-app-label">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">QCC App</h4>
      </div>
      <div class="modal-body">
        <p>Text</p>
        <iframe src="http://206.167.180.241:3838/qcc/" height='80%' width='80%' frameborder='0'></iframe>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <a class="btn btn-primary" href="http://206.167.180.241:3838/qcc/" target="_blank">Open in new window <i class="fa fa-external-link" aria-hidden="true"></i></a>
      </div>
    </div>
  </div>
</div>

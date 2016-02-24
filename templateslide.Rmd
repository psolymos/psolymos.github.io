---
title: Slide template
layout: slide
---
<textarea id="source">
name: inverse
layout: true
class: center, middle, inverse
---
template: inverse

## How does it work, then?
---
layout: false
# 1st slide

> Blockquote
> works nicely.

---

# Agenda

1. Introduction

--
2. Deep-dive
3. ...

---
![](favicon.ico)

---
.left-column[
  ## What is it?
  ## Why use it?
  ## When???
]
.right-column[
If your ideal slideshow creation workflow contains any of the following steps:

- Just write what's on your mind

- Do some basic styling

- Easily collaborate with others

- Share with and show to everyone

Then remark might be perfect for your next.red[*] slideshow!

.footnote[.red[*] You probably want to convert existing slideshows as well]
]
---
.left-2column[
  ## Left

```r
a <- 10

*c <- c(5, 6)
```
]
--
.right-2column[
  ## Right

```r
a <- 10
*b = a
c <- c(5, 6)
```
]

---
## This is full width title

.left-2column[

```r
a <- 10

*c <- c(5, 6)
```
]
--
.right-2column[

```r
a <- 10
*b = a
c <- c(5, 6)
```
]
---

# Introduction

```r
a <- 10
*b = a
f <- a
```

<p>Inline math is \(x_i = \sqrt{\frac{a}{c}} \), or eq:</p>
<p>$$x_i = \pi r_{i+1}^{\Lambda}$$</p>
<p>\[x_i = \pi r_{i}^{\Lambda}\]</p>

Inline math is `$x_i = \sqrt{\frac{a}{c}} $`, or eq:
`$$x_i = \pi r_{i+1}^{\Lambda}$$`
`$$x_i = \pi r_{i}^{\Lambda}$$`

.footnote[.red.bold[*] Important footnote]
---

class: center, middle

# `\(\LaTeX{}\)` in remark

---

# Display and Inline

1. This is an inline integral: `\(\int_a^bf(x)dx\)`
2. This is an inline integral, too: `$\int_a^bf(x)dx$`
3. More `\(x={a \over b}\)` formulae.

Display formula:
    `$$e^{i\pi} + 1 = 0$$`

---

# Figures optimized for slides

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
```

---

## continued

```r
png("~/repos/datacloning.github.io/images/480x.png",
    width = 480, height = 480)
op <- par(las=2, mar=c(6,5,2,2), mfrow=c(2,2))
barplot(1:length(dcpal_flatly), 
    names=names(dcpal_flatly), 
    border=dcpal_flatly$pre_border,
    col=unlist(dcpal_flatly))
barplot(1:10, col=dcpal_reds(10), main="Reds")
barplot(1:10, col=dcpal_grbu(10), main="Green-Blue")
barplot(1:10, col=dcpal_ogrd(10), main="Orange-Red")
par(op)
dev.off()
```

---

# 480 x 480

![]({{ site.url }}/images/480x.png)

---

## continued

```r
png("~/repos/datacloning.github.io/images/600x800.png",
    width = 800, height = 600)
op <- par(las=2, mar=c(6,5,2,2), mfrow=c(2,2))
barplot(1:length(dcpal_flatly), 
    names=names(dcpal_flatly), 
    border=dcpal_flatly$pre_border,
    col=unlist(dcpal_flatly))
barplot(1:10, col=dcpal_reds(10), main="Reds")
barplot(1:10, col=dcpal_grbu(10), main="Green-Blue")
barplot(1:10, col=dcpal_ogrd(10), main="Orange-Red")
par(op)
dev.off()
```

---

# 600 x 800: does not fit

![]({{ site.url }}/images/600x800.png)

???

Note: 600 x 800 fig is too big, don't use any text around it.
This is pretty much the max size for a figure.

---

![]({{ site.url }}/images/600x800.png)

???

It looks much better without a header. Keep that in mind.

</textarea>

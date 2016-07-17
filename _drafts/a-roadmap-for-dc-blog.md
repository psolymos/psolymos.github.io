---
title: "Roadmap for DC blog"
layout: blog
category: dc
tags: [blog, campaign]
comments: false
published: true
---

There are 2 categories:

* tutorial type post (Monday): mechanistic (how?) vs. understanding (why?)
* example type post (Friday)

## Tutorial posts: mechanics

1. Basic JAGS workflow (dclone-ified workflow)
2. Using `jags.fit` and updating the model
3. Understanding inits
4. Multiple model definition
5. Understanding modules in rjags
6. DC by hand: the `dclone` functionality
7. `dc.fit`
8. Advanced options: `dciid`, `dcdim`, `dctr`
8. Parallel computing intro (under the hood)
7. RNGs and why they matter
8. rjags in parallel
9. `jags.parfit` and friends
10. `dc.parfit` and size balancing
11. Design decisions and parallel implementation in dclone
12. MCMC diagnostics
13. DC diagnostics
14. MCMC plots
15. DC plots
16. `dcoptions` explained
16. dcmle explained
17. dcmle and package development: PVAClone, sharx, detect as examples
18. mgcv/jagam related models
19. data specifications
20. initial values (RNG seed and type included)

Extra: OpenBUGS, WinBUGS, Stan related posts. Especially when tied to:

* announcing new functionality (Stan)
* or commenting on papers that use Open/WinBUGS
* advertising unique functionality (OpenBUGS for examples)

## Tutorial posts: understanding

1. Understanding summaries: point estimates and interpretation
2. Understanding summaries: intervals and interpretation
3. Identifiability
4. Prior effects: estimates and intervals
5. Prior effects: prediction

## Example posts

These need to be added to dcexamples: need an infrastructure

* Classic BUGS examples (14+15=29 examples)
* Examples from published papers (Nadeem, Lele, Torabi, Solymos, etc.)
* Stan examples dclone-ified
* LM, LMM
* GLM, GLMM
* GAM, GAMM
* ZI and problems with initial values
* initial values for latent variables
* PVA
* Measurement error
* Occupancy
* N-mixture
* Phyogenetic regression
* Spatial models
* Calibration
* Meta analysis
* Expert opinion

Other ideas include:

* interview people using DC (Khurram N., Mahmoud T., Dave C.).


## Outlook

Use the 20-week campaign to build awareness, user community,
and encourage thinking and discussions.

5 months, 5*4=20 weeks, 20*2=40 posts

Each post is >500 words (500-1000, 1-2 pages), but we'll see.
Most ideal is 7 minutes (1600 words, 3 pages), not longer. Time it!

Title: ~6 words, ~100 characters

Video: 15-18 min.

Turn some of the posts into video tutorials.

Collect the posts in a book? How quickly it becomes obsolete?
Maybe just scrape and put in a self published one offering
print version on demand. This way there is no need for
dubious printing houses. Plus some can go into the heavier DC book.

Once it is written: schedule, and come up with social media
marketing plan ([Buffer](http://buffer.com),
[Hootsuite](https://hootsuite.com/), Pablo images, etc.)

Rendering DC examples is figured out: see `dcexamples/lab`.
This means that examples can be written up as
blog post and instantly made available as example.

## Stock images

Need a pool of picture that relates to DC.

Have to be distictive.

* Distance blur + perspective on:
  - gridded notebook paper (from above)
  - blueprint style (blue on white, or inverse)
  - black/green/white board (from side)
  - computer screen (slightly pixelated)

* Use:
  - relevant math formulae (latex or hand written)
  - hand drawn graphs
  - computer code
  - computer based graphics

## How to measure effectiveness of the campaign

Collect weekly info about:

* Website usage statistics
* Mailing list subscribers and discussions
* Comments on the blog
* Retweets, likes, mentions, whatever.
* CRAN downloads.

## Turn it into course

Use [DataCamp](https://www.datacamp.com/) template from [here](https://github.com/datacamp/courses-introduction-to-r)

Make it into a package with other courses:

1. R intro
2. Anatomy of linear models (prerequisite: 1)
3. A primer on JAGS (prerequisite: 1)
4. DC basics (prerequisite: 2 and 3)
5. Advanced DC (prerequisite: 4)
6. HPC intro (prerequisite: 1)
7. Parallel MCMC and DC (prerequisite: 4 and 6)

See also [OpenIntro](https://www.openintro.org/) model.

## Book chapters

1. Stats concepts -- draft done, SP to improve dcapps
2. Occupancy and abundance models -- code done, needs writing
3. LMM & GLMM iid -- code and text half baked: PS working on it
4. PVA (temporal dependence) -- code and text half baked: SRL working on it
5. Philosophical issues -- draft done, SRL to improve
6. MCMC algorithms -- Sept/Oct 2016
7. dclone tutorial -- PS to write blog posts (see above)

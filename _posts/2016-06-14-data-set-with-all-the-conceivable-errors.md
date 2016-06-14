---
title: "Data set with all the conceivable errors"
layout: default
published: true
category: Etc
tags: [R, data]
disqus: petersolymos
promote: false
---

As I was preparing for an [R intro course](https://github.com/psolymos/Rsessions/tree/master/Rintro)
I came up with the idea of creating a fake data set that is stuffed full
of all the conceivable errors one can imagine.
Just in case my imagination falls short, I'd appreciate all the suggestions
in the comments so that I can incorporate more errors.

There is a Hungarian saying about the *veterinarian's horse* to describe
a case that exhibits all the possible conditions a subject can suffer from
(read more of the etymology [here](http://english.stackexchange.com/questions/84564/a-case-that-exhibits-all-the-possible-conditions-a-subject-can-suffer-from)).
I would like to create a data set that shows all the
possible errors a data set can exhibit. This data would be then used in
the aforementioned course to make participants'
<del>life miserable</del> experience more diverse.

So far I have been able to come up with the following issues:

* ill formatted entries, usually as GIS output: `"1,234,567.0058654"` (needs to clear commas, turn it into numeric, digits are irrelevant but eating up memory)
* special characters (e.g. from MS Word) where UTF-8 or ASCII is expected
* mixed case typos: `"W-123"` vs. `"w-123"`
* leading/trailing whitespace: `"W-123"` vs. `"W-123 "`
* MS Excel turning values into dates (e.g. `0-3` works fine, but `3-5` becomes `05-Mar`)

I don't imagine that this list can ever be complete, but right now it is *far* from complete.
If you have struggled with a problem in the past and would like others to
learn from it, please leave a comment and I will expand the list
accordingly.

Peter Solymos's personal website
==========

## Todo in order of priority

- [x] update logline
- [x] create blog entries from News section
- [x] share buttons (Twitter etc)
- [ ] create category specific highlights once there are enough posts/category
- [x] qisqus to add in bottom is done but does not load: canonical problem? works mostly...
- [x] create R tag secific RSS feed as [here](http://jekyll.tips/tutorials/rss-feed/) or [here](https://github.com/snaptortoise/jekyll-rss-feeds/blob/master/feed.xml)
- [ ] add to R-bloggers [here](http://www.r-bloggers.com/add-your-blog/)
- [x] differentiate landing page by categories
- [x] finish embed
- [x] previous/next post buttons

## Organization

Categories:

* Papers: peer reviewed publications
  - `post.title` is short title
  - 1st paragraph is formatted citation (excrept)
  - full text etc. links defined in yaml header so that it can be pulled out
  - body after 1st paragraph: optional
  - use R tag (for `feed-r.xml`) if paper has R relevance, code explained, etc.
* Code: R package related info
  - use R tag (for `feed-r.xml`)
  - package can be just part of tags: list relevant posts for packages
  - this includes tutorials as well (tutorial as tag)
* Talks: slides, posters (tag reveling what kind)
* Etc, tag revealing what kind: 
  - here comes course announcements (tag: course), 
  - reports (non peer reviewed publications in general, tag: report),
  - R package updates (use R tag for `feed-r.xml`, package as tag too).

1-3 (few) posts can be promoted (`post.promote`)

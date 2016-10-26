Peter Solymos's personal website
==========

## Todo in order of priority

- [x] add to R-bloggers [here](http://www.r-bloggers.com/add-your-blog/)
- [x] include 'subscribe/follow' buttons at top of sidebar
  (see [here](http://coschedule.com/blog/write-a-great-blog-post/)).
- [x] update logline
- [x] create blog entries from News section
- [x] share buttons (Twitter etc)
- [x] create category specific highlights once there are enough posts/category
- [x] qisqus to add in bottom is done but does not load: canonical problem? works mostly...
- [x] create R tag secific RSS feed as [here](http://jekyll.tips/tutorials/rss-feed/) or [here](https://github.com/snaptortoise/jekyll-rss-feeds/blob/master/feed.xml)
- [x] differentiate landing page by categories
- [x] finish embed
- [x] previous/next post buttons
- [ ] add non peer-reviewed publications page

## Organization

Categories:

* Papers: peer reviewed publications
  - `post.title` is short title
  - 1st paragraph is formatted citation (excerpt)
  - full text etc. links defined in yaml header so that it can be pulled out
  - body after 1st paragraph: optional
  - use R tag (for `feed-r.xml`) if paper has R relevance, code explained, etc.
  - do not post abstract only posts, post only is it goes beyond
    (but in that case it is most likely to fall within the Code category
    with appropriate links/citations)
* Code: R package related info
  - use R tag (for `feed-r.xml`)
  - package can be just part of tags: list relevant posts for packages
  - this includes tutorials as well (tutorial as tag)
* Talks: slides, posters (tag reveling what kind)
* Etc, tag revealing what kind:
  - here comes course announcements (tag: course),
  - reports (non peer reviewed publications in general, tag: report),
  - R package updates (use R tag for `feed-r.xml`, package as tag too).

1-3 (few) posts can be promoted (`post.promote: true`), prefereably only 1.

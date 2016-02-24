---
title: Papers
description: "An archive of posts in the papers category"
layout: default
---

<h4 id="papers-external"><a href="http://scholar.google.ca/citations?hl=en&user=PfC17QsAAAAJ&view_op=list_works&pagesize=100">Google Scholar</a> &mdash;
<!-- <a href="https://vm.mtmt.hu/www/index.php?AuthorID=10000580">MTMT</a> &mdash; -->
<a href="http://orcid.org/0000-0001-7337-1740">ORCID</a> &mdash;
<a href="http://www.researcherid.com/rid/B-2775-2008">ResearcherID</a> &mdash;
<a href="http://www.scopus.com/authid/detail.url?authorId=23104106300">ScopusID</a> &mdash;
<a href="https://publons.com/a/534081/">Publon</a>
</h4>

<h4 id="year-lookup">{% for yr in site.data.papers limit:1 %}<a href="#papers-{{ yr.year }}">{{ yr.year }}</a>{% endfor %}{% for yr in site.data.papers offset:1 %} &mdash; <a href="#papers-{{ yr.year }}">{{ yr.year }}</a> {% endfor %} &mdash; <a href="https://sites.google.com/site/psolymosold/publications">&lt;2010</a></h4>

{% for yr in site.data.papers %}
<h2 id="papers-{{ yr.year }}">{{ yr.year }}</h2>
<ul>
  {% for ms in yr.papers %}
  <li>{{ ms.text }}{% if ms.link %} &mdash; <i class="fa fa-external-link text-orange"></i>&nbsp;<a href="{{ ms.link }}">journal website</a>{% endif %}{% if ms.fulltext %} &mdash; <i class="fa fa-file-pdf-o text-orange"></i>&nbsp;<a href="{{ ms.fulltext }}">fulltext PDF</a>{% endif %}{% if ms.code %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.code }}{% endif %}{% if ms.supportinginfo %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.supportinginfo }}{% endif %}. {% if ms.doi %}<div data-badge-popover="bottom" style="display: inline-block;" data-badge-type="4" data-doi="{{ ms.doi }}" data-hide-no-mentions="true" class="altmetric-embed"></div>{% endif %}</li>
  {% endfor %}
</ul>
{% endfor %}

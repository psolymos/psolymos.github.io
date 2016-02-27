---
title: Papers
description: "An archive of posts in the papers category"
layout: default
years: [2016, 2015, 2014, 2013, 2012, 2011, 2010]
---

<h4 id="papers-external"><a href="http://scholar.google.ca/citations?hl=en&user=PfC17QsAAAAJ&view_op=list_works&pagesize=100">Google Scholar</a> &mdash;
<!-- <a href="https://vm.mtmt.hu/www/index.php?AuthorID=10000580">MTMT</a> &mdash; -->
<a href="http://orcid.org/0000-0001-7337-1740">ORCID</a> &mdash;
<a href="http://www.researcherid.com/rid/B-2775-2008">ResearcherID</a> &mdash;
<a href="http://www.scopus.com/authid/detail.url?authorId=23104106300">ScopusID</a> &mdash;
<a href="https://publons.com/a/534081/">Publon</a>
</h4>

<ul>
  {% for ms in site.data.papers %}
  <li>{{ ms.text }}{% if ms.link %} &mdash; <i class="fa fa-external-link text-orange"></i>&nbsp;<a href="{{ ms.link }}">journal website</a>{% endif %}{% if ms.fulltext %} &mdash; <i class="fa fa-file-pdf-o text-orange"></i>&nbsp;<a href="{{ ms.fulltext }}">fulltext PDF</a>{% endif %}{% if ms.code %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.code }}{% endif %}{% if ms.supportinginfo %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.supportinginfo }}{% endif %}. {% if ms.doi %}<div data-badge-popover="bottom" style="display: inline-block;" data-badge-type="4" data-doi="{{ ms.doi }}" data-hide-no-mentions="true" class="altmetric-embed"></div>{% endif %}</li>
  {% endfor %}
</ul>

<h4 id="year-lookup">{% for yr in page.years %}<a href="#papers-{{ yr }}">{{ yr }}</a> &mdash; {% endfor %}<a href="https://sites.google.com/site/psolymosold/publications">&lt;2010</a></h4>

{% for yr in page.years %}
<h2 id="papers-{{ yr }}">{{ yr }}</h2>
<ul>
  {% for ms in site.data.papers %}
  <li>{{ ms.text }}{% if ms.link %} &mdash; <i class="fa fa-external-link text-orange"></i>&nbsp;<a href="{{ ms.link }}">journal website</a>{% endif %}{% if ms.fulltext %} &mdash; <i class="fa fa-file-pdf-o text-orange"></i>&nbsp;<a href="{{ ms.fulltext }}">fulltext PDF</a>{% endif %}{% if ms.code %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.code }}{% endif %}{% if ms.supportinginfo %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.supportinginfo }}{% endif %}. {% if ms.doi %}<div data-badge-popover="bottom" style="display: inline-block;" data-badge-type="4" data-doi="{{ ms.doi }}" data-hide-no-mentions="true" class="altmetric-embed"></div>{% endif %}</li>
  {% endfor %}
</ul>
{% endfor %}

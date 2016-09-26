---
title: Papers
description: "An list of peer-reviewed publications by Peter Solymos."
layout: default
years: [2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2005, 2004, 2002]
---

<div class="btn-group btn-group-justified">

  <div class="btn-group">
    <a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Bibliometrics <i class="fa fa-caret-down" aria-hidden="true"></i></a>
    <ul class="dropdown-menu">
      <li><a href="http://scholar.google.ca/citations?hl=en&user=PfC17QsAAAAJ&view_op=list_works&pagesize=100" class="btn btn-default">Google Scholar</a></li>
      <li><a href="http://orcid.org/0000-0001-7337-1740" class="btn btn-default">ORCID</a></li>
    <!--  <li><a href="https://vm.mtmt.hu/www/index.php?AuthorID=10000580" class="btn btn-default">MTMT</a></li> -->
      <li><a href="http://www.researcherid.com/rid/B-2775-2008" class="btn btn-default">ResearcherID</a></li>
      <li><a href="http://www.scopus.com/authid/detail.url?authorId=23104106300" class="btn btn-default">ScopusID</a></li>
     </ul>
  </div>

  <div class="btn-group">
    <a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Resources <i class="fa fa-caret-down" aria-hidden="true"></i></a>
    <ul class="dropdown-menu">
      <li><a href="https://publons.com/a/534081/" class="btn btn-default">Publons</a></li>
      <li><a href="https://drive.google.com/folderview?id=0B-q59n6LIwYPflA4aHVydEx5aFY5MUZtdFRvcG11NWNUc3ljOTdsSlFSSHRDdHJVMDEyWXc&usp=sharing" class="btn btn-default">Browse <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a></li>
      <li><a href="https://sites.google.com/site/psolymosold/publications/nonrefereed">Non refereed stuff</a></li>
     </ul>
  </div>

  <div class="btn-group">
    <a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">Jump to a year <i class="fa fa-caret-down" aria-hidden="true"></i></a>
    <ul class="dropdown-menu">
      {% for yr in page.years %}<li><a href="#papers-{{ yr }}">{{ yr }}</a></li> {% endfor %}
     </ul>
  </div>
</div>

{% for yr in page.years %}
<h2 id="papers-{{ yr }}">{{ yr }}</h2>
<ul>
  {% for ms in site.data.papers %}
  {% if ms.year == yr %}
  <li>{{ ms.text }}{% if ms.link %} &mdash; <i class="fa fa-external-link text-orange"></i>&nbsp;<a href="{{ ms.link }}">journal website</a>{% endif %}{% if ms.fulltext %} &mdash; <i class="fa fa-file-pdf-o text-orange"></i>&nbsp;<a href="{{ ms.fulltext }}">fulltext PDF</a>{% endif %}{% if ms.code %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.code }}{% endif %}{% if ms.supportinginfo %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.supportinginfo }}{% endif %}. {% if ms.doi %}<div data-badge-popover="bottom" style="display: inline-block;" data-badge-type="4" data-doi="{{ ms.doi }}" data-hide-no-mentions="true" class="altmetric-embed"></div>{% endif %}</li>
  {% endif %}
  {% endfor %}
</ul>
{% endfor %}

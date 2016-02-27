---
title: "R packages"
description: "An archive of posts in the code category"
layout: default
---

<h4 id="checks-external"><a href="http://cran.r-project.org/web/checks/check_summary_by_maintainer.html#address:solymos_at_ualberta.ca">CRAN checks</a> &mdash;
<a href="https://travis-ci.org/psolymos">Travis CI</a></h4>

{% for pkg in site.data.packages %}
<h2 id="code-{{ pkg.pkgname | downcase }}">{{ pkg.pkgname }}</h2>
<div class="row">
  <div class="col-md-4">
<p>{{ pkg.description }}</p>
  </div>
  <div class="col-md-4">
<ul class="fa-ul">

<li><i class="fa-li fa fa-archive text-black"></i><a href="http://cran.r-project.org/package={{ pkg.pkgname }}"><img src="http://www.r-pkg.org/badges/version/{{ pkg.pkgname }}" alt="CRAN version"></a>
<a href="http://cran.r-project.org/package={{ pkg.pkgname }}"><img src="http://cranlogs.r-pkg.org/badges/grand-total/{{ pkg.pkgname }}" alt="CRAN version"></a></li>
<li><i class="fa-li fa fa-github text-black"></i><a href="https://github.com/{{ pkg.devel }}/{{ pkg.pkgname }}">development</a> <a href="https://travis-ci.org/{{ pkg.devel }}/{{ pkg.pkgname }}"><img src="https://travis-ci.org/{{ pkg.devel }}/{{ pkg.pkgname }}.svg?branch=master" alt="build status"></a></li>
<li><i class="fa-li fa fa-bug text-black"></i><a href="https://github.com/{{ pkg.devel }}/{{ pkg.pkgname }}/issues">report an issue</a></li>
{% if pkg.paper %}<li><i class="fa-li fa fa-file-text-o text-black"></i>{{ pkg.paper }}</li>{% endif %}
</ul>
  </div>
</div>
{% endfor %}

## Other contributions

- adegenet: `coords.monmonier` &mdash; <i class="fa fa-archive text-black"></i> <a href="http://cran.r-project.org/package=adegenet">CRAN</a> &mdash; <i class="fa fa-github text-black"></i> <a href="https://github.com/psolymos/contrib">GitHub</a>
- plotrix: `ladderplot`, `ruginv`, `draw.ellipse` &mdash; <i class="fa fa-archive text-black"></i> <a href="http://cran.r-project.org/package=plotrix">CRAN</a> &mdash; <i class="fa fa-github text-black"></i> <a href="https://github.com/psolymos/contrib">GitHub</a>
- epiR: `epi.occc` &mdash; <i class="fa fa-archive text-black"></i> <a href="http://cran.r-project.org/package=epiR">CRAN</a> &mdash; <i class="fa fa-github text-black"></i> <a href="https://github.com/psolymos/contrib">GitHub</a>

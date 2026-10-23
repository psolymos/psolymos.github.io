---
title: "R packages"
description: "An archive of posts in the code category"
layout: default
excerpt: The list of software packages written by Peter Solymos.
---

<p id="checks-external">
<a href="https://psolymos.r-universe.dev">
    <img src="https://psolymos.r-universe.dev/badges/:total"></a> &mdash;
<a href="https://peter.solymos.org/packages/">Downloads</a> &mdash;
<a href="https://cran.r-project.org/web/checks/check_results_psolymos_at_gmail.com.html">CRAN checks</a>
</p>

<!-- tags -->
{% capture site_tags %}{% for tag in site.tags %}{{ tag | first }}{% unless forloop.last %},{% endunless %}{% endfor %}{% endcapture %}
{% assign tag_words = site_tags | split:',' | sort %}

{% for pkg in site.data.packages %}
<h3 id="code-{{ pkg.pkgname | downcase }}">{{ pkg.pkgname }}</h3>
<h4>{{ pkg.title }}</h4>
<div class="container">
<div class="row">
  <div class="col-md-4">
<p>{{ pkg.description }}</p>
  </div>
  <div class="col-md-4">
<ul class="fa-ul">

<li class="package-cran-link" data-package="{{ pkg.pkgname }}"><i class="fa-li fa fa-archive text-black"></i><a href="http://cran.r-project.org/package={{ pkg.pkgname }}"><img src="http://www.r-pkg.org/badges/version/{{ pkg.pkgname }}" alt="CRAN version"></a></li>
<li class="package-download-badge" data-package="{{ pkg.pkgname }}"><i class="fa-li fa fa-download text-black"></i><a href="http://cran.r-project.org/package={{ pkg.pkgname }}"><img src="http://cranlogs.r-pkg.org/badges/grand-total/{{ pkg.pkgname }}" alt="Total CRAN downloads"></a></li>
<li><i class="fa-li fa fa-github text-black"></i><a href="https://github.com/{{ pkg.devel }}/{{ pkg.pkgname }}">Development version</a></li>
<li><i class="fa-li fa fa-bug text-black"></i><a href="https://github.com/{{ pkg.devel }}/{{ pkg.pkgname }}/issues">Report an issue</a></li>
{% if pkg.paper %}<li><i class="fa-li fa fa-file-text-o text-black"></i>{{ pkg.paper }}</li>{% endif %}
{% for tag in tag_words %}{% if tag == pkg.pkgname %}{% assign post_count = site.tags[tag] | size %}<li><i class="fa-li fa fa-chevron-right text-black"></i><a href="{{ site.baseurl }}/tags.html#{{ tag | slugify }}">{{ post_count }} blog post{% if post_count > 1 %}s{% endif %}</a></li>{% endif %}{% endfor %}
</ul>
  </div>
  <div class="col-md-4">
    <div class="package-chart" data-package="{{ pkg.pkgname }}" aria-label="Monthly downloads for {{ pkg.pkgname }}"></div>
  </div>
</div>
</div>
{% endfor %}

<style>
  .package-chart { height: 180px; margin-bottom: 1.5rem; width: 100%; }
</style>

<script src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>
<script>
  (() => {
    const chartElements = [...document.querySelectorAll(".package-chart")];
    const cranLinks = [...document.querySelectorAll(".package-cran-link")];
    const downloadBadges = [...document.querySelectorAll(".package-download-badge")];
    let packageStats = null;

    const colors = () => {
      const style = getComputedStyle(document.documentElement);
      return {
        brand: style.getPropertyValue("--brand").trim(),
        ink: style.getPropertyValue("--ink").trim(),
        line: style.getPropertyValue("--line").trim()
      };
    };

    const draw = () => {
      const palette = colors();
      const statsByPackage = new Map(packageStats.map((entry) => [entry.name, entry]));

      [...cranLinks, ...downloadBadges].forEach((item) => {
        item.hidden = !statsByPackage.has(item.dataset.package);
      });

      chartElements.forEach((element) => {
        const stats = statsByPackage.get(element.dataset.package);
        const column = element.parentElement;

        if (!stats) {
          column.hidden = true;
          return;
        }

        column.hidden = false;
        const layout = {
          font: { color: palette.ink, family: "DM Sans, sans-serif", size: 11 },
          margin: { b: 28, l: 42, r: 10, t: 26 },
          paper_bgcolor: "rgba(0,0,0,0)",
          plot_bgcolor: "rgba(0,0,0,0)",
          showlegend: false,
          title: { text: "Monthly downloads", font: { size: 13 }, x: 0 },
          xaxis: { fixedrange: true, gridcolor: palette.line, showgrid: false, tickformat: "%Y" },
          yaxis: { fixedrange: true, gridcolor: palette.line, rangemode: "tozero", title: { text: "Downloads", font: { size: 10 } } }
        };

        Plotly.react(element, [{
          hovertemplate: "%{x|%b %Y}: %{y:,} downloads<extra></extra>",
          line: { color: palette.brand, width: 2 },
          mode: "lines",
          x: stats.downloads.date,
          y: stats.downloads.count,
          type: "scatter"
        }], layout, { displayModeBar: false, responsive: true });
      });
    };

    fetch("https://peter.solymos.org/packages/stats_latest.json")
      .then((response) => {
        if (!response.ok) throw new Error("Unable to load package statistics");
        return response.json();
      })
      .then((data) => {
        packageStats = data;
        draw();
      })
      .catch(() => {
        chartElements.forEach((element) => {
          element.textContent = "Download data could not be loaded.";
        });
      });

    new MutationObserver(() => {
      if (packageStats) draw();
    }).observe(document.documentElement, { attributes: true, attributeFilter: ["data-theme"] });
  })();
</script>

### Other contributions

- **adegenet**: `coords.monmonier` &mdash; <i class="fa fa-archive text-black"></i> <a href="http://cran.r-project.org/package=adegenet">CRAN</a> &mdash; <i class="fa fa-github text-black"></i> <a href="https://github.com/psolymos/contrib">GitHub</a>
- **plotrix**: `ladderplot`, `ruginv`, `draw.ellipse` &mdash; <i class="fa fa-archive text-black"></i> <a href="http://cran.r-project.org/package=plotrix">CRAN</a> &mdash; <i class="fa fa-github text-black"></i> <a href="https://github.com/psolymos/contrib">GitHub</a>
- **epiR**: `epi.occc` &mdash; <i class="fa fa-archive text-black"></i> <a href="http://cran.r-project.org/package=epiR">CRAN</a> &mdash; <i class="fa fa-github text-black"></i> <a href="https://github.com/psolymos/contrib">GitHub</a>

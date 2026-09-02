---
title: Papers
description: "A list of peer-reviewed publications by Peter Solymos."
layout: default
years: [2026, 2025, 2024, 2023, 2022, 2021, 2020, 2019, 2018, 2017, 2016, 2015, 2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2006, 2005, 2004, 2002, 2001, 2000, 1999, 1997, 1996]
min_mention: 3
excerpt: The list of peer-reviewed scientific papers written by Peter Solymos.
---

<!-- <div class="btn-toolbar papers-actions" role="toolbar" aria-label="Publication links">

  <div class="btn-group me-2 mb-2">
    <a href="{{ site.baseurl }}/papers/bibliometrics.html" class="btn btn-outline-primary">Bibliometrics</a>
  </div>

  <div class="btn-group me-2 mb-2">
    <a href="https://drive.google.com/folderview?id=0B-q59n6LIwYPflA4aHVydEx5aFY5MUZtdFRvcG11NWNUc3ljOTdsSlFSSHRDdHJVMDEyWXc&usp=sharing" class="btn btn-outline-primary">Browse fulltext <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
  </div>

  <div class="btn-group mb-2">
    <button class="btn btn-primary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
      Jump to a year
    </button>
    <ul class="dropdown-menu dropdown-menu-end">
      {% for yr in page.years %}<li><a class="dropdown-item" href="#{{ yr }}">{{ yr }}</a></li>{% endfor %}
    </ul>
  </div>

</div> -->

{% assign sorted_years = page.years | sort %}
{% assign min_year = sorted_years | first %}
{% assign max_year = sorted_years | last %}

{% capture all_labels_str %}{% for ms in site.data.papers %}{% for label in ms.labels %}{{ label }}|{% endfor %}{% endfor %}{% endcapture %}
{% assign all_labels = all_labels_str | split: "|" | uniq | sort %}

{% capture frequent_labels_str %}{% for label in all_labels %}{% unless label == "" %}{% assign label_count = 0 %}{% for ms in site.data.papers %}{% if ms.labels contains label %}{% assign label_count = label_count | plus: 1 %}{% endif %}{% endfor %}{% if label_count >= page.min_mention %}{{ label }}|{% endif %}{% endunless %}{% endfor %}{% endcapture %}
{% assign frequent_labels = frequent_labels_str | split: "|" %}

<div class="papers-filter">

  <div class="papers-filter-top">
    <div class="btn-group papers-filter-actions">
      <a href="{{ site.baseurl }}/papers/bibliometrics.html" class="btn btn-outline-primary btn-sm">Bibliometrics</a>
      <a href="https://drive.google.com/folderview?id=0B-q59n6LIwYPflA4aHVydEx5aFY5MUZtdFRvcG11NWNUc3ljOTdsSlFSSHRDdHJVMDEyWXc&usp=sharing" class="btn btn-outline-primary btn-sm">Browse fulltext <i class="fa fa-file-pdf-o" aria-hidden="true"></i></a>
    </div>

    <div class="year-range-filter">
      <div class="year-range-filter-header">
        <label class="form-label mb-0" for="yearRangeMin">Filter by year</label>
        <span class="year-range-filter-value"><span id="yearRangeMinLabel">{{ min_year }}</span>&ndash;<span id="yearRangeMaxLabel">{{ max_year }}</span></span>
      </div>
      <div class="year-range-slider">
        <div class="year-range-track"></div>
        <div class="year-range-progress" id="yearRangeProgress"></div>
        <input type="range" id="yearRangeMin" min="{{ min_year }}" max="{{ max_year }}" value="{{ min_year }}" step="1" aria-label="Minimum year">
        <input type="range" id="yearRangeMax" min="{{ min_year }}" max="{{ max_year }}" value="{{ max_year }}" step="1" aria-label="Maximum year">
      </div>
    </div>
  </div>

  <hr class="papers-filter-divider">

  <div class="label-filter-header">
    <button type="button" class="label-filter-toggle" data-bs-toggle="collapse" data-bs-target="#labelFilterCollapse" aria-expanded="false" aria-controls="labelFilterCollapse">
      <i class="fa fa-chevron-right" aria-hidden="true"></i> Filter by topic<span class="label-filter-count" id="labelFilterCount"></span>
    </button>
    <button type="button" class="btn btn-link btn-sm p-0" id="labelFilterClear" hidden>Clear selected topics</button>
  </div>
  <div class="collapse" id="labelFilterCollapse">
    <div class="label-filter-buttons" role="group" aria-label="Filter papers by topic">
      {% for label in frequent_labels %}{% unless label == "" %}<button type="button" class="btn btn-outline-secondary label-btn" data-label="{{ label }}" aria-pressed="false">{{ label | capitalize }}</button>
      {% endunless %}{% endfor %}
    </div>
  </div>
</div>


{% for yr in page.years %}
<div class="papers-year" data-year="{{ yr }}">
<h2 id="{{ yr }}">{{ yr }}</h2>
<ul>
  {% for ms in site.data.papers %}
  {% if ms.year == yr %}
  <li data-labels="{{ ms.labels | join: '|' }}">{{ ms.text }}{% if ms.link %} &mdash; <i class="fa fa-external-link text-orange"></i>&nbsp;<a href="{{ ms.link }}">journal website</a>{% endif %}{% if ms.fulltext %} &mdash; <i class="fa fa-file-pdf-o text-orange"></i>&nbsp;<a href="{{ ms.fulltext }}">fulltext PDF</a>{% endif %}{% if ms.code %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.code }}{% endif %}{% if ms.supportinginfo %} &mdash; <i class="fa fa-file-code-o text-orange"></i>&nbsp;{{ ms.supportinginfo }}{% endif %}. {% if ms.citations %}[Citations: <a target="_blank" href="https://scholar.google.ca/citations?view_op=view_citation&hl=en&user=PfC17QsAAAAJ&pagesize=100&authuser=1&citation_for_view=PfC17QsAAAAJ:{{ ms.pubid }}">{{ ms.citations}}</a>] {% endif %}{% if ms.doi %}<div data-badge-popover="bottom" style="display: inline-block;" data-badge-type="4" data-doi="{{ ms.doi }}" data-hide-no-mentions="true" class="altmetric-embed"></div>{% endif %}</li>
  {% endif %}
  {% endfor %}
</ul>
</div>
{% endfor %}

<script>
  (() => {
    const minInput = document.getElementById("yearRangeMin");
    const maxInput = document.getElementById("yearRangeMax");
    if (!minInput || !maxInput) return;

    const minLabel = document.getElementById("yearRangeMinLabel");
    const maxLabel = document.getElementById("yearRangeMaxLabel");
    const progress = document.getElementById("yearRangeProgress");
    const yearBlocks = document.querySelectorAll(".papers-year");
    const labelButtons = document.querySelectorAll(".label-btn");
    const clearButton = document.getElementById("labelFilterClear");
    const labelCount = document.getElementById("labelFilterCount");
    const rangeMin = Number(minInput.min);
    const rangeMax = Number(minInput.max);
    const selectedLabels = new Set();

    function updateLabelCount(matchCount) {
      if (selectedLabels.size === 0) {
        labelCount.textContent = "";
        return;
      }
      const topicWord = selectedLabels.size === 1 ? "topic" : "topics";
      const paperWord = matchCount === 1 ? "publication" : "publications";
      labelCount.textContent = ` (${selectedLabels.size} ${topicWord} and ${matchCount} ${paperWord} selected)`;
    }

    function clearLabelSelection() {
      selectedLabels.clear();
      labelButtons.forEach((button) => {
        button.classList.remove("active");
        button.setAttribute("aria-pressed", "false");
      });
    }

    function applyFilters() {
      const minVal = Number(minInput.value);
      const maxVal = Number(maxInput.value);
      minLabel.textContent = minVal;
      maxLabel.textContent = maxVal;
      const left = ((minVal - rangeMin) / (rangeMax - rangeMin)) * 100;
      const right = ((maxVal - rangeMin) / (rangeMax - rangeMin)) * 100;
      progress.style.left = left + "%";
      progress.style.width = (right - left) + "%";

      const availableLabels = new Set();
      yearBlocks.forEach((block) => {
        const yr = Number(block.dataset.year);
        if (yr < minVal || yr > maxVal) return;
        block.querySelectorAll("li[data-labels]").forEach((item) => {
          (item.dataset.labels ? item.dataset.labels.split("|") : []).forEach((label) => {
            if (label) availableLabels.add(label);
          });
        });
      });

      labelButtons.forEach((button) => {
        const label = button.dataset.label;
        const available = availableLabels.has(label);
        button.hidden = !available;
        if (!available && selectedLabels.has(label)) {
          selectedLabels.delete(label);
          button.classList.remove("active");
          button.setAttribute("aria-pressed", "false");
        }
      });

      let totalMatches = 0;
      yearBlocks.forEach((block) => {
        const yr = Number(block.dataset.year);
        if (yr < minVal || yr > maxVal) {
          block.hidden = true;
          return;
        }

        let visibleCount = 0;
        block.querySelectorAll("li[data-labels]").forEach((item) => {
          const itemLabels = item.dataset.labels ? item.dataset.labels.split("|") : [];
          const visible = selectedLabels.size === 0 || itemLabels.some((label) => selectedLabels.has(label));
          item.hidden = !visible;
          if (visible) visibleCount += 1;
        });
        block.hidden = visibleCount === 0;
        totalMatches += visibleCount;
      });

      updateLabelCount(totalMatches);
    }

    minInput.addEventListener("input", () => {
      if (Number(minInput.value) > Number(maxInput.value)) {
        minInput.value = maxInput.value;
      }
      clearLabelSelection();
      applyFilters();
    });
    maxInput.addEventListener("input", () => {
      if (Number(maxInput.value) < Number(minInput.value)) {
        maxInput.value = minInput.value;
      }
      clearLabelSelection();
      applyFilters();
    });

    labelButtons.forEach((button) => {
      button.addEventListener("click", () => {
        const label = button.dataset.label;
        const isActive = button.classList.toggle("active");
        button.setAttribute("aria-pressed", String(isActive));
        if (isActive) {
          selectedLabels.add(label);
        } else {
          selectedLabels.delete(label);
        }
        applyFilters();
      });
    });

    clearButton.addEventListener("click", () => {
      clearLabelSelection();
      applyFilters();
    });

    const labelCollapse = document.getElementById("labelFilterCollapse");
    const labelChevron = document.querySelector(".label-filter-toggle .fa");
    labelCollapse.addEventListener("shown.bs.collapse", () => {
      labelChevron.classList.replace("fa-chevron-right", "fa-chevron-down");
      clearButton.hidden = false;
    });
    labelCollapse.addEventListener("hidden.bs.collapse", () => {
      labelChevron.classList.replace("fa-chevron-down", "fa-chevron-right");
      clearButton.hidden = true;
    });

    applyFilters();
  })();
</script>

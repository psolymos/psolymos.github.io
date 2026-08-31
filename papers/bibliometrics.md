---
title: Bibliometrics
description: "Bibliometrics for publications by Peter Solymos."
layout: default
excerpt: Bibliometrics for publications by Peter Solymos.
---

> Below are plots of the number of publications and citations over time, based on data from Google Scholar, cleaned up to show only papers, without software related entries.

- [Google Scholar](http://scholar.google.ca/citations?hl=en&user=PfC17QsAAAAJ&view_op=list_works&pagesize=100)
- [ORCID](http://orcid.org/0000-0001-7337-1740)
- [ResearcherID](http://www.researcherid.com/rid/B-2775-2008)
- [Scopus](http://www.scopus.com/authid/detail.url?authorId=23104106300)
- [Browse fulltext PDFs](https://drive.google.com/folderview?id=0B-q59n6LIwYPflA4aHVydEx5aFY5MUZtdFRvcG11NWNUc3ljOTdsSlFSSHRDdHJVMDEyWXc&usp=sharing)

<div class="bibliometrics-charts" aria-live="polite">
  <section class="bibliometrics-chart-section">
    <h2>Publications over time</h2>
    <div id="publications-chart" class="bibliometrics-chart" aria-label="Stacked bar chart of publications by year and topic"></div>
  </section>
  <section class="bibliometrics-chart-section">
    <h2>Cumulative publications</h2>
    <div id="cumulative-publications-chart" class="bibliometrics-chart" aria-label="Step chart of cumulative publications by topic"></div>
  </section>
  <section class="bibliometrics-chart-section">
    <h2>Citations over time</h2>
    <div id="citations-chart" class="bibliometrics-chart" aria-label="Stacked bar chart of citations by year and topic"></div>
  </section>
  <section class="bibliometrics-chart-section">
    <h2>Cumulative citations</h2>
    <div id="cumulative-citations-chart" class="bibliometrics-chart" aria-label="Step chart of cumulative citations by topic"></div>
  </section>
  <section class="bibliometrics-chart-section">
    <h2>H-index</h2>
    <div id="h-index-chart" class="bibliometrics-chart" aria-label="Ranked citations chart with H-index reference"></div>
  </section>
</div>

<p id="bibliometrics-chart-error" class="bibliometrics-chart-error" hidden>Charts could not be loaded. Please try again later.</p>

<style>
  .bibliometrics-chart-section { margin: 2.5rem 0; }
  .bibliometrics-chart-section h2 { font-size: 1.35rem; margin-bottom: 0.65rem; }
  .bibliometrics-chart { width: 100%; aspect-ratio: 3 / 2; min-height: 350px; }
  .bibliometrics-chart-error { color: var(--accent); font-weight: 600; }
  @media (max-width: 575.98px) { .bibliometrics-chart { min-height: 300px; } }
</style>

<script src="https://cdn.plot.ly/plotly-2.35.2.min.js"></script>
<script>
  (() => {
    const errorEl = document.getElementById("bibliometrics-chart-error");
    let latestData = null;

    const themeColors = () => {
      const style = getComputedStyle(document.documentElement);
      return {
        all: style.getPropertyValue("--brand").trim(),
        molluscs: "#ffbe0b",
        other: "#3a86ff",
        guide: style.getPropertyValue("--mint").trim(),
        ink: style.getPropertyValue("--ink").trim(),
        line: style.getPropertyValue("--line").trim()
      };
    };
    const buildLayout = (yTitle, colors, extra = {}) => ({
      barmode: "stack",
      font: { family: "DM Sans, sans-serif", color: colors.ink },
      legend: { orientation: "h", y: 1.14 },
      margin: { l: 58, r: 20, t: 25, b: 52 },
      paper_bgcolor: "rgba(0,0,0,0)",
      plot_bgcolor: "rgba(0,0,0,0)",
      xaxis: { title: "Year", fixedrange: true, gridcolor: colors.line },
      yaxis: { title: yTitle, fixedrange: true, gridcolor: colors.line, rangemode: "tozero" },
      ...extra
    });
    const cumulative = (values) => values.reduce((totals, value) => [...totals, (totals.at(-1) || 0) + value], []);
    const trace = (name, x, y, color) => ({ name, x, y, line: { color, width: 3, shape: "hv" }, marker: { color }, mode: "lines", type: "scatter" });
    const render = (id, data, layout) => Plotly.newPlot(id, data, layout, { displayModeBar: false, responsive: true });

    const draw = ({ yearly, rankedCitations, hIndex }) => {
      const colors = themeColors();
      const years = yearly.map((row) => row.year);
      const molluscs = yearly.map((row) => row.molluscs);
      const other = yearly.map((row) => row.other);
      const citationMolluscs = yearly.map((row) => row.citationsMolluscs);
      const citationOther = yearly.map((row) => row.citationsOther);
      const publications = molluscs.map((value, index) => value + other[index]);
      const citations = citationMolluscs.map((value, index) => value + citationOther[index]);

      render("publications-chart", [
        { name: "Molluscs", x: years, y: molluscs, marker: { color: colors.molluscs }, type: "bar" },
        { name: "Other", x: years, y: other, marker: { color: colors.other }, type: "bar" }
      ], buildLayout("Publications", colors));

      render("cumulative-publications-chart", [
        trace("All papers", years, cumulative(publications), colors.all),
        trace("Molluscs", years, cumulative(molluscs), colors.molluscs),
        trace("Other", years, cumulative(other), colors.other)
      ], buildLayout("Cumulative publications", colors));

      render("citations-chart", [
        { name: "Molluscs", x: years, y: citationMolluscs, marker: { color: colors.molluscs }, type: "bar" },
        { name: "Other", x: years, y: citationOther, marker: { color: colors.other }, type: "bar" }
      ], buildLayout("Citations", colors));

      render("cumulative-citations-chart", [
        trace("All papers", years, cumulative(citations), colors.all),
        trace("Molluscs", years, cumulative(citationMolluscs), colors.molluscs),
        trace("Other", years, cumulative(citationOther), colors.other)
      ], buildLayout("Cumulative citations", colors));

      const ranks = rankedCitations.map((_, index) => index + 1);
      render("h-index-chart", [
        trace("Citations", ranks, rankedCitations, colors.all)
      ], buildLayout("Citations", colors, {
        showlegend: false,
        xaxis: { title: "Publication rank", fixedrange: true, gridcolor: colors.line, range: [1, rankedCitations.length] },
        shapes: [
          { type: "line", x0: hIndex, x1: hIndex, y0: 0, y1: hIndex, line: { color: colors.guide, dash: "dash" } },
          { type: "line", x0: 1, x1: hIndex, y0: hIndex, y1: hIndex, line: { color: colors.guide, dash: "dash" } }
        ],
        annotations: [{ x: hIndex, y: hIndex, text: `H-index: ${hIndex}`, showarrow: true, arrowhead: 2, ax: 42, ay: -34, font: { color: colors.guide } }]
      }));
    };

    fetch("{{ site.baseurl }}/papers/bibliometrics.json")
      .then((response) => {
        if (!response.ok) throw new Error("Unable to load chart data");
        return response.json();
      })
      .then((data) => {
        latestData = data;
        draw(data);
      })
      .catch(() => {
        errorEl.hidden = false;
      });

    // Redraw with the new palette whenever the site-wide dark/light toggle flips data-theme.
    new MutationObserver(() => {
      if (latestData) draw(latestData);
    }).observe(document.documentElement, { attributes: true, attributeFilter: ["data-theme"] });
  })();
</script>

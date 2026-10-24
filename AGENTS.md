# Repository Guide

## Overview

This repository is the source for Peter Solymos's Jekyll site, deployed at `https://peter.solymos.org`.

- Site configuration: `_config.yml`
- Layouts and reusable markup: `_layouts/`, `_includes/`
- Pages: top-level HTML/Markdown directories such as `about/`, `code/`, `papers/`, and `talks/`
- Blog posts: `_posts/`
- Structured content: `_data/`
- Static assets and site styling: `assets/`, `images/`
- Generated output: `_site/` (do not hand-edit)

## Content Conventions

- Use YAML data files for structured publication and package data.
- Publication records are maintained in `_data/papers.yml`; `_data/papers_to_edit.yml` is the working source used by `_R/citations.R`.
- Package entries are maintained in `_data/packages.yml`; `code/index.md` renders the package listing.
- Preserve existing Liquid, HTML, and Markdown style in page files. Avoid broad formatting changes.

## Local Development

Use Docker for a reproducible Jekyll environment. The image uses Ruby 3.2, Jekyll 4.3, and WEBrick.

```sh
docker build -t psolymos-site .
docker run --rm -it -p 4000:4000 -p 35729:35729 -v "$PWD":/srv/jekyll psolymos-site
```

Browse the local site at `http://localhost:4000`. The Docker command overrides the production `baseurl` from `_config.yml`; keep that override so root paths work locally. Stop the server with `Ctrl-C`.

Build-only validation:

```sh
docker run --rm -v "$PWD":/srv/jekyll psolymos-site \
  bundle exec jekyll build --destination /tmp/site
```

## Code Page Charts

`code/index.md` loads monthly package statistics from:

`https://peter.solymos.org/packages/stats_latest.json`

The chart, CRAN version link, and CRAN download badge are shown only when a package name in `_data/packages.yml` occurs in that feed. Keep the `data-package` values aligned with feed names. The page uses Plotly from its CDN and redraws charts when the site theme changes.

After changing the code page, render it in Docker and confirm the expected chart hooks:

```sh
docker run --rm -v "$PWD":/srv/jekyll psolymos-site sh -lc \
  'bundle exec jekyll build --destination /tmp/site && grep -c "package-chart" /tmp/site/code/index.html'
```

## Editing Guidance

- Do not edit `_site/`; regenerate it through Jekyll when needed.
- Keep production URLs and deployment configuration in `_config.yml` unless the request explicitly changes site deployment.
- Prefer focused changes to source files and validate them with the Docker build.

## Style Conventions

- Reuse the existing Bootstrap 5 classes, CSS variables, layouts, and includes before introducing new patterns or dependencies.
- Preserve accessible semantics: meaningful image alternatives, form labels, keyboard-operable controls, visible focus, and appropriate ARIA for dynamic updates.
- Check color contrast in both dark and light themes when changing UI colors or components.
- Follow W3C accessibility guidelines, targeting WCAG 2.2 AA for semantics, keyboard access, focus, contrast, and dynamic content.
- Keep page titles, descriptions, thumbnails, and other relevant front matter accurate when adding or revising pages.

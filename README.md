# Academic website template

This template is based on the [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/) Jekyll theme, more specifically, it is an adaptation of the (blog) theme to academic portfolio website by [Maximilian Kasy](https://github.com/maxkasy/home).

See a demo [here](https://peter.solymos.org/academic-website-template/).

## Structure of the template

The folder structure and customization options are documented on the [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/docs/quick-start-guide/) website. 

Here are some of the highlights for the Jekyll templating (i.e. these directories are used to build the website but are not published):

- `_data`: this is where site data is stored, can be in YAML or CSV format
- `_includes`: this is where the 'partials' are stored, which are the little pieces that the layouts are made of (e.g. header, footer, navigation, etc.)
- `_layouts`: this is where the page layouts are defined, _this_ theme add the `academic.html` layout that is derived from the default layout and adds JavaScript and CSS assets
- `_sass`: this is where the [Minimal Mistakes styles](https://mmistakes.github.io/minimal-mistakes/docs/stylesheets/) are defined
- `_config.yml`: configuration, see below
- other files in the root folder are needed for Jekyll to render the site properly 

The following folders are published:

- `assets`: this is where CSS, JavaScript, and image files are stored, most notably:
  - `assets/images/avatar.jpg` is used as the avatar image
  - `assets/css/listing.css` defines styles for lists and form elements for publications, software
- `code`, `cv`, `publications`, `teaching`: these are placeholders for the content, each directory contains an `index.md` file that is explained below
- `index.md`: this is the landing (home) page
- `favicon.ico`: this is small PNG image that is displayed in the browser tab besides the page title

## Configuration

### Personal info

Edit the `_config.yml` file (name, social, Googl Analytics tag, etc.).

Change the `assets/images/avatar.jpg` picture, make sure it is a square image otherwise the image will look like an ellipse, not a circle.

Replace `favicon.ico`: create a logo and save it as a 50x50 pixel PNG image, possibly with transparent beckground.

### Top navigation

Edit the `_data/navigation.yml` file to change to top navigation and create corresponding pages. I.e. if the link is `/nextpage/`, create a folder called `nextpage` and include an `index.md` file in it.

### Pages

Edit the `index.md` file as needed.

Other pages are all called `index.md` but are placed inside a directory. This will result in a URL path: `https://yoursite.com/directory/` (without explicitly adding the file to the end).

Edit the `cv/index.md`, `teaching/index.md` as regular markdown file. All markdown formatting will render accordingly to html, see some tips [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

If you want to rename the directories, just go ahead.

If you want to add new pages: create a new folder, create a new text file called `index.html` inside this new folder. Add the yaml header as the following:

```yaml
---
title: Welcome!
layout: academic
author_profile: true
---
```

The `author_profile` sets the profile in the left sidebar, so keep it `true`. If you want to remove the avatar image from the sidebar, set the `author_image: false` to disable it in the yaml header of the page. Change the title as needed.

The `_config.yml` file sets defaults for the page header values, it currently has the following defaults for all the site (i.e. you can omit these from the header when creating new pages, or override with other values):

```yaml
---
layout: academic
author_profile: true
author_image: true
---
```

Edit the top navigation inside the `_data/navigation.yml` file if you want the new page to be listed at the top.

### Publications

Publications are listed in the `/publications/index.md` page. Due to the filtering options, updating the publications is not done directly in the markdown file. Instead, add new publication entries to the `_data/publications_to_edit.yml` file according to this template:

```yaml
- id: Mathur2020
  text: "Mathur MB & VanderWeele TJ (2020). Sensitivity analysis for unmeasured confounding in meta-analyses. Journal of the American Statistical Association, 115(529), 163-170."
  year: 2020
  type: "methods"
  authorship: "first"
  status: "published"
  preprint: "https://link.to/preprint"
  datarepo: "https://osf.io/2r3gm/"
  rpackagename: "EValue"
  rpackagelink: "https://CRAN.R-project.org/package=EValue"
  webappname: "EValue Calculator"
  webapplink: "https://www.evalue-calculator.com/meta/"
  doi: "10.1080/01621459.2018.1529598"
  google_id:
  google_cites:
```

Most of the fields are self explanatory, here are the ones that are currently used for filtering and need to be exact:

- `year`: keep it as numeric (i.e. no quotes), use the current year for unpublished or in prep articles -- this is used for sorting the articles (within years the order in the yaml determines the order of the entries, i.e. no alphabetical sorting is done)
- `type`: can be "empirical" or "methods"
- `authorship`: can be "first" or "last" (senior)
- `status`: "inprep" (in preparation), "inpress" (in press), or "published"

The page displays a range slider for filtering publications by year. By default all years are displayed.

There are also check boxes for publication type, authorship and status. By default all of the boxes are checked and all the publications are displayed. When checkboxes are unchecked, only a corresponding subset will be displayed within the requested range of years.

You can use HTML markup inside the `text` field, e.g. `<em>Journal</em> <strong>25</strong>:1&ndash;10`. Use `<strong>` for bold, `<em>` for italics, `<span style='text-decoration:underline;'>` for underlined text. Make sure to use single quotes inside the `text` field (`text: "text with 'quotes' here"`).

Publication page displays the [Altmetric](https://api.altmetric.com/embeds.html) badge based on DOI, which shows social mentions.

Google Scholar citations are added by the GitHub action based on the `google_id`:

- edit the `_data/publications_to_edit.yml` file: add `google_id` for the publication, see the `_R/get-publication-id.R` script
- commit the changes to the `main` branch
- the GitHub action will run the `_R/update-citations.R` script when committing to the `main` branch, or on a schedule every Sunday
- this script write the `_data/publications.yml` that includes the citations, this is the file used by Jekyll

### Software

Software are listed on the `code` path. Add new software entries to the `_data/software.yml` file according to this template:

```yaml
- name: regmedint
  description: Regression-based causal mediation analysis with a treatment-mediator interaction term.
  link: https://cran.r-project.org/web/packages/regmedint/index.html
  type: R package
  domain: Statistics
```

Software type can be "R package", "Stata module", or "GUI". The domain can be "Statistics", "Psychology". These options are hard coded into the `code/index.md` file.

## Implementation

The publication and software pages implement client side rendering based on the JSON objects rendered by Jekyll. So when you edit the `_data/*.yml` files, those will be part of the HTML file's JavaScript code. This JSON object is then used by the Vue library to do the filtering on the client side (i.e. it can change dynamically, it is not part of the DOM but rather it lives in a virtual DOM).

If you want to change the controls on these pages, you'll have to edit the computed properties function and watch out for the yaml data and its properties.

Besides the JavaScript part of Vue, components are also part of the HTML code inside the markdown file. Because Vue components use the mustache notation (`{{ ... }}`) that Jekyll is using too, we have to put the Vue components between `{% raw %}` and `{% endraw %}` to tell Jekyll to leave this part alone.

## GitHub pages

Go to your project Settings / Pages, set source to the branch you are hosting the site on (`main`, `gh-pages`), from root (`/`). Click Save, set 'Enforce HTTPS` if you like. Jekyll is the default static site builder for GitHub pages, it'll just work.

## Maya's notes to self (to organize)

- Altmetric is based on the article's DOI, not its URL
- Update CV by uploading a new copy of "CV for website.pdf" to Dropbox/Public with same name
- mayamathur.com domain is registered via Netlify

## Docker based development

This makes development and testing easier, because we don't need Roby and Jekyll to be installed locally, only Docker Desktop.

```
docker run --rm \
  --volume="$PWD:/srv/jekyll:Z" \
  --publish 4000:4000 \
  jekyll/jekyll:3 \
  jekyll serve
```
# Deploying & maintaining mayamathur.com

This guide assumes you already have:
- A GitHub repository that's serving mayamathur.com via GitHub Pages
- Git installed locally, and you can push to that repo
- A reasonable text editor (VS Code, Sublime, whatever)

If any of that isn't true, jump to the "First-time setup" section at the bottom.

---

## The quick mental model

Your site has three live pages: home (`/`), Publications (`/publications/`), and Software (`/code/`). Each page is an HTML file that pulls data from a YAML file at build time. **You never edit the HTML directly to add/remove a paper or a package.** You edit the YAML, push, wait a minute, and the site updates.

```
_data/publications.yml   ←  edit this to add/remove/change papers
_data/software.yml       ←  edit this to add/remove/change R packages or tools

index.html               ←  home page (edit only to change bio, awards, etc.)
publications.html        ←  publications page (don't edit unless restyling)
code.html                ←  software page (don't edit unless restyling)

assets/images/           ←  put new images here
```

---

## Adding a new publication

You just published a paper. Here's what to do:

**1.** Open `_data/publications.yml` in your editor.

**2.** Add a new entry at the top of the file (above `# --------------------------- In preparation ---------------------------`). Copy an existing entry as a template. It should look like:

```yaml
- id: Mathur2027a
  text: "<u>Mathur MB</u> & Shpitser I (2027). Your shiny new paper title. <strong>Journal of Statistics</strong>, 42(1), 1-20."
  year: 2027
  type: "methods"
  authorship: "first"
  status: "published"
  topics: ["missing-data", "causal-inference"]
  journal_url: "https://doi.org/10.1000/xxxxx"
  preprint_url: "https://osf.io/preprints/osf/XXXXX/"
  datarepo: "https://osf.io/YYYYY/"
```

**3. Fields you must fill in:**

| Field | What to put |
|---|---|
| `id` | A unique identifier. Convention: `{LastName}{Year}{letter}`. Must not already exist in the file. |
| `text` | The full citation string. `<u>Mathur MB</u>` is how you bold your own name. `<strong>Journal Name</strong>` italicizes the journal. |
| `year` | Publication year (number, no quotes) |
| `type` | `"methods"` or `"empirical"` |
| `authorship` | `"first"`, `"last"`, or `"middle"` |
| `status` | `"published"`, `"inpress"`, or `"inprep"` |
| `topics` | An array of one or more topic IDs (see list below) |

**4. Fields that are optional** (leave them out if they don't apply):

| Field | What to put |
|---|---|
| `journal_url` | URL to the final published version (usually `https://doi.org/<doi>`). Title of the paper will link here. |
| `preprint_url` | URL to an open-access / preprint copy. If both this and `journal_url` are set, a small "Open-access copy" button appears. If only this is set (no journal version), the title links to the preprint. |
| `datarepo` | URL to an OSF / GitHub repo with code and data |
| `rpackagename` | Name of the associated R package |
| `rpackagelink` | URL to that package |
| `webappname` | Name of an associated web app |
| `webapplink` | URL to that web app |
| `mentee_led` | `true` if led by your student, mentee, or staff scientist |
| `media_coverage` | Array of outlets that covered the paper (see below) |

**5. Save the file.**

**6. Push to GitHub:**
```
git add _data/publications.yml
git commit -m "Add paper: your paper title"
git push
```

**7. Wait about 60 seconds. Refresh mayamathur.com/publications/. Your paper should be there.**

---

## The full list of topic IDs

Use these exactly — they're the IDs, not the display titles:

**Methods:**
- `meta-analysis`
- `missing-data` (also covers selection bias)
- `sensitivity`
- `methods-applied` (methodology papers in substantive journals)
- `methods-other`

**Meta-science & open science:**
- `meta-science`
- `open-science`

**Empirical:**
- `animal-ag`
- `exp-psych`
- `medicine`
- `potpourri`

**Secondary tags** (use alongside a primary topic; they don't create their own section but show as pills):
- `causal-inference`
- `empirical-meta` (i.e., "this paper is itself an empirical meta-analysis")

A paper can belong to multiple topics. The **first one in the list** is its "home" — which section the paper appears in. The others render as secondary tags. Example: `topics: ["missing-data", "causal-inference"]` puts the paper in the Missing data section with a Causal inference tag alongside.

---

## Adding media coverage to a paper

If a paper gets covered in the press, add a `media_coverage` field to its YAML entry:

```yaml
  media_coverage:
    - name: "The New York Times"
      url: "https://www.nytimes.com/..."
    - name: "Vox"
    - name: "CNN"
```

The `url` is optional — without it, the outlet just shows as text.

---

## Adding a new R package (or web tool)

**1.** Open `_data/software.yml`.

**2.** Add an entry to the appropriate list (`web_tools`, `r_packages`, or `stata_modules`). Copy an existing entry as a template.

For an R package:
```yaml
  - name: "newpackage"
    description: "One-sentence description of what it does."
    contributors: "Mathur, Collaborator"
    cran: "https://cran.r-project.org/package=newpackage"
    github: "https://github.com/yourrepo/newpackage"
```

Both `cran` and `github` are optional. If the package isn't on CRAN yet, just leave that field out.

**3.** Save, commit, push. Same workflow as publications.

---

## Correcting a typo in an existing paper

Find the entry in `_data/publications.yml`, fix the typo in the `text` field, save, commit, push.

---

## Removing a paper

Delete the entire entry (the `- id:` line through all its indented fields) and push.

---

## Changing the home page bio or awards

Those are in `index.html`. Edit the HTML directly. The file is long but well-commented — search for "bio serious" to find the serious bio, "Selected awards" to find the awards list, etc.

---

## The "Very unserious science" entry

There's a placeholder entry at the end of `_data/publications.yml` for your OSF preprint e5dyt. When you're ready to make it visible, update the `text` field with the real title. It stays hidden from the main view — only shows when someone clicks the "Looking for something stranger?" link in the Publications page footer.

---

## Locally previewing before you push (optional but recommended)

You can run the site on your own machine to check that edits look right before pushing. First time only:

```
# Install Ruby if you don't have it (macOS: brew install ruby)
gem install bundler
cd path/to/your-repo
bundle install
```

Then, every time you want to preview:

```
bundle exec jekyll serve
```

Open `http://localhost:4000` in your browser. The site rebuilds every time you save a file.

---

## First-time setup (if you're starting from scratch)

Skip this if your repo already works.

**1.** Create a new GitHub repo. Name it something neutral like `mayamathur.github.io` or `personal-website`.

**2.** In the repo's Settings → Pages, set the source to "Deploy from a branch" and choose `main`.

**3.** In your domain registrar (wherever you bought mayamathur.com), set up a CNAME pointing `www.mayamathur.com` to `<your-github-username>.github.io`. Also set up A records for the apex domain pointing to GitHub's IPs:
```
185.199.108.153
185.199.109.153
185.199.110.153
185.199.111.153
```

**4.** Drop all the files in this bundle into the repo root. Keep the folder structure: `_data/` files must be in `_data/`, `assets/images/` files must be in `assets/images/`, etc.

**5.** Commit and push. Wait 1-2 minutes for GitHub Pages to build.

---

## If something breaks

**Symptom: site shows old content after a push.**
Wait another minute. GitHub Pages caches. Hard refresh in your browser (Cmd+Shift+R on Mac).

**Symptom: page fails to build, site goes down.**
GitHub will email you with a build error. Usually it's a YAML syntax issue — a missing quote, bad indentation. Open the file, look for the line number in the error, fix, push again.

**Symptom: a paper doesn't appear.**
Check that its `topics` field has at least one ID that matches the list above (no typos). Check that the YAML indentation is exactly two spaces, matching nearby entries.

**Symptom: an image doesn't load.**
Check that the image path starts with `/assets/images/` (the leading slash matters on Jekyll) and that the filename in the file tree matches exactly, including case.

---

## What not to touch unless you mean it

- `_config.yml` — Jekyll configuration. Rarely needs changes.
- `publications.html`, `code.html` — these are the page layouts. Editing them changes styling, tags available, etc. Don't edit these just to add a paper — use the YAML instead.
- `Gemfile` — describes which Ruby gems the site needs.
- `CNAME` — tells GitHub which domain you use. Don't change unless your domain changes.

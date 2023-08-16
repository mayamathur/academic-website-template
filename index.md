---
title: 
layout: academic
author_profile: true
author_image: false
---

{% assign author = page.author | default: page.authors[0] | default: site.author %}
{% assign author = site.data.authors[author] | default: author %}
<div class="author__avatar__large">
  {% if author.avatar contains "://" %}
    {% assign author_src = author.avatar %}
  {% else %}
    {% assign author_src = author.avatar | relative_url %}
  {% endif %}
  <img src="{{ author_src }}" alt="{{ author.name }}" itemprop="image">
</div>

Maya Mathur is an Assistant Professor at Stanford University's [Quantitative Sciences Unit](https://med.stanford.edu/qsu.html) and the Department of Pediatrics. She is a statistician whose methodological research focuses on meta-analysis and other forms of evidence synthesis, as well as causal inference. Outside of methodological research, she is the Associate Director of the Stanford Data Science's [Center for Open and Reproducible Science (CORES)](https://datascience.stanford.edu/cores) and principal investigator of the [Stanford Humane and Sustainable Food Lab](https://www.foodlabstanford.com/). She has received early-career and young investigator awards from the Society for Epidemiologic Research (2022), the Society for Research Synthesis Methods (2022), and the American Statistical Association (2018).

Her CV is available [here](https://www.dropbox.com/s/985kkhr9rm4kf16/Mathur%20CV.pdf?dl=0). A list of publications is available [here](https://www.mayamathur.com/publications/) and on [Google Scholar](https://scholar.google.com/citations?user=vmuNN1sAAAAJ&hl=en). Repositories with data, code, and materials for her research are available on the [Open Science Framework](https://osf.io/e9tg8/), and many of her teaching slide decks are [publicly available](https://osf.io/x7zgu/).

### Research interests
- Meta-analysis
- Causal inference
- Reproducibility and replication
- Statistical methods for epidemiology
- Sustainable food
- Behavior interventions

### Education
- **PhD Biostatistics**, Harvard University (2015-2018)
- **MS Statistics**, Stanford University (2011-2013)
- **BA Psychology**, Stanford University (2009-2013)


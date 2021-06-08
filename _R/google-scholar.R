library(yaml) # read/write yaml
library(scholar) # google scholar

aid <- "vmuNN1sAAAAJ" # ID for Maya Mathur
pubs <- get_publications(aid, sortby="citation")

apply(pubs[1:10,], 1, function(z) 
  cat(z["title"], "-", z["journal"], ":\n", z["cites"], "\tpid:", 
      z["pubid"], "\n\n"))

pid <- "Y0pCki6q_DkC"
(cit <- get_article_cite_history(aid, pid))
(n <- sum(cit$cites))

## you'll have to create a profile
id <- scholar::get_scholar_id("Mathur", "Maya")

## I will mine as a demo
(id <- scholar::get_scholar_id("Solymos", "Peter"))
pid <- "l7t_Zn2s7bgC"
(cit <- get_article_cite_history(id, pid))
(n <- sum(cit$cites))

pubs <- get_publications(id, sortby="citation")

x <- read_yaml("../_data/publications_to_edit.yml")

with(u, plot(year, cumsum(cites), type="l"))

https://scholar.google.ca/citations?hl=en&user=PfC17QsAAAAJ&view_op=list_works&pagesize=100#d=gs_md_cita-d&u=%2Fcitations%3Fview_op%3Dview_citation%26hl%3Den%26user%3DPfC17QsAAAAJ%26pagesize%3D100%26citation_for_view%3DPfC17QsAAAAJ%3Al7t_Zn2s7bgC%26tzom%3D360

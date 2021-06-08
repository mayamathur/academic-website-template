library(scholar) # google scholar

# author ID for Maya Mathur
aid <- "vmuNN1sAAAAJ"

# pull publications sorted by citations or year
pubs <- get_publications(aid, sortby="citation", pagesize = 100)
#pubs <- get_publications(aid, sortby="year", pagesize = 100)

# print out some of the publications
# and copy-paste the IDs into the publications_to_edit.yml
apply(pubs[1:10,], 1, function(z) 
  cat(z["title"], "-", z["journal"], ":\n", z["cites"], "\tpid:", 
      z["pubid"], "\n\n"))

# get citation count for a given publication
pid <- "Y0pCki6q_DkC"
(cit <- get_article_cite_history(aid, pid))
(n <- sum(cit$cites))

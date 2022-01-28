library(scholar) # google scholar



# TEMPORARILY OVERWRITE SCHOLAR'S OWN FN 
get_article_cite_history = function (id, article) 
{
  site <- getOption("scholar_site")
  id <- tidy_id(id)
  url_base <- paste0(site, "/citations?", "view_op=view_citation&hl=en&citation_for_view=")
  url_tail <- paste(id, article, sep = ":")
  url <- paste0(url_base, url_tail)
  res <- get_scholar_resp(url)
  if (is.null(res)) 
    return(NA)
  httr::stop_for_status(res, "get user id / article information")
  doc <- read_html(res)
  years <- doc %>% html_nodes(".gsc_oci_g_t") %>% html_text() %>% 
    as.numeric()
  vals <- doc %>% html_nodes(".gsc_oci_g_al") %>% html_text() %>% 
    as.numeric()
  
  #@MM: Fix bug that happens when article has 0 citations from the most recent year(s)
  vals2 = rep(0, length(years))
  vals2[1:length(vals)] = vals
  vals = vals2
  
  df <- data.frame(year = years, cites = vals)
  if (nrow(df) > 0) {
    df <- merge(data.frame(year = min(years):max(years)), 
                df, all.x = TRUE)
    df[is.na(df)] <- 0
    df$pubid <- article
  }
  else {
    df$pubid <- vector(mode = mode(article))
  }
  return(df)
}



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

library(yaml) # read/write yaml
library(scholar) # google scholar
library(textreadr) #@MM added to fix error about not finding read_html


# TEMPORARILY OVERWRITE SCHOLAR'S OWN FN 
get_article_cite_history2 = function (id, article) 
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
  
  ###@MM: begin patch
  # happens when article has 0 citations in a given year
  # it's a known issue: https://github.com/jkeirstead/scholar/issues/102
  vals2 = rep(0, length(years))
  vals2[1:length(vals)] = vals
  vals = vals2
  ### end patch
  
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

# function to simplify queries
get_cites <- function(pid) {
  #@MM: using my own patched fn
  as.integer(sum(get_article_cite_history2(aid, pid)$cites))
}

# read in the yml file
x <- read_yaml("_data/publications_to_edit.yml")

# loop over the publications and add the google_cites field
for (i in seq_along(x)) {
  z <- c(x[[i]], google_cites=list(NULL))
  pid <- z$google_id
  if (!is.null(z$google_id)) {
    cat("  - getting citations for PID", z$google_id, "\n")
    z$google_cites <- get_cites(z$google_id)
  }
  x[[i]] <- z
}

# write publications with citation info
write_yaml(x, "_data/publications.yml")


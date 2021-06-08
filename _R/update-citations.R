library(yaml) # read/write yaml
library(scholar) # google scholar

# author ID for Maya Mathur
aid <- "vmuNN1sAAAAJ"

# function to simplify queries
get_cites <- function(pid) {
  as.integer(sum(get_article_cite_history(aid, pid)$cites))
}

# read in the yml file
x <- read_yaml("_data/publications_to_edit.yml")

# loop over the publications and add the google_cites field
for (i in seq_along(x)) {
  z <- c(x[[i]], google_cites=list(NULL))
  pid <- z$google_id
  if (!is.null(z$google_id)) {
    cat("\t- getting citations for PID", z$google_id, "\n")
    z$google_cites <- get_cites(z$google_id)
  }
  x[[i]] <- z
}

# write publications with citation info
write_yaml(x, "_data/publications.yml")


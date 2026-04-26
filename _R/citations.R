# when rate limited by google, spin up a VM and use docker:
# git clone https://github.com/psolymos/psolymos.github.io.git
# docker pull rocker/r2u:24.04
# docker run -v $(pwd)/psolymos.github.io:/psolymos.github.io -it rocker/r2u:24.04 bash
# cd psolymos.github.io
# start R and install.packages(c("yaml","scholar"))

library(scholar)
library(dplyr)
library(ggplot2)

id <- "PfC17QsAAAAJ"
y <- yaml::read_yaml("_data/papers_to_edit.yml")
pids <- sapply(y, function(x) {
    if (is.null(x$pubid)) NA_character_ else x$pubid
})
p0 <- get_publications(id)
p <- p0[!is.na(p0$pubid) & p0$pubid %in% pids, ]
sum(p$cites)
# ct <- get_citation_history(id)

# write the number of citations to the yaml file
for (j in 1:length(y)) {
    pid <- y[[j]][["pubid"]]
    if (!is.null(pid)) {
        y[[j]][["citations"]] <- as.integer(p$cites[p$pubid == pid])
    }
}
yaml::write_yaml(y, "_data/papers.yml")

cit <- NULL
for (i in 1:nrow(p)) {
    message(i)
    Sys.sleep(5)
    pid <- p$pubid[i]
    tmp <- get_article_cite_history(id, pid)
    cit <- rbind(cit, tmp)
}
write.csv(cit, "_data/citations.csv", row.names = FALSE)

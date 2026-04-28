# TODO
# - add labels to the publications in the yaml
# - e.g. software, statistics, birds, biodiversity, mollusca

library(scholar)
library(dplyr)
library(ggplot2)

id <- "PfC17QsAAAAJ"
y0 <- yaml::read_yaml("_data/papers.yml")
y <- yaml::read_yaml("_data/papers_to_edit.yml")
pids <- sapply(y, function(x) {
    if (is.null(x$pubid)) NA_character_ else x$pubid
})
p0 <- get_publications(id)
p <- p0[!is.na(p0$pubid) & p0$pubid %in% pids, ]
p$oldcites <- NA_real_
for (i in 1:nrow(p)) {
    for (j in 1:length(y0)) {
        if (!is.null(y0[[j]]$pubid) && y0[[j]]$pubid == p$pubid[i]) {
            p$oldcites[i] <- if (is.null(y0[[j]]$citations)) {
                0L
            } else {
                y0[[j]]$citations
            }
        }
    }
}
# new cites
sum(p$cites)
# old cites

# ct <- get_citation_history(id)

# write the number of citations to the yaml file
for (j in 1:length(y)) {
    pid <- y[[j]][["pubid"]]
    if (!is.null(pid)) {
        y[[j]][["citations"]] <- as.integer(p$cites[p$pubid == pid])
    }
}
yaml::write_yaml(y, "_data/papers.yml")

sum(p$oldcites)
if (any(p$cites != p$oldcites)) {
    k <- p$pubid[p$cites != p$oldcites]
}

# throttling requests to google scholar, 5 seconds between requests
cit <- NULL
for (i in 1:nrow(p)) {
    message(i)
    Sys.sleep(5)
    pid <- p$pubid[i]
    tmp <- get_article_cite_history(id, pid)
    cit <- rbind(cit, tmp)
}
# in case it failes, repeat in a day
for (pid in setdiff(p$pubid, cit$pubid)) {
    message(pid)
    Sys.sleep(5)
    tmp <- get_article_cite_history(id, pid)
    cit <- rbind(cit, tmp)
}
# TODO:
# only run this piece for pids where the cites changed since the last time
write.csv(cit, "_data/citations.csv", row.names = FALSE)

z <- read.csv("_data/citations.csv")

# plot publications over time
yr <- sort(sapply(y, "[[", "year"))
data.frame(year = yr, n = 1:length(yr)) %>%
    ggplot(aes(year, n)) +
    geom_line() +
    theme_bw()

# plot citations over time
z |>
    group_by(year) |>
    summarise(citations = sum(cites)) |>
    ggplot(aes(year, citations)) +
    geom_line() +
    theme_bw()

z |>
    group_by(year) |>
    summarise(citations = sum(cites)) |>
    mutate(citations = cumsum(citations)) |>
    ggplot(aes(year, citations)) +
    geom_line() +
    theme_bw()

data.frame(cites = rev(sort(p$cites)), id = 1:nrow(p))

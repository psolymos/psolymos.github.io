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
sum(p$oldcites)

# ct <- get_citation_history(id)

# write the number of citations to the yaml file
for (j in 1:length(y)) {
    pid <- y[[j]][["pubid"]]
    if (!is.null(pid)) {
        y[[j]][["citations"]] <- as.integer(p$cites[p$pubid == pid])
    }
}
yaml::write_yaml(y, "_data/papers.yml")

z <- read.csv("_data/citations.csv")
zl <- lapply(unique(z$pubid), function(pid) {
    z[z$pubid == pid, ]
})
names(zl) <- unique(z$pubid)
k <- union(p$pubid[p$cites != p$oldcites], z$pubid[!z$pubid %in% p$pubid])
for (i in seq_along(k)) {
    message(k[i])
    Sys.sleep(5)
    pid <- k[i]
    tmp <- get_article_cite_history(id, pid)
    zl[[pid]] <- tmp
}
zo <- do.call(rbind, zl)
sum(p$oldcites)
sum(p$cites)
sum(zo$cites)
sum(sapply(zl, function(x) sum(x$cites)))

ll <- sapply(zl, function(x) sum(x$cites))
cc <- data.frame(
    pid = p$pubid,
    old = p$oldcites,
    new = p$cites,
    list = ll[p$pubid]
)
cc <- cc[cc$new > 0, ]
cc[cc$new != cc$list, ]

write.csv(zo, "_data/citations.csv", row.names = FALSE)

## --- etc ---

z <- read.csv("_data/citations.csv")

# plot publications over time
cd <- data.frame(year = sapply(y, "[[", "year"))
cd$pubid <- sapply(y, function(x) {
    if (is.null(x$pubid)) "" else x$pubid
})
cd$birds <- sapply(y, function(x) {
    if (is.null(x$labels)) FALSE else "birds" %in% x$labels
})
cd$molluscs <- sapply(y, function(x) {
    if (is.null(x$labels)) FALSE else "molluscs" %in% x$labels
})
cd$software <- sapply(y, function(x) {
    if (is.null(x$labels)) FALSE else "software" %in% x$labels
})
cd <- cd |>
    arrange(year)
cd$n <- 1:nrow(cd)

p1 <- cd |>
    group_by(year) |>
    summarise(n = n()) |>
    ggplot(aes(year, n)) +
    geom_bar(stat = "identity") +
    theme_bw() +
    labs(x = "Year", y = "Number of publications")

p2 <- cd |>
    ggplot(aes(year, n)) +
    geom_step() +
    geom_step(
        data = data.frame(year = cd$year, n = cumsum(cd$molluscs)),
        color = "red"
    ) +
    geom_step(
        data = data.frame(year = cd$year, n = cumsum(!cd$molluscs)),
        color = "blue"
    ) +
    theme_bw() +
    labs(x = "Year", y = "Cumulative number of publications")

# plot citations over time
z2 <- data.frame(
    z,
    birds = cd$birds[match(z$pubid, cd$pubid)],
    molluscs = cd$molluscs[match(z$pubid, cd$pubid)],
    software = cd$software[match(z$pubid, cd$pubid)]
)

p3 <- z2 |>
    group_by(year) |>
    summarise(citations = sum(cites)) |>
    ggplot(aes(year, citations)) +
    geom_bar(stat = "identity") +
    theme_bw() +
    labs(x = "Year", y = "Number of citations")

p4 <- z2 |>
    mutate(
        birds = birds * cites,
        molluscs = molluscs * cites,
        not_molluscs = (!molluscs) * cites,
        software = software * cites
    ) |>
    group_by(year) |>
    summarise(
        citations = sum(cites),
        birds = sum(birds),
        molluscs = sum(molluscs),
        not_molluscs = sum(not_molluscs),
        software = sum(software)
    ) |>
    mutate(
        citations = cumsum(citations),
        birds = cumsum(birds),
        molluscs = cumsum(molluscs),
        not_molluscs = cumsum(not_molluscs),
        software = cumsum(software)
    ) |>
    ggplot(aes(year, citations)) +
    geom_step() +
    geom_step(
        aes(year, molluscs),
        color = "red"
    ) +
    geom_step(
        aes(year, not_molluscs),
        color = "blue"
    ) +
    theme_bw() +
    labs(x = "Year", y = "Cumulative number of citations")

# h-index
q <- data.frame(cites = rev(sort(p$cites)), id = 1:nrow(p))
ri <- which.min(abs(q$cites - q$id))
(h <- (q$id[ri] + q$cites[ri]) / 2)
p5 <- q |>
    ggplot(aes(id, cites)) +
    geom_step() +
    geom_vline(xintercept = h, linetype = "dashed") +
    geom_hline(yintercept = h, linetype = "dashed") +
    theme_bw() +
    labs(x = "Publication rank", y = "Citations")

ggsave(
    "images/publications/publications_over_time.png",
    p1,
    width = 5,
    height = 4
)
ggsave(
    "images/publications/cumulative_publications_over_time.png",
    p2,
    width = 5,
    height = 4
)
ggsave("images/publications/citations_over_time.png", p3, width = 5, height = 4)
ggsave(
    "images/publications/cumulative_citations_over_time.png",
    p4,
    width = 5,
    height = 4
)
ggsave("images/publications/h_index.png", p5, width = 5, height = 4)

library(tools)
getwd()
fl <- list.files("_posts", full.names = TRUE)
x <- lapply(fl, showNonASCIIfile)
names(x) <- fl
x[sapply(x, length) > 0]
q("no")


str.coded <- function(object, give.attr = FALSE, ...) {
  # TODO: properly handle arguments like give.head and pass ... on
  x <- object
  class(x) <- setdiff(class(x), "coded")
  cat("coded")
  str(x, give.attr = give.attr)
}

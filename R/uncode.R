
uncode <- function(x) {
  class(x) <- setdiff(class(x), "coded")
  attr(x, "code") <- NULL
  attr(x, "code_list") <- NULL
  x
}

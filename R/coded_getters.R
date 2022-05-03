
codes <- function(x, code_list = code_list(x)) {
  names(code_list)
}

code_list <- function(x) {
  attr(x, "code_list")
}

code <- function(x) {
  attr(x, "code")
}

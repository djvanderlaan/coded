
print.coded <- function(x, ...) {
  cat("<coded ('", code(x), "')>\n", sep = "")
  print(uncode(x))
}

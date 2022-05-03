
recode <- function(x, to, from = attr(x, "code"), 
    code_list = attr(x, "code_list"), as_coded = is.coded(x)) {
  # TODO check for NULL
  # allow from and to to be given as vectors and not just names in code_list
  # So instead of lcast(x, "a", "b", codes) you can also do 
  # lcast(x, codes$a, codes$b)
  if (length(to) > 1 && !missing(from) && length(from) > 1) {
    cds <- data.frame(from = from, to = to, stringAsFactors = FALSE)
    from <- "from"
    to <- "to"
  } else {
    cds <- code_list[, c(from, to)]
  }
  # Check to make sure that the mapping from from to to is proper. When values in
  # from are duplicated there is no unique mapping. When values in to are
  # duplicated this is ok; then we have a many to one mapping.
  cds <- unique(cds)
  stopifnot(!any(duplicated(cds[[from]])))
  # Map from from on to
  m <- match(x, cds[[from]])
  # Check if all records match, if not we have codes not present in code_list
  ok <- is.na(x) | !is.na(m)
  stopifnot(all(ok))
  y <- cds[[to]][m]
  if (as_coded) coded(y, code_list, to) else y
}



cguess <- function(x, code_list = attr(x, "code_list"), quality = 1, 
    stop_on_nomatch = TRUE) {
  # Determine to which column from code_list x has the most matches
  # Below we also count matches on NA as matches as columns in the code_list
  # can contain NA values. 
  fmatch <- sapply(code_list, function(c) {
    m <- match(x, c)
    sum(!is.na(m))/length(m)
  })
  best_match <- which.max(fmatch)
  nmatch <- sum(fmatch[best_match] == fmatch)
  # Determine how good the match is; difference to before is that we 
  # ignore missing values in x
  m <- match(x, code_list[[best_match]])
  fmatch_best <- sum(!is.na(m) | is.na(x))/length(m)
  if (fmatch_best >= quality) {
    if (nmatch > 1) {
      if (!stop_on_nomatch) return(NULL)
      stop("More than one column from code_list matches with values in x.")
    }
    names(code_list)[best_match]
  } else if (stop_on_nomatch) {
    stop("No match with enough quality could be found. ", 
      "Best quality = ", round(fmatch_best, 2), " needed ", quality, ".")
  } else {
    NULL
  }
}

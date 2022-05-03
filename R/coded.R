
coded <- function(x, code_list, code = head(names(code_list), 1)) {
  # TODO check if code is valid and if all values n x are in code_list
  structure(x, class=c("coded", class(x)), code_list = code_list, 
    code = code)
}

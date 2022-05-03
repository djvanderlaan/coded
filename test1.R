
files <- list.files(path = "R", pattern = "*.R", full.names = TRUE)
for (file in files) source(file)

codes <- data.frame(
  a = 1:4,
  b = letters[1:4],
  c = LETTERS[1:4],
  d = as.factor(paste0(letters[1:4], letters[1:4])),
  e = c("AA", NA, "CC", "DD"),
  f = c("ab" ,"ab", "cd", "cd")
)

x <- coded(c(1,2,4,3,3), codes)
y <- recode(x, "d")
y


cguess(y, codes)

codes_opl <- data.frame(
  code = c(11, 12, 13, 98, 99),
  label = c("lower", "middle", "higher", "not applicable", "not available")
)
codes_opl$label <- factor(codes_opl$label, levels = codes_opl$label)
dta <- data.frame(
  opl = coded(sample(codes_opl$code, 20, replace = TRUE), code_list = codes_opl)
)
table(recode(dta$opl, "label"), useNA = "ifany")

# How to handle missing values? 

# OPTION 1
codes_opl <- data.frame(
  code = c(11, 12, 13, 98, 99),
  label = c("lower", "middle", "higher", "not applicable", "not available")
  label_na = c("lower", "middle", "higher", NA, NA)
  
)
codes_opl$label <- factor(codes_opl$label, levels = codes_opl$label)
codes_opl$label_na <- factor(codes_opl$label, levels = codes_opl$label[1:3])
dta <- data.frame(
  opl = coded(sample(codes_opl$code, 20, replace = TRUE), code_list = codes_opl)
)
table(recode(dta$opl, "label"), useNA = "ifany")
table(recode(dta$opl, "label_na"), useNA = "ifany")

# OPTION 2
codes_opl <- data.frame(
  code = c(11, 12, 13, 98, 99),
  label = c("lower", "middle", "higher", "not applicable", "not available")
)
codes_opl$label <- factor(codes_opl$label, levels = codes_opl$label)
attr(codes_opl$code,  "missing_values") <- codes_opl$code[4:5]
attr(codes_opl$label, "missing_values") <- codes_opl$label[4:5]
dta <- data.frame(
  opl = coded(sample(codes_opl$code, 20, replace = TRUE), code_list = codes_opl)
)
recode2 <- function(x, to, from = attr(x, "code"), 
    code_list = attr(x, "code_list"), na = FALSE, ...) {
  r <- recode(x, to, from, code_list, ...)
  missing_values <- attr(code_list[[to]], "missing_values")
  if (na) {
    r[r %in% missing_values] <- NA
    if (is.factor(r)) r <- factor(r, levels = setdiff(levels(r), missing_values))
  }
  r
}
table(recode2(dta$opl, "label"), useNA = "ifany")
table(recode2(dta$opl, "label", na = TRUE), useNA = "ifany")


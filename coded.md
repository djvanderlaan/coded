

# Coded

Load the code

```{.R fun=output_eval}
files <- list.files(path = "R", pattern = "*.R", full.names = TRUE)
for (file in files) source(file)
```

The main object type is the `coded` object. This is an vector with two
additional attributes: `code_list` and `code`. 

Create an example code list: this should be a `data.frame` with multiple
columns. For example:
```{.R}
codes_opl <- data.frame(
  code = c(11, 12, 13, 98, 99),
  label = c("lower", "middle", "higher", "not applicable", "not available")
)
codes_opl$label <- factor(codes_opl$label, levels = codes_opl$label)
```

Create example `coded` object using this code list:

```{.R fun=output_eval}
x <- coded(sample(codes_opl[[1]], 10, replace = TRUE), codes_opl)
x
```

`x` is still a numeric vector, but with a few additional attributes:

```{.R fun=output_eval}
attributes(x)
```

Using this information we can recode `x` to one of the other columns from the
`code_list`:
```{.R fun=output_eval}
y <- recode(x, "label")
y
```

As the mapping from `code` on `label` is a one-to-one mapping we can also go
back:

```{.R fun=output_eval}
recode(y, "code")
```

We can also work with many-to-one mappings:


```{.R}
codes_opl <- data.frame(
  code = c(11, 12, 13, 98, 99),
  label = c("lower", "middle", "higher", "not applicable", "not available"),
  label2 = c("lower", "not-lower", "not-lower", NA, NA)
)
codes_opl$label <- factor(codes_opl$label, levels = codes_opl$label)
codes_opl$label2 <- factor(codes_opl$label2, levels = codes_opl$label2[1:2])
x <- coded(sample(codes_opl[[1]], 10, replace = TRUE), codes_opl)
x
y <- recode(x, "label2")
y
```

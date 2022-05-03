Coded
=====

Load the code

``` {.R}
> files <- list.files(path = "R", pattern = "*.R", full.names = TRUE)
> for (file in files) source(file)
```

The main object type is the `coded` object.

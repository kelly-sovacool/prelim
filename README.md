
<!-- README.md is generated from README.Rmd. Please edit that file -->

# prelim

<!-- badges: start -->

<!-- badges: end -->

|              |                          |                                |
| ------------ | ------------------------ | ------------------------------ |
| Abstract     | [PDF](docs/abstract.pdf) | [TeX](submission/abstract.tex) |
| Proposal     | [PDF](docs/proposal.pdf) | [TeX](submission/proposal.tex) |
| Presentation | \[HTML\]                 | \[Rmd\]                        |

## Dataset

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
metadata <- readxl::read_excel(here::here('data', 'GLNE07samples_baxter.xlsx'))
nrow(metadata)
#> [1] 757
metadata %>% 
    group_by(Diagnosis) %>% 
    summarize(n = n())
#> # A tibble: 6 x 2
#>   Diagnosis            n
#>   <chr>            <int>
#> 1 Adenoma            311
#> 2 Cancer             211
#> 3 High Risk Normal    64
#> 4 Normal             159
#> 5 Pending              7
#> 6 <NA>                 5

metadata %>%
    filter(Diagnosis != 'Pending', !is.na(Diagnosis)) %>% 
    mutate(Diagnosis = recode(Diagnosis,  
                              `High Risk Normal` = 'Normal')
           ) %>% 
    group_by(Diagnosis) %>% 
    summarize(n = n())
#> # A tibble: 3 x 2
#>   Diagnosis     n
#>   <chr>     <int>
#> 1 Adenoma     311
#> 2 Cancer      211
#> 3 Normal      223
```


<!-- README.md is generated from README.Rmd. Please edit that file -->

# Peak Set Enrichment analysis (PSEA)

<!-- badges: start -->
<!-- badges: end -->

The goal of PSEA is to test for enrichment in public peak set data using
preranked peak data as input.

For example ATACseq peak can be tested with `DiffBind` for differential
opening, and ranking metrics, such as log Fold change can be used. We
can then test for enrichment in opening (up) or closing (down) with
publicly available databases, eg
[LOLAcore](https://databio.org/regiondb) for epigenetic annotations or
[causalDB](http://www.mulinlab.org/causaldb/) for finemapped credible
intervals of disease loci derived from GWAS dataset.

PSEA returns a `gseResult` object that is compatible with `DOSE` package
routines.

## Installation

You can install the development version of PSEA from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("ImmuneAxisa/PSEA")
# install.packages("devtools")
devtools::install_github("ImmuneAxisa/PSEA")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(PSEA)
#> Loading required package: plyranges
#> Loading required package: BiocGenerics
#> 
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#> 
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#> 
#>     anyDuplicated, aperm, append, as.data.frame, basename, cbind,
#>     colnames, dirname, do.call, duplicated, eval, evalq, Filter, Find,
#>     get, grep, grepl, intersect, is.unsorted, lapply, Map, mapply,
#>     match, mget, order, paste, pmax, pmax.int, pmin, pmin.int,
#>     Position, rank, rbind, Reduce, rownames, sapply, setdiff, table,
#>     tapply, union, unique, unsplit, which.max, which.min
#> Loading required package: IRanges
#> Loading required package: S4Vectors
#> Loading required package: stats4
#> 
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#> 
#>     findMatches
#> The following objects are masked from 'package:base':
#> 
#>     expand.grid, I, unname
#> Loading required package: GenomicRanges
#> Loading required package: GenomeInfoDb
#> 
#> Attaching package: 'plyranges'
#> The following object is masked from 'package:IRanges':
#> 
#>     slice
#> The following object is masked from 'package:stats':
#> 
#>     filter
#> Loading required package: clusterProfiler
#> 
#> clusterProfiler v4.12.6 Learn more at https://yulab-smu.top/contribution-knowledge-mining/
#> 
#> Please cite:
#> 
#> T Wu, E Hu, S Xu, M Chen, P Guo, Z Dai, T Feng, L Zhou, W Tang, L Zhan,
#> X Fu, S Liu, X Bo, and G Yu. clusterProfiler 4.0: A universal
#> enrichment tool for interpreting omics data. The Innovation. 2021,
#> 2(3):100141
#> 
#> Attaching package: 'clusterProfiler'
#> The following object is masked from 'package:plyranges':
#> 
#>     n
#> The following object is masked from 'package:IRanges':
#> 
#>     slice
#> The following object is masked from 'package:S4Vectors':
#> 
#>     rename
#> The following object is masked from 'package:stats':
#> 
#>     filter
library(plyranges)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:plyranges':
#> 
#>     between, n, n_distinct
#> The following objects are masked from 'package:GenomicRanges':
#> 
#>     intersect, setdiff, union
#> The following object is masked from 'package:GenomeInfoDb':
#> 
#>     intersect
#> The following objects are masked from 'package:IRanges':
#> 
#>     collapse, desc, intersect, setdiff, slice, union
#> The following objects are masked from 'package:S4Vectors':
#> 
#>     first, intersect, rename, setdiff, setequal, union
#> The following objects are masked from 'package:BiocGenerics':
#> 
#>     combine, intersect, setdiff, union
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union

gr <- data.frame(
seqnames = "chr1",
start = seq(0,9999,100),
width = 30,
ranking_metric = -50:49
  ) %>%
  as_granges()

gr_set <- shift_right(gr, rep_len(c(20,50),100)) %>%
  mutate(term = "peakSet1")

psea(gr, ranking_metric, gr_set)
#> using 'fgsea' for GSEA analysis, please cite Korotkevich et al (2019).
#> preparing geneSet collections...
#> GSEA analysis...
#> no term enriched under specific pvalueCutoff...
#> #
#> # Gene Set Enrichment Analysis
#> #
#> #...@organism     UNKNOWN 
#> #...@setType      UNKNOWN 
#> #...@geneList     Named int [1:100] 49 48 47 46 45 44 43 42 41 40 ...
#>  - attr(*, "names")= chr [1:100] "chr1_9900_9929" "chr1_9800_9829" "chr1_9700_9729" "chr1_9600_9629" ...
#> #...nPerm     
#> #...pvalues adjusted by 'BH' with cutoff <0.05 
#> #...0 enriched terms found
#> 'data.frame':    0 obs. of  8 variables:
#>  $ ID             : chr 
#>  $ Description    : chr 
#>  $ setSize        : int 
#>  $ enrichmentScore: num 
#>  $ NES            : num 
#>  $ pvalue         : num 
#>  $ p.adjust       : num 
#>  $ qvalue         : logi 
#> #...Citation
#>  T Wu, E Hu, S Xu, M Chen, P Guo, Z Dai, T Feng, L Zhou, W Tang, L Zhan, X Fu, S Liu, X Bo, and G Yu.
#>  clusterProfiler 4.0: A universal enrichment tool for interpreting omics data.
#>  The Innovation. 2021, 2(3):100141
```

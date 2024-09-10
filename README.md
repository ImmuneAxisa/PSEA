# Peak Set Enrichment analysis (PSEA)

Test for enrichment in public peak set data using preranked peak data as input.

For example ATACseq peak can be tested with `DiffBind` for differential opening, and ranking metrics, such as log Fold change can be used. We can then test for enrichment in opening (up) or closing (down) with publicly available databases, eg [LOLAcore](https://databio.org/regiondb) for epigenetic annotations or [causalDB](http://www.mulinlab.org/causaldb/) for finemapped credible intervals of disease loci derived from GWAS dataset.

PSEA returns a `gseResult` object that is compatible with `DOSE` package routines.

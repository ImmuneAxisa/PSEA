# gr are a genomic ranges object with a peak ranking metric in meta data columns to use for enrichment
# gr_list is a genomic range object listing which range belong to which peak sets in column called "term"
# additional arguments passed to GSEA function
# returns a DOSE gseResult object that can take avantage of linked packages: clusterprofiler, enrichplot etc...
psea <- function(gr, rank_col, gr_set, ...) {
  
  require(tidyverse)
  require(DOSE)
  require(clusterProfiler)
  require(plyranges)
  
  peak_sets <- join_overlap_left(gr_set) %>%
    as.data.frame() %>%
    unite("gene", seqnames, start, end) %>% # confusing but it needs to be named gene for DOSE
    dplyr::filter(!is.na(term)) %>%
    dplyr::select(term, gene)
  
  ranked_vector <- gr_set %>%
    as.data.frame() %>%
    unite("gene", seqnames, start, end) %>%
    dplyr::select(gene, {{rank_col}}) %>%
    arrange(desc({{rank_col}})) %>%
    deframe %>%
    
  
  GSEA(ranked_vector, peak_sets, ...)
  
}
utils::globalVariables(c("seqnames", "start", "end", "term", "gene"))

#' Peak-Set Enrichment Analysis (PSEA)
#'
#' @param gr genomic ranges object with a peak ranking metric in meta data columns to use for enrichment
#' @param rank_col column to use in `gr` metadata for ranking
#' @param gr_set a genomic range object listing which range belong to which peak sets in column called "term"
#' @param ... passed to `plyranges::join_overlap_left`
#'
#' @return `gseResults` object
#' 
#' @importFrom dplyr select filter mutate desc
#' @importFrom magrittr %>%
#' @importFrom plyranges join_overlap_left
#' @importFrom tidyr unite
#' @importFrom tibble deframe
#' @importFrom clusterProfiler GSEA
#' 
#' @export
#'
#' @examples
#' 
#' 
#' library(plyranges)
#' library(dplyr)
#' 
#' gr <- data.frame(
#'   seqnames = "chr1",
#'   start = seq(0,9999,100),
#'   width = 30,
#'   ranking_metric = -50:49
#' ) %>%
#'   as_granges()
#' 
#' gr_set <- shift_right(gr, rep_len(c(20,50),100)) %>%
#'   mutate(term = "peakSet1")
#' 
#' psea(gr, ranking_metric, gr_set)
#' 
#' 
#' 
psea <- function(gr, rank_col, gr_set, ...) {

  
  peak_sets <- join_overlap_left(gr, gr_set, ...) %>%
    as.data.frame() %>%
    tidyr::unite("gene", seqnames, start, end) %>% # confusing but it needs to be named gene for clusterProfiler
    dplyr::filter(!is.na(term)) %>%
    dplyr::select(term, gene)
  
  ranked_vector <- gr %>%
    as.data.frame() %>%
    tidyr::unite("gene", seqnames, start, end) %>%
    dplyr::select(gene, {{rank_col}}) %>%
    dplyr::arrange(dplyr::desc({{rank_col}})) %>%
    tibble::deframe()
    
  
  GSEA(ranked_vector, TERM2GENE = peak_sets)
  
}
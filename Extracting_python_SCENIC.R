# Metadata extraction and saving
file <- "pasca_all_Preintegration.clustered.rda"
filename <- sub("\\..*$", "", file)

directory <- "/srv/scratch/voineagu/PROJECTS/EvaVo/DATA/Extracted Lancaster Pasca/"

load(file)
# ls()
metadata <- obj@meta.data
write.csv(metadata,
          paste0(directory, "metadata_",filename,".csv"),
          row.names = TRUE)

# Matrix, genes, cells conversion for python ------------------------------
library(Seurat)
library(Matrix)

# Matrix
counts <- GetAssayData(obj,
                       assay = "RNA",
                       layer = "counts")

writeMM(counts,paste0(directory, "counts_",filename,".mtx"))

# Genes
write.table(
  rownames(counts),
  paste0(directory,"genes_",filename,".tsv"),
  quote = FALSE,
  sep = "\t",
  row.names = FALSE,
  col.names = FALSE)

# Cells
write.table(
  colnames(counts),
  paste0(directory,"barcodes_",filename,".tsv"),
  quote = FALSE,
  sep = "\t",
  row.names = FALSE,
  col.names = FALSE
)
        
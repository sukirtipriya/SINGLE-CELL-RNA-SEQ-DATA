# script tp dempnstrate reading dingle cell matrices in various formats
# and converting to seurat object


#load libraries
library(seurat)
library(SeuratDisk)

# .RDS formats

rds <- readRDS("scarcoma_cell.rds")

# 10X CellRanger .HDF5 format

hdf5 <- Read10X_h5(filename ="scarcoma_cell_filtered_feature_bc_matrix.h5"
                   use.names = TRUE,
                   unique.features = TRUE)
                   
seurat_hdf5 <- CreateSeuratObject(counts = hdf5)


# .mtx file

matrix <- ReadMtx(mtx = "matrix.mtx.gz",
                  features = "features.tsv.gz",
                  cells = "barcodes.tsv.gz")
                  
seurat_mtx <- CreateSeuratObject(counts = matrix)

# .loom files
 
 loom <- Connect(filename ="bone_marrow.loom", mode = "r")
 seurat_loom <- as.Seurat(loom)
 
 # .h5ad format
 
 # 1. convert AnnData to an h5Seurat file
 
 Convert("anndata_download.h5ad", dest ="h5seurat", overwrite = TRUE)
 
 # 2. Load h5Seurat file into a seurat file
 
 seurat_file <- LoadH5Seurat("anndata_download.h5seurat")


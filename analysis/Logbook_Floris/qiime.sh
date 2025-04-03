# Test with QIIME2....


# Import your Nanopore fastq files into QIIME2
qiime tools import \
  --type 'SampleData[SequencesWithQuality]' \
  --input-path manifest.tsv \
  --output-path demux.qza \
  --input-format SingleEndFastqManifestPhred33V2

# Visualize the quality of your sequences
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv

# Denoise with DADA2 (optimized for Nanopore)
qiime dada2 denoise-pyro \
  --i-demultiplexed-seqs demux.qza \
  --p-trunc-len 0 \
  --p-trim-left 0 \
  --p-max-ee 2.0 \
  --o-representative-sequences rep-seqs.qza \
  --o-table table.qza \
  --o-denoising-stats stats.qza

# Generate feature table and rep-seqs summaries
qiime feature-table summarize \
  --i-table table.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file metadata.tsv

qiime feature-table tabulate-seqs \
  --i-data rep-seqs.qza \
  --o-visualization rep-seqs.qzv

# Taxonomic classification with a Nanopore-compatible classifier
qiime feature-classifier classify-sklearn \
  --i-classifier silva-138-ssu-nr99-classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv

# Generate a phylogenetic tree
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences rep-seqs.qza \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza

# Core diversity analysis
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table.qza \
  --p-sampling-depth 5000 \
  --m-metadata-file metadata.tsv \
  --output-dir core-metrics-results

# Alpha and beta diversity analysis
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file metadata.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file metadata.tsv \
  --m-metadata-column your_treatment_column \
  --o-visualization core-metrics-results/unweighted-unifrac-treatment-significance.qzv
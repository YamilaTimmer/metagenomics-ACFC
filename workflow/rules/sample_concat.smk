# This rule combines the already concatenated barcode fastq's into one per sample. The conbination can be changed in the config.yaml
rule combining_samples:
    input:
        lambda wildcards: expand(f"{OUT_DIR}/fastq/{{barcode}}.fastq.gz", barcode=config["sample_barcodes"][wildcards.sample])
    output:
        f"{OUT_DIR}/combined_fastq/{{sample}}.fastq"
    log:
        f"{LOG_DIR}/combining_samples/{{sample}}.log"
    shell:
        """
        cat {input} > {output} 2> {log}
        """

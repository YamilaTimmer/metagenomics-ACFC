# This rule concatenates the barcode directories from the config.yaml into one file per barcode dir.
rule barcode_concatenation:
    input:
        lambda wildcards: glob.glob(config["BARCODE_DIRECTORIES"][wildcards.barcode] + "/*")
    output:
        f"{OUT_DIR}/fastq/{{barcode}}.fastq.gz"
    log:
        f"{LOG_DIR}/cat/{{barcode}}.log"
    shell:
        """
        cat {input} > {output} 2> {log}
        """

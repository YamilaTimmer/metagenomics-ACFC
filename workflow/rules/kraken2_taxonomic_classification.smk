rule kraken2_taxonomic_classification:
    input:
        reads=rules.fastq_qc_plong.output.trimmed_fastq
    output:
        kraken_report=f"{OUT_DIR}/kraken2/reports/{{sample}}_report.txt",
        output=f"{OUT_DIR}/kraken2/output/{{sample}}_output.txt"
    log:
        f"{LOG_DIR}/kraken2/{{sample}}.log"
    params:
        db=f"{config['kraken2_db_dir']}/16S_Greengenes/",
        confidence="0.1",
        threads=64
    conda:
        workflow.source_path("../envs/kraken2.yaml")
    shell:
        """
        kraken2
            --db {params.db} \
            --threads {params.threads} \
            --confidence {params.confidence} \
            --output {output.output} \
            --report {output.kraken_report} \
            {input.reads} 2> {log}
        """

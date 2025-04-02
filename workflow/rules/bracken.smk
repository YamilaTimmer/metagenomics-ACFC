rule bracken:
    input:
        kraken_report=rules.kraken2_taxonomic_classification.output.kraken_report,
        kraken_database=f"{config['kraken2_db_dir']}/16S_Greengenes"
    output:
        bracken_report=f"{OUT_DIR}/bracken/reports/{{sample}}.txt",
        bracken_output=f"{OUT_DIR}/bracken/output/{{sample}}.out"
    params:
        read_length=150,
        threshold=10,
        level="G"
    log:
        f"{LOG_DIR}/bracken/{{sample}}.log"
    threads:
        32
    conda:
        workflow.source_path("../envs/bracken.yaml")
    shell:
        """
        bracken \
            -d {input.kraken_database} \
            -i {input.kraken_report} \
            -o {output.bracken_output} \
            -w {output.bracken_report} \
            -r {params.read_length} \
            -t {params.threshold} \
            -l {params.level} \
        2> {log}
        """

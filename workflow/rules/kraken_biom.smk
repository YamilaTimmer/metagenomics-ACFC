rule kraken_biom:
    input:
        bracken_kraken=rules.bracken.output.bracken_report
    output:
        biom_files=f"{OUT_DIR}/kraken_biom/{{sample}}_output.biom"
    log:
        f"{LOG_DIR}/kraken_biom/{{sample}}.log"
    conda:
        workflow.source_path("../envs/kraken_biom.yaml")
    shell:
        """
        kraken-biom \
            {input} \
            -o {output} \
            --fmt json \
        2> {log}
        """

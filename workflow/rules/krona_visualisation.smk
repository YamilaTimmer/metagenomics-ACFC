# Visualize taxonomic diversity in Kraken report as Krona pie chart 
rule krona_visualisation:
    input:
        bracken_files=rules.bracken.output.bracken_report
    output:
        krona_vis=f"{RESULTS_DIR}/krona/{{sample}}_krona.html"
    log:
        f"{LOG_DIR}/krona/{{sample}}.log"
    conda:
        workflow.source_path("../envs/krona.yaml")
    shell:
        """
        ktUpdateTaxonomy.sh
        ktImportTaxonomy \
            -t 5 \
            -m 3 \
            {input} \
            -o {output} \
        2> {log}
        """

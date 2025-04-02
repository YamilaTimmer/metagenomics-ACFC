rule calculate_alpha_diversity:
    input:
        kraken_report=rules.kraken2_taxonomic_classification.output.kraken_report
    output:
        html = f"{RESULTS_DIR}/sankey/{{sample}}.html"
    params:
        shannon_index="Sh"
    shell:
        """
        python scripts/alpha_diversity.py
            -f {input}
            -a {params.shannon_index}
        > {output}
        """

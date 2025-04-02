rule calculate_alpha_diversity:
    input:
        kraken_report=f"{OUT_DIR}/kraken2/output/{{sample}}_output.txt"

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

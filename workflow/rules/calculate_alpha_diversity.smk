rule alpha_diversity:
    input:
        kraken_file=rules.kraken2_taxonomic_classification.output.kraken_report
    output:
        "results/alpha/{sample}_alpha.txt"
    params:
        shannon_index="Sh"
    shell:
        """
        python scripts/alpha_diversity.py
            -f {input}
            -a {params.shannon_index}
        > {output}
        """

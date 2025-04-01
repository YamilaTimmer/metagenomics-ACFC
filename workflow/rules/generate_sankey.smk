rule generate_sankey:
    input:
        kraken_file=rules.kraken2_taxonomic_classification.output.kraken_report
    output:
        html="results/sankey/{sample}.html"
    script:
        workflow.source_path("../scripts/kraken_to_sankey.py")

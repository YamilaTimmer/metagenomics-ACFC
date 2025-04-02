rule generate_sankey:
    input:
        kraken_report=rules.kraken2_taxonomic_classification.output.kraken_report
    output:
        html = f"{RESULTS_DIR}/sankey/{{sample}}.html"
    script:
        workflow.source_path("../scripts/kraken_to_sankey.py")

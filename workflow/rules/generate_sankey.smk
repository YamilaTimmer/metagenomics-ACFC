rule generate_sankey:
    input:
        kraken_report = f"{OUT_DIR}/kraken2/reports/{{sample}}_report.txt"
    output:
        html = f"{RESULTS_DIR}/sankey/{{sample}}.html"
    script:
        workflow.source_path("../scripts/kraken_to_sankey.py")

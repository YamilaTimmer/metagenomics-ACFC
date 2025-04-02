rule calculate_beta_diversity:
    input:
        sample1=f"{OUT_DIR}/kraken2/output/{{sample1}}_output.txt",
        sample2=f"{OUT_DIR}/kraken2/output/{{sample2}}_output.txt"
    output:
        f"{RESULTS_DIR}/beta/{{sample1}}_vs_{{sample2}}.txt"
    params:
        sample_type="kreport2"
    shell:
        """
        python scripts/beta_diversity.py
            -i {input.sample1} {input.sample2}
            --type {params.sample_type}
            --level G
        > {output}
        """

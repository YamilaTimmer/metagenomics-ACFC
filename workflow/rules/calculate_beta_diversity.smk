rule beta_diversity:
    input:
        sample1 = f"{OUT_DIR}/bracken/output/{{sample1}}.out",
        sample2 = f"{OUT_DIR}/bracken/output/{{sample2}}.out"
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

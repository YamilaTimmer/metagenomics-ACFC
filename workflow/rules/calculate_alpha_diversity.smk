# using bracken out file and a python script that uses a formula( in this case the shannon index formula) the alpha diversity gets calculated.

rule calculate_alpha_diversity:
    input:
        kraken_report=rules.bracken.output.bracken_output
    output:
        alpha_diversity=f"{RESULTS_DIR}/alpha/{{sample}}_alpha.txt"
    params:
        shannon_index="Sh"
    shell:
        """
        python scripts/alpha_diversity.py \
            -f {input} \
            -a {params.shannon_index} \
        > {output}
        """

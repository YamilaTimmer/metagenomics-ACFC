# Estimate abundances of pathways based on OTU abundance as found in Kraken2 reports
rule faprotax:
    input:
        biom_files=rules.kraken_biom.output.biom_files
    output:
        function_table=f"{RESULTS_DIR}/faprotax/{{sample}}/{{sample}}_function_table.tsv",
        faprotax_report=f"{OUT_DIR}/faprotax/{{sample}}/{{sample}}_report.txt",
        groups_to_records=f"{OUT_DIR}/faprotax/{{sample}}/group_table.txt",
        sub_table_dir=directory(f"{RESULTS_DIR}/faprotax/{{sample}}/sub_groups/")
    log:
        f"{LOG_DIR}/faprotax/{{sample}}.log"
    conda:
        workflow.source_path("../envs/faprotax.yaml")
    shell:
        """
        python3 {TOOLS_DIR}/FAPROTAX_1.2.10/collapse_table.py \
            -i {input.biom_files} \
            -o {output.function_table} \
            -g {TOOLS_DIR}/FAPROTAX_1.2.10/FAPROTAX.txt \
            -n columns_after_collapsing \
            --collapse_by_metadata "taxonomy" \
            --out_sub_tables_dir {output.sub_table_dir} \
            --out_groups2records_table {output.groups_to_records} \
            --out_report {output.faprotax_report} \
            -v \
            2> {log}
        """

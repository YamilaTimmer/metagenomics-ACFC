rule faprotax:
    input:
        biom_files=rules.kraken_biom.output.biom_files
    output:
        function_table=f"{OUT_DIR}/faprotax/{{sample}}/{{sample}}_function_table.tsv",
        faprotax_report=f"{OUT_DIR}/faprotax/{{sample}}/{{sample}}_report.txt",
        sub_table_dir=directory(f"{OUT_DIR}/faprotax/{{sample}}/sub_groups/"),
        groups_to_records=f"{OUT_DIR}/faprotax/{{sample}}/group_table.txt"
    log:
        f"{LOG_DIR}/faprotax/{{sample}}.log"
    shell:
        """
        python3 tools/FAPROTAX_1.2.10/collapse_table.py \
            -i {input.biom_files} \
            -o {output.function_table} \
            -g tools/FAPROTAX_1.2.10/FAPROTAX.txt \
            -n columns_after_collapsing \
            --collapse_by_metadata "taxonomy" \
            --out_sub_tables_dir {output.sub_table_dir} \
            --out_groups2records_table {output.groups_to_records} \
            --out_report {output.faprotax_report} \
            -v \
            2> {log}
        """

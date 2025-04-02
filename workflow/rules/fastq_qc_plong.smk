rule fastq_qc_plong:
    input:
        sample_data=f"{DATA_DIR}/{{sample}}.fastq.gz"
    output:
        trimmed_fastq=f"{OUT_DIR}/trimmed/{{sample}}.fastq",
        html=f"{OUT_DIR}/QC/{{sample}}_fastplong_QC.html"
    log:
        f"{LOG_DIR}/QC/{{sample}}.log"
    shell:
        """
        {TOOLS_DIR}/fastplong \
            -i {input.sample_data} \
            -o {output.trimmed_fastq} \
            -h {output.html} \
            2> {log}
        """

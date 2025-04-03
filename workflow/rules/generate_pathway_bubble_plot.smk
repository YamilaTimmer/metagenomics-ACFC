rule generate_pathway_bubble_plot:
    input:
        sample1=f"{OUT_DIR}/faprotax/{{sample1}}/{{sample1}}_function_table.tsv",
        sample2=f"{OUT_DIR}/faprotax/{{sample2}}/{{sample2}}_function_table.tsv"
    output:
        bubble_plot_pdf=f"{RESULTS_DIR}/pathway_bubble_plot/{{sample1}}_{{sample2}}.pdf",
        heatmap_pdf=f"{RESULTS_DIR}/pathway_heatmap/{{sample1}}_{{sample2}}_pathway_heatmap.pdf",
    log:
        f"{LOG_DIR}/generate_pathway_bubble_plots/{{sample1}}_{{sample2}}.log"
    params:
        script=workflow.source_path("../scripts/bubble_chart.r")
    shell:
        """
        Rscript \
            {params.script} \
            {input.sample1} \
            {input.sample2} \
            {output.bubble_plot_pdf} \
            {output.heatmap_pdf} \
        2> {log}
        """

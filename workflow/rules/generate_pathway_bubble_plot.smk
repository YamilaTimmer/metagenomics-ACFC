rule generate_pathway_bubble_plot:
    input:
        rules.faprotax.output.faprotax_report
    output:
        bubble_plot_pdf=f"{RESULTS_DIR}/pathway_bubble_plot/{{sample}}.pdf",
        heatmap_pdf=f"{RESULTS_DIR}/pathway_heatmap/{{sample}}_pathway_heatmap.pdf",
    log:
        f"{LOG_DIR}/generate_pathway_bubble_plots/{{sample}}.log"
    params:
        script = "scripts/bubble_chart.r"
    shell:
        """
        Rscript {params.script} \
            {input.in_lagoon} \
            {input.out_lagoon} \
            {output.bubble_plot} \
            {output.heatmap} \
            2> {log}
        """

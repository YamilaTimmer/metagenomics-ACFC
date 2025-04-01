library(tidyverse)
library(ggplot2)
library(reshape2)


faprotax_out_lagoon <- read.table("~/Documenten/Data_set/ACFC_Wastewater_Metagenomics/faprotax/out_lagoon/out_lagoon_function_table.tsv", header = TRUE, sep = "\t", row.names = 1)
faprotax_in_lagoon <- read.table("~/Documenten/Data_set/ACFC_Wastewater_Metagenomics/faprotax/in_lagoon/in_lagoon_function_table.tsv", header = TRUE, sep = "\t", row.names = 1)

args = commandArgs(trailingOnly=TRUE)

in_lagoon_file <- args[1]
out_lagoon_file <- args[2]
bubble_plot_output <- args[3]
heatmap_output <- args[4]

# Combine the data
combination_in_out_lagoon <- data.frame(cbind(faprotax_out_lagoon, faprotax_in_lagoon))

data_long <- combination_in_out_lagoon %>% # Make it into long format for the plot.
    rownames_to_column("Pathway") %>%
    pivot_longer(cols = -Pathway, 
                      names_to = "Sample", 
                      values_to = "Abundance")

# Filter the 0 values
data_long <- data_long[data_long$Abundance > 0, ]

bubble_plot <- ggplot(data_long, aes(x = Sample, y = Pathway, size = Abundance)) +
    geom_point(aes(color=Sample)) +
    scale_size(range = c(1, 15), name = "Abundance") +
    theme_minimal() +
    labs(title = "Amount of pathways for the samples:", x = "Sample", y = "Pathway")

ggsave(bubble_plot_output, bubble_plot, width = 14, height = 20)

heatmap_plot <- ggplot(data_long, aes(x = Sample, y = Pathway, fill = Abundance)) +
    geom_tile() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Amount of pathways for the samples:", x = "Sample", y = "Pathway") +
    theme_minimal()

ggsave(heatmap_output, heatmap_plot, width = 14, height = 20)
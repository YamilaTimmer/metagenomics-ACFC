import pandas as pd
import plotly.graph_objects as go

def parse_kraken(file_path):
    """Parse indentation-based Kraken file into nodes and links"""
    df = pd.read_csv(file_path, sep="\t", header=None,
                     names=["percent", "reads", "direct_reads", "rank", "taxID", "name"])
    
    nodes = []
    links = []
    hierarchy = []  # Track last parent at each depth
    
    for idx, row in df.iterrows():
        name = row["name"].lstrip()
        depth = (len(row["name"]) - len(name)) // 2
        node_id = len(nodes)
        nodes.append({"name": name, "depth": depth})
        
        if depth > 0:
            parent_id = hierarchy[depth-1]
            links.append({
                "source": parent_id,
                "target": node_id,
                "value": row["reads"]
            })
        
        # Update hierarchy tracking
        if depth >= len(hierarchy):
            hierarchy.append(node_id)
        else:
            hierarchy[depth] = node_id
    
    return pd.DataFrame(nodes), pd.DataFrame(links)

# Snakemake integration
if __name__ == "__main__":
    # Get input/output paths from Snakemake
    input_file = snakemake.input[0]
    output_file = snakemake.output[0]
    
    # Generate the Sankey chart
    nodes_df, links_df = parse_kraken(input_file)
    
    fig = go.Figure(go.Sankey(
        node=dict(
            label=nodes_df["name"],
            pad=15,
            thickness=20
        ),
        link=dict(
            source=links_df["source"],
            target=links_df["target"],
            value=links_df["value"]
        )
    ))
    
    fig.update_layout(title="Taxonomic Sankey Chart", font_size=10)
    fig.write_html(output_file)
# Social Network Analysis with R — Lab Submission

## Files
- `social_network_analysis.R` — complete, ready-to-run R script
- `social_network_edges.csv` — sample dataset (edge list: from, to, weight)

## How to Run
1. Open RStudio.
2. Put both files in the same working directory (or use `setwd()`).
3. Open `social_network_analysis.R` and click **Source** (or run line by line).
4. On first run, required packages (`igraph`, `ggraph`, `ggplot2`, `dplyr`,
   `RColorBrewer`) will auto-install if missing.
5. Outputs generated after running:
   - `network_measures.csv` — degree, betweenness, closeness, eigenvector
     centrality for every node
   - `network_plot_base.png` — base igraph network diagram
   - `network_plot_ggraph.png` — polished ggraph visualization
   - `degree_distribution.png` — bar chart of node degrees
   - Console output with the full interpretation summary

## Using Your Own Dataset
Replace `social_network_edges.csv` with your own edge list using the same
three columns (`from`, `to`, `weight`), or point `read.csv()` at a different
file. The rest of the script works unchanged for any undirected weighted
network.

## What Each Network Measure Means
| Measure | What it tells you |
|---|---|
| **Degree** | How many direct connections a node has — raw popularity/activity |
| **Betweenness** | How often a node sits on the shortest path between others — identifies brokers/bridges connecting different parts of the network |
| **Closeness** | How quickly a node can reach everyone else — identifies efficient spreaders of information |
| **Eigenvector centrality** | Influence weighted by the importance of one's connections — "well-connected to the well-connected" |
| **Community detection (Louvain)** | Groups nodes into clusters that interact more with each other than with the rest of the network |


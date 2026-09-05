## ============================================================
## SOCIAL NETWORK ANALYSIS WITH R
## Lab: Representing, Analyzing, and Visualizing a Social Network
## ============================================================
## This script:
##   1. Loads/installs required packages
##   2. Imports network data (edge list)
##   3. Builds a graph object (nodes + edges)
##   4. Computes key network measures (degree, betweenness,
##      closeness, eigenvector centrality, density, diameter)
##   5. Detects communities
##   6. Visualizes the network
##   7. Identifies the most influential nodes
##   8. Exports results and plots for the report
## ============================================================


## ------------------------------------------------------------
## 1. SETUP: Install & load required packages
## ------------------------------------------------------------
required_packages <- c("igraph", "ggraph", "ggplot2", "dplyr", "RColorBrewer")

new_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(new_packages) > 0) install.packages(new_packages, dependencies = TRUE)

library(igraph)
library(ggraph)
library(ggplot2)
library(dplyr)
library(RColorBrewer)

set.seed(42)  # for reproducible layouts/community detection


## ------------------------------------------------------------
## 2. IMPORT DATA
## ------------------------------------------------------------
## Edge list: from, to, weight  (weight = strength/frequency of interaction)
## Replace this path with your own dataset if required.
edges <- read.csv("social_network_edges.csv", stringsAsFactors = FALSE)

head(edges)
cat("Number of edges in raw data:", nrow(edges), "\n")


## ------------------------------------------------------------
## 3. BUILD THE NETWORK (GRAPH OBJECT)
## ------------------------------------------------------------
## Nodes  = individuals (Aarav, Bhavya, ...)
## Edges  = interactions/friendships between individuals
g <- graph_from_data_frame(d = edges, directed = FALSE)

cat("\n--- BASIC NETWORK SUMMARY ---\n")
cat("Number of nodes (vertices):", vcount(g), "\n")
cat("Number of edges:", ecount(g), "\n")
cat("Network density:", round(edge_density(g), 4), "\n")
cat("Is the network connected?", is_connected(g), "\n")
cat("Network diameter:", diameter(g, weights = NA), "\n")
cat("Average path length:", round(mean_distance(g), 3), "\n")


## ------------------------------------------------------------
## 4. NETWORK MEASURES / CENTRALITY ANALYSIS
## ------------------------------------------------------------

## 4.1 Degree centrality — number of direct connections
deg <- degree(g)

## 4.2 Betweenness centrality — how often a node lies on shortest paths
##     (identifies "bridge"/broker nodes connecting different parts of network)
betw <- betweenness(g, weights = NA)

## 4.3 Closeness centrality — how close a node is to all others
##     (identifies nodes that can spread information fastest)
close <- closeness(g)

## 4.4 Eigenvector centrality — influence based on connections to
##     other well-connected nodes
eig <- eigen_centrality(g)$vector

## Combine all measures into a single results table
network_measures <- data.frame(
  Node             = names(deg),
  Degree           = deg,
  Betweenness      = round(betw, 2),
  Closeness        = round(close, 4),
  EigenCentrality  = round(eig, 4)
) %>% arrange(desc(Degree))

cat("\n--- NETWORK MEASURES (sorted by Degree) ---\n")
print(network_measures)

write.csv(network_measures, "network_measures.csv", row.names = FALSE)


## ------------------------------------------------------------
## 5. IDENTIFY INFLUENTIAL / IMPORTANT NODES
## ------------------------------------------------------------
top_degree      <- network_measures %>% arrange(desc(Degree)) %>% head(3)
top_betweenness <- network_measures %>% arrange(desc(Betweenness)) %>% head(3)
top_eigen       <- network_measures %>% arrange(desc(EigenCentrality)) %>% head(3)

cat("\n--- TOP 3 NODES BY DEGREE (most directly connected) ---\n")
print(top_degree[, c("Node", "Degree")])

cat("\n--- TOP 3 NODES BY BETWEENNESS (key connectors / brokers) ---\n")
print(top_betweenness[, c("Node", "Betweenness")])

cat("\n--- TOP 3 NODES BY EIGENVECTOR CENTRALITY (most influential) ---\n")
print(top_eigen[, c("Node", "EigenCentrality")])


## ------------------------------------------------------------
## 6. COMMUNITY DETECTION
## ------------------------------------------------------------
## Finds tightly-knit clusters/sub-groups within the network
communities <- cluster_louvain(g)

cat("\n--- COMMUNITY DETECTION ---\n")
cat("Number of communities detected:", length(communities), "\n")
cat("Modularity score:", round(modularity(communities), 4), "\n")
print(membership(communities))


## ------------------------------------------------------------
## 7. VISUALIZATION
## ------------------------------------------------------------

## 7.1 Base igraph plot: node size ~ degree, color ~ community
V(g)$degree    <- deg
V(g)$community <- membership(communities)

png("network_plot_base.png", width = 1000, height = 800, res = 120)
plot(
  g,
  vertex.size        = V(g)$degree * 4 + 10,
  vertex.label.cex   = 0.8,
  vertex.label.color = "black",
  vertex.color       = brewer.pal(max(V(g)$community, 3), "Set2")[V(g)$community],
  edge.width         = E(g)$weight / 1.5,
  edge.color         = "grey70",
  layout             = layout_with_fr(g),
  main               = "Social Network: Node size = Degree, Color = Community"
)
dev.off()

## 7.2 Polished ggraph visualization
p <- ggraph(g, layout = "fr") +
  geom_edge_link(aes(width = weight), alpha = 0.4, colour = "grey50") +
  geom_node_point(aes(size = degree, colour = as.factor(community))) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3.5) +
  scale_edge_width(range = c(0.3, 2)) +
  labs(
    title    = "Social Network Analysis",
    subtitle = "Node size = Degree centrality | Colour = Detected community",
    colour   = "Community",
    size     = "Degree"
  ) +
  theme_void()

ggsave("network_plot_ggraph.png", plot = p, width = 9, height = 7, dpi = 150)

## 7.3 Degree distribution plot (helps explain network structure)
degree_df <- data.frame(Node = names(deg), Degree = deg)

p2 <- ggplot(degree_df, aes(x = reorder(Node, -Degree), y = Degree)) +
  geom_col(fill = "steelblue") +
  labs(title = "Degree Distribution", x = "Node", y = "Degree (Number of Connections)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("degree_distribution.png", plot = p2, width = 8, height = 5, dpi = 150)

cat("\nPlots saved: network_plot_base.png, network_plot_ggraph.png, degree_distribution.png\n")


## ------------------------------------------------------------
## 8. INTERPRETATION (auto-generated summary using computed results)
## ------------------------------------------------------------
most_connected   <- top_degree$Node[1]
key_broker       <- top_betweenness$Node[1]
most_influential <- top_eigen$Node[1]

cat("\n============================================================\n")
cat("INTERPRETATION OF RESULTS\n")
cat("============================================================\n")
cat(sprintf("- The network has %d nodes and %d edges, with a density of %.3f,\n",
            vcount(g), ecount(g), edge_density(g)))
cat("  indicating how tightly the group is interconnected.\n")
cat(sprintf("- '%s' has the highest degree, making them the most directly\n", most_connected))
cat("  connected member of the network (a 'hub').\n")
cat(sprintf("- '%s' has the highest betweenness centrality, meaning they act\n", key_broker))
cat("  as a key bridge/broker linking otherwise separate parts of the network.\n")
cat(sprintf("- '%s' has the highest eigenvector centrality, indicating they are\n", most_influential))
cat("  connected to other well-connected/important members, making them\n")
cat("  the most 'influential' node overall.\n")
cat(sprintf("- %d distinct communities were detected (modularity = %.3f),\n",
            length(communities), modularity(communities)))
cat("  suggesting the presence of sub-groups/cliques within the larger network.\n")
cat("============================================================\n")

## ------------------------------------------------------------
## END OF SCRIPT
## ------------------------------------------------------------

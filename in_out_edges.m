function [ in_edges, in_edges_complement, out_edges, d ] = in_out_edges( node_id, cluster, struct, weighted )

    %node_id: is the node id based on adjacency unique ids
    %cluster: the node ids of the cluster in array
    %struct: contains the adjacency of the network, the unique proteins and
            %the degree of the nodes
    
    %the adjacency must be symmetric
    all_nodes_ids = 1:length(struct.unique_proteins);
    
    if ~weighted,
        small_adj = struct.adjacency_matrix_binary(node_id, cluster);
        in_edges = sum(small_adj);
        in_edges_complement = length(small_adj) - sum(small_adj);
        nodes_out_cluster = setdiff(all_nodes_ids,cluster);
        out_edges = sum(struct.adjacency_matrix_binary(node_id, nodes_out_cluster));
        d = length(find(small_adj ~= 0));
    else
        small_adj = struct.adjacency_matrix_weighted(node_id, cluster);
        in_edges = sum(small_adj);
        in_edges_complement = length(small_adj) - sum(small_adj);
        nodes_out_cluster = setdiff(all_nodes_ids,cluster);
        out_edges = sum(struct.adjacency_matrix_weighted(node_id, nodes_out_cluster));        
        d = length(find(small_adj ~= 0));
    end
    
end

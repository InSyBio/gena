function [ all_nei ] = find_neighbors_many_nodes( adjacency, node_ids )

    all_nei = [];

    for i = 1:length(node_ids),

        neighbors = find(adjacency(node_ids(i),:) ~= 0);
        all_nei = [all_nei neighbors];
        
    end
    
    all_nei = unique(all_nei);
    all_nei = setdiff(all_nei, node_ids);
    
end

function [ struct ] = clustering_coefficient_neighbors( struct )


    for i = 1:length(struct.unique_proteins),
        
        %disp(i)
        
        nei = find(struct.adjacency_matrix_binary(i,:) ~= 0);
        nei = unique([nei i]);
        
        struct.clustering_coefficient_nei(i) = mean(struct.clustering_coefficient(nei));
        
    end


end

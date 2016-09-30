function [ new_clusters, density ] = filter_density( clusters, struct, threshold, is_name )

    network = struct.adjacency_matrix_binary;
    network(logical(eye(size(network)))) = 0;
    cc=1;
    new_clusters = {};
    for i = 1:length(clusters),
        mylen = length(clusters{i});
        if is_name,
            myposs = find(ismember(struct.unique_proteins,clusters{i}));        
            nom = sum(sum(network(myposs,myposs)))/2;
        else
            nom = sum(sum(network(clusters{i},clusters{i})))/2;
        end
        denom = (mylen*(mylen-1))/2;        
        density(i) = nom/denom;
        
        if density(i) >= threshold,
            new_clusters{cc} = clusters{i};
            cc=cc+1;
        end
    end

end

function [ neighbors ] = find_neighbors( adjacency, node_id )

    neighbors = find(adjacency(node_id,:) ~= 0);

end

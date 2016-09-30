function [ current_cluster, current_eval ] = find_cluster( node_id, neighbors, struct, nodes_num, naive_or_scaled, fidout, weighted, eval_type )

% the input is the initial node_id and its neighbors
% the input is augmented until you get output

% the first node to be chosen is by default the one with lowest degree
nei_degrees = struct.degree(neighbors);
[~, pos] = min(nei_degrees);
second_node_id = neighbors(pos);
current_cluster = [node_id second_node_id];
current_nei = find_neighbors_many_nodes( struct.adjacency_matrix_binary, current_cluster );
current_eval = find_cluster_eval(current_cluster, struct, nodes_num, naive_or_scaled, weighted, eval_type);
%current_cluster
%fprintf(fidout,'current_cluster\t'); fprintf(fidout,num2str(current_cluster)); fprintf(fidout,'\t');
nodes_counter = 0;

while (nodes_counter < 20),
    %disp(nodes_counter)
    best_eval = 1000000; node_chosen = 0;
    for i = 1:length(current_nei),
        temp_cluster = [current_cluster current_nei(i)];
        running_eval = find_cluster_eval(temp_cluster, struct, nodes_num, naive_or_scaled, weighted, eval_type);
        if running_eval < best_eval,
            best_eval = running_eval;
            node_chosen = current_nei(i);
        end
    end
    
    %fprintf(fidout,'node_chosen\t'); fprintf(fidout,num2str(node_chosen)); fprintf(fidout,'\t');
    %fprintf(fidout,'best_eval\t'); fprintf(fidout,num2str(best_eval)); fprintf(fidout,'\t');
    %fprintf(fidout,'current_eval\t'); fprintf(fidout,num2str(current_eval)); fprintf(fidout,'\t');

    if current_eval < best_eval, %this changes based on the evaluation criteria 
        break;
    else
        current_cluster = [current_cluster node_chosen];
        %fprintf(fidout,'current_cluster\t'); fprintf(fidout,num2str(current_cluster)); fprintf(fidout,'\t');        
        if ~weighted,
            current_nei = find_neighbors_many_nodes( struct.adjacency_matrix_binary, current_cluster );       
        else
            current_nei = find_neighbors_many_nodes( struct.adjacency_matrix_weighted, current_cluster );            
        end
        current_eval = best_eval;
        nodes_counter = nodes_counter +1;
    end
    
end

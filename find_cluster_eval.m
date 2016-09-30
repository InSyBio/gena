function [ eval ] = find_cluster_eval( cluster_nodes, struct, nodes_num, naive_or_scaled, weighted, eval_type )

    in_edges = 0;
    in_edges_cardinality = 0;
    out_edges = 0;
    in_edges_complement = 0;
    in_edges_avg = [];
    in_edges_complement_avg = [];
    out_edges_avg = [];
    
    if naive_or_scaled == 1,
        for i = 1:length(cluster_nodes),
            cluster_nodes_exclude = cluster_nodes;
            cluster_nodes_exclude(cluster_nodes_exclude == cluster_nodes(i)) = [];
            [ a, b, c, d ] = in_out_edges( cluster_nodes(i), cluster_nodes_exclude, struct, weighted );
            in_edges = in_edges+a;
            in_edges_cardinality = in_edges_cardinality+d;
            in_edges_complement = in_edges_complement+b;
            out_edges = out_edges+c;
            in_edges_avg(end+1) = a;
            in_edges_complement_avg(end+1) = b;
            out_edges_avg(end+1) = c;
        end
        if eval_type == 1,
            eval = 0.5*(in_edges_complement+out_edges);
        elseif eval_type == 2,
            eval = 0.5*(out_edges/in_edges);   
        elseif eval_type == 3,
            eval = 0.5*(mean(in_edges_complement_avg)+mean(out_edges_avg));
        elseif eval_type == 4,
            eval = 0.5*(mean(out_edges_avg)/mean(in_edges_avg));            
        elseif eval_type == 5,
            eval = out_edges - in_edges;   
        elseif eval_type == 6,
            eval = 0.8*out_edges - 0.2*in_edges;   
        elseif eval_type == 7,
            eval = 0.6*out_edges - 0.4*in_edges;   
        elseif eval_type == 8,
            eval = 0.4*out_edges - 0.6*in_edges;   
        elseif eval_type == 9,
            eval = 0.2*out_edges - 0.8*in_edges;
        end    
    else
        summ1 = 0; summ2 = 0; summ1_avg = []; summ2_avg = []; summ4_avg = []; summ5_avg = []; summ6_avg = []; summ7_avg = [];
        for i = 1:length(cluster_nodes),
            cluster_nodes_exclude = cluster_nodes;
            cluster_nodes_exclude(cluster_nodes_exclude == cluster_nodes(i)) = [];            
            [ a, b, c ] = in_out_edges( cluster_nodes(i), cluster_nodes_exclude, struct, weighted );
            summ1 = summ1 + ((b+c)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));
            summ2 = summ2 + ((c/a)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));
            summ1_avg(end+1) = ((b+c)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));
            summ2_avg(end+1) = ((c/a)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));
            summ4_avg(end+1) = ((0.2*b + 0.8*c)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));        
            summ5_avg(end+1) = ((0.4*b + 0.6*c)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));        
            summ6_avg(end+1) = ((0.6*b + 0.4*c)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));        
            summ7_avg(end+1) = ((0.8*b + 0.2*c)/length(union(find_neighbors(struct.adjacency_matrix_binary,cluster_nodes(i)),cluster_nodes)));        
        end
        if eval_type == 1,
            eval = ((nodes_num-1)/3)*summ1;
        elseif eval_type == 2,
            eval = ((nodes_num-1)/3)*summ2;
        elseif eval_type == 3,
            eval = ((nodes_num-1)/3)*mean(summ1_avg);
        elseif eval_type == 4,
            eval = ((nodes_num-1)/3)*mean(summ2_avg);
        elseif eval_type == 5,
            eval = ((nodes_num-1)/3)*mean(summ1_avg);            
        elseif eval_type == 6,
            eval = ((nodes_num-1)/3)*mean(summ4_avg);            
        elseif eval_type == 7,
            eval = ((nodes_num-1)/3)*mean(summ5_avg);            
        elseif eval_type == 8,
            eval = ((nodes_num-1)/3)*mean(summ6_avg);            
        elseif eval_type == 9,
            eval = ((nodes_num-1)/3)*mean(summ7_avg);                        
        end
    end
end

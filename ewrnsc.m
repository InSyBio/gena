function [ clusters_nodes, clusters_eval, counter_larger_2 ] = ewrnsc( struct, naive_or_scaled, weighted, eval_type, filenameout, label_seed_metric )

fidout = fopen(filenameout,'wt');

%start from 3-cliques and augment

nodes_num = length(struct.degree);

all_nodes_ids = 1:nodes_num;
if strcmp(label_seed_metric,'degree')
    %disp('degree')
    tt = [struct.degree; 1:nodes_num]';
elseif strcmp(label_seed_metric,'cl_coef'),
       %disp('cl_coef')
       tt = [struct.clustering_coefficient'; 1:nodes_num]'; 
    elseif strcmp(label_seed_metric,'cl_coef_nei'),
       %disp('cl_coef_nei')
       tt = [struct.clustering_coefficient_nei; 1:nodes_num]';  
end
sorted = sortrows(tt,1);
nodes_sorted_degree = fliplr(sorted(:,2)');
%nodes_sorted_degree = sorted(:,2);
cc=1;
counter_larger_2 = 0;
set_nodes_to_choose = [];
to_select = nodes_sorted_degree(1);

%for i = 1:length(nodes_sorted_degree),
while ~isempty(to_select),
    %nodes_sorted_degree(i) % current node
    %disp(cc)

    if cc == 1,
        node_chosen = nodes_sorted_degree(1);
    else
        if strcmp(label_seed_metric,'degree')
        temp_degrees = struct.degree(to_select);
        elseif strcmp(label_seed_metric,'cl_coef'),
             temp_degrees = struct.clustering_coefficient(to_select);   
        elseif strcmp(label_seed_metric,'cl_coef_nei'),
             temp_degrees = struct.clustering_coefficient_nei(to_select);      
        end
        [~, maxpos] = max(temp_degrees);
        node_chosen = to_select(maxpos);
    end
    
    %fprintf(fidout,'current_node\t'); fprintf(fidout,num2str(nodes_sorted_degree(i))); fprintf(fidout,'\t');
    [ neighbors ] = find_neighbors( struct.adjacency_matrix_binary, node_chosen ); % its neighbors
    [clusters_nodes{cc}, clusters_eval(cc)] = find_cluster(node_chosen, neighbors, struct, nodes_num, naive_or_scaled, fidout, weighted, eval_type);
    set_nodes_to_choose = unique([set_nodes_to_choose clusters_nodes{cc}]);
    %fprintf(fidout,'cluster_nodes_finally\t'); fprintf(fidout,num2str(clusters_nodes{i})); fprintf(fidout,'\t');
    %fprintf(fidout,'cluster_eval_finally\t'); fprintf(fidout,num2str(clusters_eval(i))); fprintf(fidout,'\t');
    %fprintf(fidout,'size_of_final_cluster\t'); fprintf(fidout,num2str(length(clusters_nodes{i}))); fprintf(fidout,'\n');
    
    if length(clusters_nodes{cc}) > 2,
       counter_larger_2 =  counter_larger_2 + 1;
    end
    to_select = setdiff(all_nodes_ids, set_nodes_to_choose);
    length(to_select)  
    
    %clusters_nodes{cc}
    for m = 1:length(clusters_nodes{cc}),
        fprintf(fidout,struct.unique_proteins{clusters_nodes{cc}(m)});
        if m == length(clusters_nodes{cc}),
            fprintf(fidout,'\n');
        else
            fprintf(fidout,'\t');
        end
    end
    cc=cc+1;
    
end

fclose(fidout);

end

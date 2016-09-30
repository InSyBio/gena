function [ ret_var, ret_var_avg ] = compute_mmr( predicted, reference, is_number, struct )

    %predicted_ids = 1:length(predicted);
    %reference_ids = length(predicted):(length(predicted)+length(reference));

    %cc=1;
    
    if is_number,
        for i = 1:length(predicted),
            for j = 1:length(predicted{i}),
                predicted_genes{i}{j} = struct.unique_proteins{predicted{i}(j)};
            end
        end
        predicted = predicted_genes;
    end
    
    array_for_mcc = zeros(length(predicted),length(reference));
    for i = 1:length(predicted),
       
        %for each predicted{i}
        
        for j = 1:length(reference),
            
            inter_num = length(intersect(predicted{i},reference{j}))/length(union(predicted{i},reference{j}));
            
            if inter_num ~= 0 && ~isnan(inter_num),
            
%                 array_for_mcc(cc,1) = predicted_ids(i);
%                 array_for_mcc(cc,2) = reference_ids(j);
%                 array_for_mcc(cc,3) = inter_num;
%                 cc = cc + 1;
                array_for_mcc(i,j)=inter_num;
            
            end
            
        end
        
    end

    disp('Computing MMR...')
    [val, m1, m2] = bipartite_matching(array_for_mcc);
    ret_var = val;
    ret_var_avg = ret_var/min(length(reference),length(predicted));
    
end

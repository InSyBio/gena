function [ counter ] = distribution_of_benchmark_datasets( input )

    all_genes = {};
    for i = 1:length(input),
        all_genes = [all_genes input{i}];
    end
    all_genes = unique(all_genes);
    
    length(all_genes)
    counter = zeros(1,length(all_genes));
    for i = 1:length(all_genes),
        disp(i)
        for j = 1:length(input),
            if ~isempty(intersect(input{j},all_genes{i})),
                counter(i) = counter(i)+1;
            end
        end
    end
    
end

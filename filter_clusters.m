function [ new_clusters ] = filter_clusters( clusters, my_input )

cc=1;   new_clusters = {};
for i = 1:length(clusters),
    if length(clusters{i}) >= my_input,
        new_clusters{cc} = clusters{i};
        cc = cc + 1;
    end
end

end

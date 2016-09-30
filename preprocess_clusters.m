function [ clusters ] = preprocess_clusters( clusters, struct, density_thres, merged_thres )

    %disp('preprocess...')
    %clusters = filter_clusters(clusters);
    disp('merging clusters...')
    clusters = merge_clusters(clusters, merged_thres);
    %disp('filter density of clusters...')
    %[ clusters, ~ ] = filter_density( clusters, struct, density_thres, 0);

end
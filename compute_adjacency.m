function [ret_var] = compute_adjacency(input_file)

if strcmp(input_file, 'yeast-ppis.txt') == 1,
    [proteins1, proteins2, weights] = textread(input_file, '%s %s %f');
elseif strcmp(input_file, 'hprd_dataset.txt') == 1,
    fid = fopen('hprd_dataset.txt','r');
    g = textscan(fid, '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s', 'delimiter', ' ');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = ones(length(proteins1),1);
elseif strcmp(input_file, 'biogrid_yeast_physical_unweighted.txt') == 1,
    fid = fopen('./input_networks_clusterone/biogrid_yeast_physical_unweighted.txt','r');
    g = textscan(fid, '%s%s', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = ones(length(proteins1),1);
elseif strcmp(input_file, 'collins2007.txt') == 1,
    fid = fopen('./input_networks_clusterone/collins2007.txt','r');
    g = textscan(fid, '%s%s%f', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = g{3};
elseif strcmp(input_file, 'gavin2006_socioaffinities_rescaled.txt') == 1,
    fid = fopen('./input_networks_clusterone/gavin2006_socioaffinities_rescaled.txt','r');
    g = textscan(fid, '%s%s%f', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = g{3};
elseif strcmp(input_file, 'krogan2006_core.txt') == 1,
    fid = fopen('./input_networks_clusterone/krogan2006_core.txt','r');
    g = textscan(fid, '%s%s%f', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = g{3};
elseif strcmp(input_file, 'krogan2006_extended.txt') == 1,
    fid = fopen('./input_networks_clusterone/krogan2006_extended.txt','r');
    g = textscan(fid, '%s%s%f', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = g{3};
elseif strcmp(input_file, 'hintkb_interactions.csv') == 1,
    [~,~,dd] = xlsread('hintkb_interactions.csv');
    proteins1 = dd(:,1);
    proteins2 = dd(:,2);
    weights = dd(:,3);
    for i = 1:length(weights),
        weights{i} = strrep(weights{i}, ',', '.');
    end
    weights=str2double(weights);
elseif strcmp(input_file, 'control_co_expression_network.txt') == 1,
    fid = fopen('control_co_expression_network.txt','r');
    g = textscan(fid, '%s%s%f', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = g{3};    
elseif strcmp(input_file, 'parkinson_coexpression_network.txt') == 1,
    fid = fopen('parkinson_coexpression_network.txt','r');
    g = textscan(fid, '%s%s%f', 'delimiter', '\t');
    proteins1 = g{1};
    proteins2 = g{2};
    weights = g{3};    
end

size_interactions = length(proteins1);
all_proteins = [proteins1; proteins2];
unique_proteins = unique(all_proteins);
size_unique_proteins = length(unique_proteins);

adjacency_matrix_weighted = zeros(size_unique_proteins,size_unique_proteins);

for i = 1:size_interactions,
    disp(i)
    pos1 = find(ismember(unique_proteins, proteins1(i))); pos2 = find(ismember(unique_proteins,proteins2(i)));
    adjacency_matrix_weighted(pos1,pos2) = weights(i); adjacency_matrix_weighted(pos2,pos1) = weights(i);    
end

adjacency_matrix_binary = adjacency_matrix_weighted;
adjacency_matrix_binary(adjacency_matrix_binary~=0)=1;
degree=sum(adjacency_matrix_binary);

ret_var.adjacency_matrix_binary = adjacency_matrix_binary;
ret_var.adjacency_matrix_weighted = adjacency_matrix_weighted;
ret_var.unique_proteins = unique_proteins;
ret_var.degree = degree;

end
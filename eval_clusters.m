function [ sensitivity, ppv, acc, Sep, count_overlap, predicted ] = eval_clusters( predicted, gold, unique_genes_network, numbers_ids_flag )

t = zeros(length(predicted),length(gold));
overlap = zeros(length(predicted),length(gold));
n = zeros(length(gold),1);
count_overlap = zeros(length(predicted),1);

predicted_genes = {};

unique_genes_network = upper(unique_genes_network);

if numbers_ids_flag,
for i = 1:length(predicted),
    for j = 1:length(predicted{i}),
        predicted_genes{i}{j} = unique_genes_network{predicted{i}{j}};
    end
end
predicted = predicted_genes;
end

%rows are predicted
disp('overlap')
for i = 1:length(gold),
    disp(i)
    for j = 1:length(predicted),
        t(i,j) = length(intersect(gold{i},predicted{j}));
        overlap(i,j) = (t(i,j).^2)/(length(gold{i})*(length(predicted{j})));
        if overlap(i,j) > 0.25,
            %count_overlap = count_overlap+1;
            count_overlap(j) = 1;
        end
    end
    n(i) = length(gold{i});
end
count_overlap = sum(count_overlap)/length(predicted);

disp('sensitivity')
for i = 1:length(gold),
    maxx(i) = max(t(i,:));
end
sensitivity = sum(maxx)/sum(n);
clear maxx

disp('ppv')
for j = 1:length(predicted),
    maxx(j) = max(t(:,j));
end
for j = 1:length(predicted),
    tj(j) = sum(t(:,j));
end
ppv = sum(maxx)/sum(tj);

acc = sqrt(ppv*sensitivity);

disp('separation')
for i = 1:length(gold),
    disp(i)
    for j = 1:length(predicted),
        if sum(t(i,:)) ~= 0,
            Fijr(i,j) = t(i,j)/sum(t(i,:));
        else
            Fijr(i,j) = 0;
        end
        if sum(t(:,j)) ~= 0,
            Fijc(i,j) = t(i,j)/sum(t(:,j));
        else
            Fijc(i,j) = 0;
        end
        Sepij(i,j) = Fijr(i,j)*Fijc(i,j);
        
    end
end
temp = sum(sum(Sepij));
Sepco = temp/length(predicted);
Sepcl = temp/length(gold);
Sep = sqrt(Sepco*Sepcl);

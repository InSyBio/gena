function [ gold ] = create_struct_gold( filepath, flag_is_bt409, space_flag )

fid = fopen(filepath,'r');

tline = fgetl(fid);
cc=1;
while ischar(tline)
    disp(tline)
    if space_flag,
        splitted = strsplit(tline,' ');
    else
        splitted = strsplit(tline,'\t');
    end
    gold{cc} = splitted;
    tline = fgetl(fid);
    cc=cc+1;
end
fclose(fid);

if flag_is_bt409,
    for i = 1:length(gold),
        gold{i} = gold{i}(1:end-1);
    end
end

for i = 1:length(gold),
    for j = 1:length(gold{i}),
        gold{i}{j} = upper(gold{i}{j});
    end
end



end

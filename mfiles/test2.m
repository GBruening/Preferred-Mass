Miss.angle_comb = zeros(nc,nsubj*200);
for c=1:nc
    for subj=1:nsubj
        Miss.angle_comb(c,200*(subj-1)+1:200*subj) = [Data{c,subj}.miss_angle];
        
    end
end

for c=1:nc
    bar(str2double(conditions(c)),std(Miss.angle_comb(c,:)));
end
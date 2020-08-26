figure(1);clf(1);
subplot(2,2,1);
hold on
for c = 1:4
    for subj = 1:8
        for k = 50:10:200
           figure(1);
           subplot(2,2,Data{c,subj}.targetnumber(k));
           hold on
           plot(Data{c,subj}.p(MT{c,subj}.idxonset(k):MT{c,subj}.idxendpt(k)));
        end        
    end
end
%Load ordered data with FML

for c=2:nc  
    tr_count=1;
    for subj=1:nsubj
        for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
            for k=1:200
%                 subj
%                 c
%                 i
%                 k
%                 ResampleDataX(c-1,subj,i,k) = Data{c,subj}.x(ceil(MT{c,subj}.idxendpt(i)*k/200),i);
%                 ResampleDataY(c-1,subj,i,k) = Data{c,subj}.y(ceil(MT{c,subj}.idxendpt(i)*k/200),i);
%                 
                ResampleDataX(c-1,tr_count,k) = abs(Data{c,subj}.x(ceil(MT{c,subj}.idxendpt(i)*k/200),i));
                ResampleDataY(c-1,tr_count,k) = abs(Data{c,subj}.y(ceil(MT{c,subj}.idxendpt(i)*k/200),i));
                
%                 ResampleDataX(c-1,tr_count) = Data{c,subj}.x(ceil(MT{c,subj}.idxendpt(i)*k/200),i);
%                 ResampleDataY(c-1,tr_count) = Data{c,subj}.y(ceil(MT{c,subj}.idxendpt(i)*k/200),i);
                
               
           
            end
            tr_count=tr_count+1;
        end
%         subj
    end
%     c
end

for c=1:5
    for k = 1:200
        
        ResampleDataX2(c,k)=mean(ResampleDataX(c,:,k));
        ResampleDataY2(c,k)=mean(ResampleDataY(c,:,k));
    end
end

figure(62);
hold on;
for c=1:5
    for k=1:200
        ColorPref(c)=plot(ResampleDataX2(c,:),ResampleDataY2(c,:),'Color',ColorSet(c*3,:));
    end
end
xlabel('X position');ylabel('Y position');title('Paths to target');legend([ColorPref(:)],conditions{2:6});
plot(0.070710537390700,0.070710818846400,'x','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:),'LineWidth',5);
clear ColorPref
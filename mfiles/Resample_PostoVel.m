ColorSet = parula(nc);

% SpmP = zeros(300*nc*nsubj,200);
% SpmV = zeros(300*nc*nsubj,200);
% SpmC = zeros(300*nc*nsubj,1);
% SpmS = zeros(300*nc*nsubj,1);

tr_count2=1;
for c=1:nc  
    tr_count=1;
    for subj=1:nsubj
        for i=101:2:400
            switch Data{c,subj}.targetnumber(i)
                case 1
                    
                case 2
                    Data{c,subj}.v(:,i)=Data{c,subj}.vx(:,i)*-1;
                case 3
                    Data{c,subj}.vx(:,i)=Data{c,subj}.vx(:,i)*-1;
                    Data{c,subj}.vx(:,i)=Data{c,subj}.vy(:,i)*-1;
                case 4
                    Data{c,subj}.vx(:,i)=Data{c,subj}.vy(:,i)*-1;
            end
            for k=1:200
                %ceil(MT{c,subj}.idxendpt(i)
%                 index = ceil(sum(~isnan(Data{c,subj}.P_abs(:,i)))*k/200);
%                 MT{c,subj}.idxendpt(i)-MT{c,subj}.idxonset(i)
                index = ceil((MT{c,subj}.idxendpt(i)-MT{c,subj}.idxonset(i))*k/200)+MT{c,subj}.idxonset(i);
                ResampleDataP(c,tr_count,k) = abs(Data{c,subj}.P_abs(index,i));
                ResampleDatav(c,tr_count,k) = Data{c,subj}.TanV(index,i);
%                 SpmP(tr_count2,k) = abs(Data{c,subj}.P_abs(index,i));
%                 SpmV(tr_count2,k) = Data{c,subj}.TanV(index,i);
%                 SpmC(tr_count2) = c;
%                 SpmS(tr_count2) = subj;
            end
            tr_count2=tr_count2+1;
            tr_count=tr_count+1;
        end
    end
end

for c=1:4
    for k = 1:200        
        ResampleDataP2(c,k)=mean(ResampleDataP(c,:,k));
        ResampleDatav2(c,k)=mean(ResampleDatav(c,:,k));
    end
end

figure(64);clf(64)
hold on;
for c=1:4
    ColorPref(c)=plot(ResampleDataP2(c,:),ResampleDatav2(c,:),'Color',ColorSet(c,:),'LineWidth',3);
    plot(ResampleDataP2(c,find(ResampleDatav2(c,:)==max(ResampleDatav2(c,:)))),max(ResampleDatav2(c,:)),'x','Color',ColorSet(c,:),'LineWidth',3);
end
% conditions{1}='0';
% conditions{2}='2.4';
% conditions{3}='4.4';
% conditions{4}='5.6';
% conditions{5}='7.5';
set(gca,'TickDir','out');
% legend([ColorPref(:)],conditions);
xlabel('Position (cm)');ylabel('Velocity (m/s)');
titlestr=sprintf('Position to velocity');
title(titlestr);

figure(65);clf(65)
hold on;
for c=1:4
    ColorPref(c)=plot(1:200,ResampleDatav2(c,:),'Color',ColorSet(c,:),'LineWidth',3);
    plot(find(ResampleDatav2(c,:)==max(ResampleDatav2(c,:))),max(ResampleDatav2(c,:)),'x','Color',ColorSet(c,:),'LineWidth',3);
end
% legend([ColorPref(:)],conditions{1:4});
set(gca,'XtickLabel',[0,10,20,30,40,50,60,70,80,90,100],'Xtick',[0,20,40,60,80,100,120,140,160,180,200],'tickDir','out');
xlabel('Percent of Movement');ylabel('Velocity (m/s)');
titlestr=sprintf('Percent of Movement to velocity');
title(titlestr);

ColorSet = parula(nsubj);
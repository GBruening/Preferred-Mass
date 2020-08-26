section_cells={'all' 'totarget' 'tomoveback' 'back'};
section=section_cells{1};


figure(1);
hold on
for subj=1:nsubj
        for c=1:nc
            PrefSpeed.ste.(section)(c) = std(Data{c,subj}.avevel.all,[],2)/sqrt(length(Data{c,subj}.avevel.all));
            
            ColorPref(subj)=plot(c,PrefSpeed.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(PrefSpeed.(section)(:,subj),'k-')
        errorbar(1:nc,PrefSpeed.(section)(:,subj),PrefSpeed.ste.(section),'k-')
end


xlabel('Block Period'); ylabel('Avg speed (m/s)');title(section);

legend([ColorPref(:)],'Kyle','Same','Alex');
axis([0 7 min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.15]); 
set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6,7])%,'FontSize',14)
% set(gca,'XTickLabel',[' ' conditions{1}(1:6) ' '],'XTick',[0,1,2,3,4,5,6,7])%,'FontSize',14)

%% All trials

hold on
for subj=1:nsubj
k=1;    
    for c=1:nc
        if c==1
        for i=1:100
            
%             AllTrialVelocityData(subj,k) = Data{c,subj}.avevel.all(i);
            AllTrialVelocityData(subj,k) = Data{c,subj}.peakvel.all(i);
            k=k+1;
        end
        elseif c>1
        for i=1:200
            
%             AllTrialVelocityData(subj,k) = Data{c,subj}.avevel.all(i);
            AllTrialVelocityData(subj,k) = Data{c,subj}.peakvel.all(i);
            k=k+1;
        end    
        end
        
    end
    fprintf('Done with subject %s \n',subj);
end

    
for c=1:6
    if c==1
        for k=6:95
            Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-5:k+5));
        end
    elseif c>1
        for k=6:195
            Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-5:k+5));
        end
    end
end

for subj=1:nsubj
    for i=11:1090
        ATVDave(subj,i)=mean(AllTrialVelocityData(subj,i-10:i+10));
    end
end

figure(2);
hold on
for subj=1:nsubj
    ColorPref(subj)=plot(ATVDave(subj,:));
end
xlabel('Trial Number');ylabel('Velocity (20 trial window');
set(gca,'XTick',[0,100,300,500,700,900,1100]);
% legend([ColorPref(:)],'Kyle','Sam','Alex');
% axis([0 1100 .1 .3]);


%% This section is plotting the discont trials for prefered speed
% 
% figure(4);
% hold on;
% for subj=1:nsubj
%     for c = 2:nc
%         plot(PrefSpeed.all(c,subj),length(Data{c,subj}.discont.trials),'o');
%     end
% end
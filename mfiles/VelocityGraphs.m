clear('ColorPref')


% for c=1:1
%     
%     for subj=1:1
%         figure(subj)
%         ColorPref(c)=plot(Data{c,subj}.averagedavevel(10:190),'-','Color',ColorSet(c*4,:),'MarkerFaceColor',ColorSet(c*4,:));
%         legend([ColorPref(:)],conditions(c));
%     end
%     
% end

%% duh
subj=9;

subplot(2,2,1);
    for c=1:5
        for k=6:195
            Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-5:k+5));
        end
    end
   
for c=1:5
    hold on;
    ColorPref(c)=plot(Data{c,subj}.averagedavevel(6:195),'-','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:),'LineWidth',3);        
end
legend([ColorPref(:)],conditions);
ylabel('Average Velocity per trial (+- 5 Trials)');xlabel('Trial Number');
title1=sprintf('Average Velocity Subject %s',num2str(subj));
title(title1);

subplot(2,2,2);
for c=1:5
    for k=21:180
        Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-20:k+20));
    end
end

for c=1:5
    hold on;
        ColorPref(c)=plot(Data{c,subj}.averagedavevel(21:180),'-','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:),'LineWidth',3);        
end
%legend([ColorPref(:)],conditions);
ylabel('Average Velocity per trial (+- 20 Trials)');xlabel('Trial Number');
title1=sprintf('Average Velocity Subject %s',num2str(subj));
title(title1);

subplot(2,2,3);
for c=1:5
    trace=1;
    for k=5:10:195;
        Data{c,subj}.averagedavevelbin(trace)=mean(Data{c,subj}.avevel.all(k-4:k+5));
        trace=trace+1;
    end
end

bins={'0-10' '11-20' '21-30' '31-40' '41-50' '51-60' '61-70' '71-80' '81-90' '91-100' '101-110' '111-120' '121-130' '131-140' '141-150' '151-160' '161-170' '171-180' '181-190' '191-200'};
x=[.5:1:19.5];
for c=1:5
    hold on;
    ColorPref(c)=plot(x,Data{c,subj}.averagedavevelbin,'-','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:),'LineWidth',3);
end
set(gca,'XTickLabel',[bins],'XTick',[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20])%,'FontSize',14)
ylabel('Average Velocity Binned by 10 trials'); xlabel('bin');title(title1);

subplot(2,2,4);
for c=1:5
    trace=1;
    for k=5:20:195;
        Data{c,subj}.averagedavevelbin2(trace)=mean(Data{c,subj}.avevel.all(k-4:k+5));
        trace=trace+1;
    end
end

bins={'0-20' '21-40' '41-60' '61-80' '81-100' '101-120' '121-140' '141-160' '181-200'};
x=[.5:1:9.5];
for c=1:5
    hold on;
    ColorPref(c)=plot(x,Data{c,subj}.averagedavevelbin2,'-','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:),'LineWidth',3);
end
set(gca,'XTickLabel',[bins],'XTick',[1,2,3,4,5,6,7,8,9,10])%,'FontSize',14)
ylabel('Average Velocity Binned by 10 trials'); xlabel('bin');title(title1);


%% Velocity by order instead of trial
%Peoples conditions weren't all the same order, need to create new Data
%cells for each subjects in the data read mfile
%Peoples conditions weren't all the same order, need to create new Data
%cells for each subjects in the data read mfile

%Load unordered velocity data


order(1)=3;
order(2)=2;
order(3)=1;
order(4)=4;
order(5)=5;
order(6)=6;
order(7)=1;
order(8)=2;
order(9)=3;
order(10)=4;
order(11)=5;
order(12)=6;
order(13)=1;
order(14)=2;
order(15)=4;
order(16)=3;
order(17)=5;
order(18)=6;


for subj=1:nsubj
k=1;    
    for c=1:5
        
        for i=1:200
            
            AllTrialVelocityData(subj,k) = Data{c,subj}.avevel.all(i);
            k=k+1;
        end
    end
    fprintf('Done with subject %s \n',subj);
end

    
for c=1:5
        for k=6:195
            Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-5:k+5));
        end
end

for subj=1:nsubj
    for i=11:990
        ATVDave(subj,i)=mean(AllTrialVelocityData(subj,i-10:i+10));
    end
end

for subj=1:nsubj
    plot(ATVDave(subj,:));
    %title(conditions{subj}(:));
    set(gca,'XTickLabel', [conditions{subj}(2:6)], 'XTick',[0,200,400,600,800]);
    line([200 200],get(gca, 'ylim'));
    line([800 800],get(gca, 'ylim'));
end
 

%% new data plots
figure(2)
for subj=1:nsubj
k=1;    
    for c=1:5
        if c~=1
            for i=1:200

                AllTrialVelocityData(subj,k) = Data{c,subj}.avevel.all(i);
                k=k+1;
            end
        elseif c==1
            for i=1:400
                AllTrialVelocityData(subj,k) = Data{c,subj}.avevel.all(i);
                k=k+1;
                
            end
        end
    end
    fprintf('Done with subject %s \n',subj);
end

    
for c=1:5
        for k=6:195
            Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-5:k+5));
        end
end

for subj=1:nsubj
    for i=11:1190
        ATVDave(subj,i)=mean(AllTrialVelocityData(subj,i-10:i+10));
    end
end

for subj=1:nsubj
    plot(ATVDave(subj,:));
    %title(conditions{subj}(:));
    set(gca,'XTickLabel', [conditions], 'XTick',[0,400,600,800,1000]);
    axis([-100 1300 .8*min(mean(ATVDave(subj,:))) (1.2)*max(mean(ATVDave(subj,:)))])
%     line([200 200],get(gca, 'ylim'));
%     line([800 800],get(gca, 'ylim'));
end

%% 
for subj=1:nsubj
    plot(Data{1,subj}.avevel.all(:))
end


section_cells={'all' 'totarget' 'tomoveback' 'back'};
section=section_cells{1};

target_cells={'one' 'two' 'thr' 'fou'};
ntar=length(target_cells);

figure_count = 3;

%% Creating the arrays
for subj=1:nsubj
    for c=1:nc
        for k=1:ntar
            target=target_cells{k};
%             ColorPref(subj)=scatter3(c,k,mean(TargetData{c,subj}.(target).PrefSpeed));
            TargetData{c,subj}.(target).PrefSpeedavg=mean(TargetData{c,subj}.(target).PrefSpeed);
            TargetData{c,subj}.(target).PeakSpeedavg=mean(TargetData{c,subj}.(target).PeakSpeed);
        end
    end
end

for subj=1:nsubj
    for c=1:nc
        for k=1:ntar
            target=target_cells{k};
            TargetArray.PrefSpeed(c,subj,k)=TargetData{c,subj}.(target).PrefSpeedavg;
            TargetArray.PeakSpeed(c,subj,k)=TargetData{c,subj}.(target).PeakSpeedavg;
            TargetArray.ReactionVthres(c,subj,k)=mean(TargetData{c,subj}.(target).ReactionVthres);
            TargetArray.MissAngle(c,subj,k)=mean(TargetData{c,subj}.(target).ReactionVthres);
            
        end
    end
end

for subj=1:nsubj
    for c=1:nc
        for k=1:4
            TargetArray.PrefSpeednorm(c,subj,k)=TargetArray.PrefSpeed(c,subj,k)./TargetArray.PrefSpeed(1,subj,k);
            TargetArray.PeakSpeednorm(c,subj,k)=TargetArray.PeakSpeed(c,subj,k)./TargetArray.PeakSpeed(1,subj,k);
            TargetArray.ReactionVthresnorm(c,subj,k)=TargetArray.ReactionVthres(c,subj,k)./TargetArray.ReactionVthres(1,subj,k);
            TargetArray.MissAngle(c,subj,k)=TargetArray.MissAngle(c,subj,k)./TargetArray.MissAngle(1,subj,k);
            
        end
    end
end

%% Average/Peak Speed by Target/Condition

figure(figure_count);
hold on

for k=1:ntar
    for c=1:nc
        ColorPref(k)=plot(c,mean(TargetArray.PrefSpeed(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end    
    plot(mean(TargetArray.PrefSpeed(:,:,k),2),'k-','Color',ColorSet(k*3,:));
end

xlabel('Condition'); ylabel('PrefSpeed To targets (m/s)');
title('PrefSpeed By Target');
legend([ColorPref(:)],target_cells);
axis([0 6 .15 .25]); 
set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
figure_count=figure_count+1;

figure(figure_count);
hold on

for k=1:ntar
    for c=1:nc        
        ColorPref(k)=plot(c,mean(TargetArray.PeakSpeed(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end
    plot(mean(TargetArray.PeakSpeed(:,:,k),2),'k-','Color',ColorSet(k*3,:));
end

xlabel('Condition'); ylabel('PeakSpeed To targets (m/s)');
title('PeakSpeed By Target');
legend([ColorPref(:)],target_cells);
axis([0 6 .3 .45]); 
set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)

%% Average Speed by Target/Condition NORMALIZED

figure(figure_count);
hold on

for k=1:ntar
    for c=1:nc
        ColorPref(k)=plot(c,mean(TargetArray.PrefSpeednorm(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end    
    plot(mean(TargetArray.PrefSpeednorm(:,:,k),2),'k-','Color',ColorSet(k*3,:));
end

xlabel('Condition'); ylabel('PrefSpeed To targets (m/s)');
title('PrefSpeed By Target NORMALIZED');
legend([ColorPref(:)],target_cells);
axis([0 6 .85 1.17]); 
set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
figure_count=figure_count+1;


%% Reaction time Vthres
figure(figure_count);
hold on;

for k=1:ntar
    for c=1:nc
        ColorPref(k)=plot(c,mean(TargetArray.ReactionVthres(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end
    plot(mean(TargetArray.ReactionVthres(:,:,k),2),'k-','Color',ColorSet(k*3,:));
end

xlabel('Condition'); ylabel('Reaction Time (frames)');
title('Reaction Time By Target');
legend([ColorPref(:)],target_cells);
 axis([0 6 45 55]); 
set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)

%% REaction time Vthres NORMALIZED
figure(figure_count);
hold on

for k=1:ntar
    for c=1:nc
        ColorPref(k)=plot(c,mean(TargetArray.ReactionVthresnorm(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end    
    plot(mean(TargetArray.ReactionVthresnorm(:,:,k),2),'k-','Color',ColorSet(k*3,:));
end

xlabel('Condition'); ylabel('Reaction time (frames)');
title('Reaction Time By Target NORMALIZED');
legend([ColorPref(:)],target_cells);
axis([0 6 .85 1.17]); 
set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
figure_count=figure_count+1;


%%
for c=1:nc
    for k=1:ntar
        target=target_cells{k};
    
        PrefSpeed.PerTarget.avg.(target) = mean(PrefSpeed.PerTarget.(target),2);
        PrefSpeed.PerTarget.ste.(target) = std(PrefSpeed.PerTarget.(target),[],2)/sqrt(nsubj);

        figure(figure_count);
        hold on;
        ColorPref(c)=plot(k,PrefSpeed.PerTarget.avg.(target)(c),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
    
    
        errorbar(k, PrefSpeed.PerTarget.avg.(target)(c),PrefSpeed.PerTarget.ste.(target)(c),'k-')
        
    end
    
    plot(c,PrefSpeed.PerTarget.avg.(target)(:),'k-');
    
    
    
end
    legend([ColorPref(:)],conditions);

    xlabel('Target Number'); ylabel('Avg speed');
    axis([0 ntar+1 .16 .25]); 
    set(gca,'XTickLabel',[' ' target_cells ' '],'XTick',[0,1,2,3,4,5])%,'FontSize',14)
    
    figure_count=figure_count+1;
    
    %THIS IS THE GOOD STUFF
    %plot(1:nc,PrefSpeed.PerTarget.avg.(target),'o','Color','k','MarkerFaceColor','k')
   % plot(PrefSpeed.PerTarget.avg.(target),'k-')
    %END GOOD STUFF
    
%% Peak Speed by Target/Condition
    
 
for c=1:nc
    for k=1:ntar
        target=target_cells{k};
    
        PeakSpeed.PerTarget.avg.(target) = mean(PeakSpeed.PerTarget.(target),2);
        PeakSpeed.PerTarget.ste.(target) = std(PeakSpeed.PerTarget.(target),[],2)/sqrt(nsubj);

        figure(figure_count);
        hold on;
        ColorPref(c)=plot(k,PeakSpeed.PerTarget.avg.(target)(c),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
    
    
        errorbar(k, PeakSpeed.PerTarget.avg.(target)(c),PeakSpeed.PerTarget.ste.(target)(c),'k-')
        
    end
    
    plot(c,PeakSpeed.PerTarget.avg.(target)(:),'k-');
    
    
    
end
    legend([ColorPref(:)],conditions);

    xlabel('Target Number'); ylabel('Peak speed');
    axis([0 ntar+1 .28 .44]); 
    set(gca,'XTickLabel',[' ' target_cells ' '],'XTick',[0,1,2,3,4,5])%,'FontSize',14)
    
    figure_count=figure_count+1;
    
%% Stats

% for c=1:nc
%     for k=1:ntar-1
%         target=target_cells{k};
%         
%         PrefSpeed.PerTarget.ttest(k)=megansttest(PrefSpeed.PerTarget.norm.(target)(1,:),PrefSpeed.PerTarget.norm.(target)(c+1,:),'paired');
%         fprintf(' %s    ... 0 and %s: %.5g\n',target,conditions{c+1},PrefSpeed.PerTarget.ttest(k));
%     end
% end

% for k=1:ntar-1
%     for c=1:nc
%         target=target_cells{k};
%         target2=target_cells(k+1);
%         
%         PrefSpeed.PerTarget.ttest(k,c)=megansttest(PrefSpeed.PerTarget.norm.(target)(c,:),PrefSpeed.PerTarget.norm.(target2)(c,:),'paired');
%         fprintf(' %s    ... 0 and %s: %.5g\n',target,conditions{c+1},PrefSpeed.PerTarget.ttest(k));
%     end
% end

for c=1:nc
    PrefSpeed.PerTarget.ttestnorm(1,2,c)=megansttest(PrefSpeed.PerTarget.norm.one(c,:),PrefSpeed.PerTarget.norm.two(c,:),'paired');
    PrefSpeed.PerTarget.ttestnorm(1,3,c)=megansttest(PrefSpeed.PerTarget.norm.one(c,:),PrefSpeed.PerTarget.norm.thr(c,:),'paired');
    PrefSpeed.PerTarget.ttestnorm(1,4,c)=megansttest(PrefSpeed.PerTarget.norm.one(c,:),PrefSpeed.PerTarget.norm.fou(c,:),'paired');
    PrefSpeed.PerTarget.ttestnorm(2,3,c)=megansttest(PrefSpeed.PerTarget.norm.two(c,:),PrefSpeed.PerTarget.norm.thr(c,:),'paired');
    PrefSpeed.PerTarget.ttestnorm(2,4,c)=megansttest(PrefSpeed.PerTarget.norm.two(c,:),PrefSpeed.PerTarget.norm.fou(c,:),'paired');
    PrefSpeed.PerTarget.ttestnorm(3,4,c)=megansttest(PrefSpeed.PerTarget.norm.thr(c,:),PrefSpeed.PerTarget.norm.fou(c,:),'paired');
    
    PrefSpeed.PerTarget.ttest(1,2,c)=megansttest(PrefSpeed.PerTarget.one(c,:),PrefSpeed.PerTarget.two(c,:),'paired');
    PrefSpeed.PerTarget.ttest(1,3,c)=megansttest(PrefSpeed.PerTarget.one(c,:),PrefSpeed.PerTarget.thr(c,:),'paired');
    PrefSpeed.PerTarget.ttest(1,4,c)=megansttest(PrefSpeed.PerTarget.one(c,:),PrefSpeed.PerTarget.fou(c,:),'paired');
    PrefSpeed.PerTarget.ttest(2,3,c)=megansttest(PrefSpeed.PerTarget.two(c,:),PrefSpeed.PerTarget.thr(c,:),'paired');
    PrefSpeed.PerTarget.ttest(2,4,c)=megansttest(PrefSpeed.PerTarget.two(c,:),PrefSpeed.PerTarget.fou(c,:),'paired');
    PrefSpeed.PerTarget.ttest(3,4,c)=megansttest(PrefSpeed.PerTarget.thr(c,:),PrefSpeed.PerTarget.fou(c,:),'paired');
end

PrefSpeed.PerTarget.ttestnormavg(1,2)=mean(PrefSpeed.PerTarget.ttestnorm(1,2,2:5));
PrefSpeed.PerTarget.ttestnormavg(1,3)=mean(PrefSpeed.PerTarget.ttestnorm(1,3,2:5));
PrefSpeed.PerTarget.ttestnormavg(1,4)=mean(PrefSpeed.PerTarget.ttestnorm(1,4,2:5));
PrefSpeed.PerTarget.ttestnormavg(2,3)=mean(PrefSpeed.PerTarget.ttestnorm(2,3,2:5));
PrefSpeed.PerTarget.ttestnormavg(2,4)=mean(PrefSpeed.PerTarget.ttestnorm(2,4,2:5));
PrefSpeed.PerTarget.ttestnormavg(3,4)=mean(PrefSpeed.PerTarget.ttestnorm(3,4,2:5));

PrefSpeed.PerTarget.ttestavg(1,2)=mean(PrefSpeed.PerTarget.ttest(1,2,2:5));
PrefSpeed.PerTarget.ttestavg(1,3)=mean(PrefSpeed.PerTarget.ttest(1,3,2:5));
PrefSpeed.PerTarget.ttestavg(1,4)=mean(PrefSpeed.PerTarget.ttest(1,4,2:5));
PrefSpeed.PerTarget.ttestavg(2,3)=mean(PrefSpeed.PerTarget.ttest(2,3,2:5));
PrefSpeed.PerTarget.ttestavg(2,4)=mean(PrefSpeed.PerTarget.ttest(2,4,2:5));
PrefSpeed.PerTarget.ttestavg(3,4)=mean(PrefSpeed.PerTarget.ttest(3,4,2:5));


% 
% for c=1:nc
%     for k=1:ntar
%         target=target_cells{k};
%     
%         figure(figure_count);
%         hold on;
%         ColorPref(c)=plot(k,PrefSpeed.PerTarget.ttest(k,c),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
%     
%     k
%     end
%     c
%         
% end
% 
%     legend([ColorPref(:)],conditions);
% 
%     xlabel('Target Number'); ylabel('Avg speed');
%     axis([0 ntar+1 .16 .25]); 
%     set(gca,'XTickLabel',[' ' target_cells ' '],'XTick',[0,1,2,3,4,5])%,'FontSize',14)
%     
%     figure_count=figure_count+1;













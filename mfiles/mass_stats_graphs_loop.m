
% Set someway to loop through all the sections and graph on subplots

section_cells={'all' 'totarget' 'tomoveback' 'back'};
nsec=length(section_cells);


for k=1:nsec

section=section_cells{k};
figure_count = 1;

%% Reaction Times
% figure(47);
%     hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(c,Reaction_dif(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(Reaction_dif(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Difference in reaction time, Robstate - Vthres');
%     %legend([ColorPref(:)],subjarray(subjtoload));
%  %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
%     axis([0 6 min(min(Reaction_dif))*1.15 max(max(Reaction_dif))*.8]); 
%     set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)



%% Average speed by condition
PrefSpeed.avg.(section) = mean(PrefSpeed.(section),2);
PrefSpeed.ste.(section) = std(PrefSpeed.(section),[],2)/sqrt(nsubj);

figure(figure_count);
    subplot(nsec,nsec,4*k-3); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(c,PrefSpeed.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(PrefSpeed.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Avg speed (m/s)');title(section); title(section);
    %legend([ColorPref(:)],subjarray(subjtoload));
 %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
    axis([0 6 min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    subplot(nsec,nsec,4*k-2); hold on;
    plot(1:nc,PrefSpeed.avg.(section),'o','Color','k','MarkerFaceColor','k')
    errorbar(1:nc,PrefSpeed.avg.(section),PrefSpeed.ste.(section),'k-')
    plot(PrefSpeed.avg.(section),'k-')
   % plot([0 nc+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Avg speed'); title(section);
    axis([0 nc+1 min(min(PrefSpeed.avg.(section)))*.8 max(max(PrefSpeed.avg.(section)))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    PrefSpeed.norm.avg.(section) = mean(PrefSpeed.norm.(section),2);
    PrefSpeed.norm.ste.(section) = std(PrefSpeed.norm.(section),[],2)/sqrt(nsubj);

    subplot(nsec,nsec,4*k-1); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(c,PrefSpeed.norm.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(PrefSpeed.norm.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Avg speed (m/s), normalized to 0lb');title(section);
    %legend([ColorPref(:)],subjarray(subjtoload));
 %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
    axis([0 6 min(min(PrefSpeed.norm.(section)))*.8 max(max(PrefSpeed.norm.(section)))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    subplot(nsec,nsec,4*k); hold on;
    plot(1:nc, PrefSpeed.norm.avg.(section),'o','Color','k','MarkerFaceColor','k')
    errorbar(1:nc, PrefSpeed.norm.avg.(section),PrefSpeed.norm.ste.(section),'k-')
    plot( PrefSpeed.norm.avg.(section),'k-')
    plot([0 nc+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Avg speed, normalized to 0lb');title(section);
    axis([0 nc+1 min(min( PrefSpeed.norm.avg.(section)))*.8 max(max( PrefSpeed.norm.avg.(section)))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    figure_count=figure_count+1;
    
%% Peak speed by condition
PeakSpeed.avg.(section) = mean(PeakSpeed.(section),2);
PeakSpeed.ste.(section) = std(PeakSpeed.(section),[],2)/sqrt(nsubj);

figure(figure_count);
    subplot(nsec,nsec,4*k-3); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPeak(subj)=plot(c,PeakSpeed.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(PeakSpeed.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Peak speed (m/s)');title(section);
    axis([0 nc+1 min(min(PeakSpeed.(section)))*.8 max(max(PeakSpeed.(section)))*1.15]);
%    legend([ColorPeak(:)],'Foof','Nathan','Rob','Hannah');
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    subplot(nsec,nsec,4*k-2); hold on;
    plot(1:nc,PeakSpeed.avg.(section),'o','Color','k','MarkerFaceColor','k')
    errorbar(1:nc,PeakSpeed.avg.(section),PeakSpeed.ste.(section),'k-')
    plot(PeakSpeed.avg.(section),'k-')
 %   plot([0 nc+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Peak speed, normalized to 0lb');title(section);
    axis([0 nc+1 min(min(PeakSpeed.avg.(section)))*.8 max(max(PeakSpeed.avg.(section)))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    PeakSpeed.norm.avg.(section) = mean(PeakSpeed.norm.(section),2);
    PeakSpeed.norm.ste.(section) = std(PeakSpeed.norm.(section),[],2)/sqrt(nsubj);
    
    subplot(nsec,nsec,4*k-1); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPeak(subj)=plot(c,PeakSpeed.norm.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(PeakSpeed.norm.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Peak speed (m/s)');
    axis([0 nc+1 min(min(PeakSpeed.norm.(section)))*.8 max(max(PeakSpeed.norm.(section)))*1.15]);
%    legend([ColorPeak(:)],'Foof','Nathan','Rob','Hannah');
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    subplot(nsec,nsec,4*k); hold on;
    plot(1:nc,PeakSpeed.norm.avg.(section),'o','Color','k','MarkerFaceColor','k')
    errorbar(1:nc,PeakSpeed.norm.avg.(section),PeakSpeed.norm.ste.(section),'k-')
    plot(PeakSpeed.norm.avg.(section),'k-')
    plot([0 nc+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Peak speed, normalized to 0lb');
    axis([0 nc+1 min(min(PeakSpeed.norm.avg.(section)))*.8 max(max(PeakSpeed.norm.avg.(section)))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
   
    figure_count=figure_count+1;
    




%% Average path length by condition
% Need to edit for stuctures instead of arrays
PathL_norm_avg = mean(PathL.(section),2);
PathL_norm_ste = std(PathL.(section),[],2)/sqrt(nsubj);

figure(figure_count);
    subplot(nsec,2,2*k-1); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPath(subj)=plot(c,PathL.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(PathL.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Path Length (m)');title(section);
    axis([0 nc+1 min(min(PathL.(section)))*.95 max(max(PathL.(section)))*1.05]);
%    legend([ColorPath(:)],'Foof','Nathan','Rob','Hannah');
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    subplot(nsec,2,2*k); hold on;title(section);
    plot(1:nc,PathL_norm_avg,'o','Color','k','MarkerFaceColor','k')
    errorbar(1:nc,PathL_norm_avg,PathL_norm_ste,'k-')
    plot([0 nc+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Avg path length, normalized to 0lb');
    axis([0 nc+1 min(min(PathL_norm_avg))*.95 max(max(PathL_norm_avg))*1.05]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    figure_count=figure_count+1;
    

%% Accuracy to Speed
%Eventually check whether the correct their trajectory angle as they move
%Use their starting vector and compare to the miss vector
Miss.avg.angle = mean(Miss.angle,2);
Miss.ste.angle = std(Miss.angle,[],2)/sqrt(nsubj);

figure(figure_count);
hold on;
subplot(nsec,2,2*k-1);
hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPeak(subj)=plot(PrefSpeed.(section)(c,subj),Miss.angle(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
    end
    xlabel('PrefSpeed For condition'); ylabel('Miss Angle (rad)');title(section);
%    axis([min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.2 min(min(Miss.avg.angle))*.8 max(max(Miss.avg.angle))*1.15]);
    
figure(figure_count);
hold on;
subplot(nsec,2,2*k);
hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPeak(subj)=plot(PeakSpeed.(section)(c,subj),Miss.angle(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
    end
    xlabel('PeakSpeed For condition'); ylabel('Miss Angle (rad)');title(section);
%    axis([min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.2 min(min(Miss.avg.angle))*.8 max(max(Miss.avg.angle))*1.15]);
    figure_count=figure_count+1;
    
    %% Miss Dist to Speed
Miss.avg.Dist = mean(Miss.Dist,2);
Miss.ste.Dist = std(Miss.Dist,[],2)/sqrt(nsubj);

figure(figure_count);
hold on;
subplot(nsec,2,2*k-1);
hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPeak(subj)=plot(PrefSpeed.(section)(c,subj),Miss.Dist(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
    end
    xlabel('PrefSpeed For condition'); ylabel('Miss Dist');title(section);
%    axis([min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.2 min(min(Miss.avg.angle))*.8 max(max(Miss.avg.angle))*1.15]);
    
figure(figure_count);
hold on;
subplot(nsec,2,2*k);
hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPeak(subj)=plot(PeakSpeed.(section)(c,subj),Miss.Dist(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
    end
    xlabel('PeakSpeed For condition'); ylabel('Miss Dist');title(section);
%    axis([min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.2 min(min(Miss.avg.angle))*.8 max(max(Miss.avg.angle))*1.15]);
    figure_count=figure_count+1;
end
        

    %% Average miss distance/angle by condition
figure(figure_count);
    subplot(1,2,1);
    hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(c,Miss.Dist(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(Miss.Dist(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Miss Distance (cm)');
    %legend([ColorPref(:)],subjarray(subjtoload));
 %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
    axis([0 6 min(min(Miss.Dist))*.8 max(max(Miss.Dist))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    figure(figure_count);
subplot(1,2,2);
    hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(c,Miss.angle(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
       
        end
        plot(Miss.angle(:,subj),'k-','Color',ColorSet(subj,:))
    end
    xlabel('Condition'); ylabel('Miss Angle (radians)');
    %legend([ColorPref(:)],subjarray(subjtoload));
 %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
    axis([0 6 min(min(Miss.angle))*.8 max(max(Miss.angle))*1.15]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
    
    
%     subplot(1,2,2); hold on;
%     plot(1:nc,PrefSpeed_norm_avg,'o','Color','k','MarkerFaceColor','k')
%     errorbar(1:nc,PrefSpeed_norm_avg,PrefSpeed_norm_ste,'k-')
%     plot(PrefSpeed_norm_avg,'k-')
%     plot([0 nc+1], [1 1],'k--')
%     xlabel('Condition'); ylabel('Avg speed, normalized to 0lb');
%     axis([0 nc+1 min(min(MissDist))*.8 max(max(MissDist))*1.15]); 
%     set(gca,'XTickLabel',[' ' conditions ' '],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
figure_count=figure_count+1;

    
%% Stats (Bonferoni correction???)
if nsubj > 1
    fprintf('\n ********************** STATS NOT NORMALIZED **********************  \n')
    fprintf('Paired t-tests: avg. preferred speed (not normalized) \n') 
 %PrefSpeed.test.section(1) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(2,:),'paired');
        
        PrefSpeed.ttest(1) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(2,:),'paired');
        PrefSpeed.ttest(2) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(3,:),'paired');
        PrefSpeed.ttest(3) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(4,:),'paired');
        PrefSpeed.ttest(4) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(5,:),'paired');
    fprintf('    ... 0 and 3: %.5g\n',PrefSpeed.ttest(1)) % use '%%' to insert percent sign
    fprintf('    ... 0 and 5: %.5g\n',PrefSpeed.ttest(2))            
    fprintf('    ... 0 and 8: %.5g\n',PrefSpeed.ttest(3))
    fprintf('    ... 0 and 0f: %.5g\n',PrefSpeed.ttest(4))
    
    fprintf('Paired t-tests: avg. peak speed (not normalized) \n') 
        PeakSpeed.ttest(1) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(2,:),'paired');
        PeakSpeed.ttest(2) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(3,:),'paired');
        PeakSpeed.ttest(3) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(4,:),'paired');
        PeakSpeed.ttest(4) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(5,:),'paired');
    fprintf('    ... 0 and 3: %.5g\n',PeakSpeed.ttest(1)) % use '%%' to insert percent sign
    fprintf('    ... 0 and 5: %.5g\n',PeakSpeed.ttest(2))            
    fprintf('    ... 0 and 8: %.5g\n',PeakSpeed.ttest(3))
    fprintf('    ... 0 and 0f: %.5g\n',PeakSpeed.ttest(4))
    
    fprintf('Paired t-tests: avg. path length (not normalized) \n') 
        PathL.ttest(1) = megansttest(PathL.(section)(1,:),PathL.(section)(2,:),'paired');
        PathL.ttest(2) = megansttest(PathL.(section)(1,:),PathL.(section)(3,:),'paired');
        PathL.ttest(3) = megansttest(PathL.(section)(1,:),PathL.(section)(4,:),'paired');
        PathL.ttest(4) = megansttest(PathL.(section)(1,:),PathL.(section)(5,:),'paired');
    fprintf('    ... 0 and 3: %.5g\n',PathL.ttest(1)) % use '%%' to insert percent sign
    fprintf('    ... 0 and 5: %.5g\n',PathL.ttest(2))            
    fprintf('    ... 0 and 8: %.5g\n',PathL.ttest(3))
    fprintf('    ... 0 and 0f: %.5g\n',PathL.ttest(4))
    
    fprintf('\n ********************** STATS NORMALIZED **********************  \n')
    fprintf('Paired t-tests: avg. preferred speed (normalized) \n') 
        PrefSpeed.norm.ttest(1) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(2,:),'paired');
        PrefSpeed.norm.ttest(2) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(3,:),'paired');
        PrefSpeed.norm.ttest(3) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(4,:),'paired');
        PrefSpeed.norm.ttest(4) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(5,:),'paired');
    fprintf('    ... 0 and 3: %.5g\n',PrefSpeed.norm.ttest(1)) % use '%%' to insert percent sign
    fprintf('    ... 0 and 5: %.5g\n',PrefSpeed.norm.ttest(2))            
    fprintf('    ... 0 and 8: %.5g\n',PrefSpeed.norm.ttest(3))
    fprintf('    ... 0 and 0f: %.5g\n',PrefSpeed.norm.ttest(4))
    
    fprintf('Paired t-tests: avg. peak speed (normalized) \n') 
        PeakSpeed.norm.ttest(1) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(2,:),'paired');
        PeakSpeed.norm.ttest(2) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(3,:),'paired');
        PeakSpeed.norm.ttest(3) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(4,:),'paired');
        PeakSpeed.norm.ttest(4) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(5,:),'paired');
    fprintf('    ... 0 and 3: %.5g\n',PeakSpeed.norm.ttest(1)) % use '%%' to insert percent sign
    fprintf('    ... 0 and 5: %.5g\n',PeakSpeed.norm.ttest(2))            
    fprintf('    ... 0 and 8: %.5g\n',PeakSpeed.norm.ttest(3))
    fprintf('    ... 0 and 0f: %.5g\n',PeakSpeed.norm.ttest(4))
    
    fprintf('Paired t-tests: avg. path length (normalized) \n') 
        PathL.norm.ttest(1) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(2,:),'paired');
        PathL.norm.ttest(2) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(3,:),'paired');
        PathL.norm.ttest(3) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(4,:),'paired');
        PathL.norm.ttest(4) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(5,:),'paired');
    fprintf('    ... 0 and 3: %.5g\n',PathL.norm.ttest(1)) % use '%%' to insert percent sign
    fprintf('    ... 0 and 5: %.5g\n',PathL.norm.ttest(2))            
    fprintf('    ... 0 and 8: %.5g\n',PathL.norm.ttest(3))
    fprintf('    ... 0 and 0f: %.5g\n',PathL.norm.ttest(4))
    
    alpha=.05;
    figure(figure_count);
    subplot(1,3,1); 
    hold on;
    testcolor=plot(PrefSpeed.ttest,'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
    plot(PrefSpeed.ttest,'k-','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
    hold on
    testcolor2=plot(PrefSpeed.norm.ttest,'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:));
    plot(PrefSpeed.norm.ttest,'k-','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:))
    plot([0 4], [alpha alpha],'k--')
    xlabel('0-3, 0-5, 0-8, 0-0f'); ylabel('T test paired probability'); 
    legend([testcolor,testcolor2],'Pref Speed','Pref Speed Norm');
    
    figure(figure_count);
    subplot(1,3,2); 
    hold on;
    testcolor=plot(PeakSpeed.ttest,'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
    plot(PeakSpeed.ttest,'k-','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
    hold on
    testcolor2=plot(PeakSpeed.norm.ttest,'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:));
    plot(PeakSpeed.norm.ttest,'k-','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:))
    plot([0 4], [alpha alpha],'k--')
    xlabel('0-3, 0-5, 0-8, 0-0f'); ylabel('T test paired probability'); title('T tests for tomoveback');
    legend([testcolor,testcolor2],'Peak Speed','Peak Speed Norm');
    
    figure(figure_count);
    subplot(1,3,3); 
    hold on;
    testcolor=plot(PathL.ttest,'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
    plot(PathL.ttest,'k-','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
    hold on
    testcolor2=plot(PathL.norm.ttest,'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:));
    plot(PathL.norm.ttest,'k-','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:))
    plot([0 4], [alpha alpha],'k--')
    xlabel('0-3, 0-5, 0-8, 0-0f'); ylabel('T test paired probability');
    legend([testcolor,testcolor2],'PathL','PathL Norm');
        
end
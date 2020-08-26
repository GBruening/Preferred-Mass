% Set someway to loop through all the sections and graph on subplots

%Vthres is velocity TOWARDS target
%Vthres2 is absolute velocity
%Vthres changeda gain, check which using 4-18-2016

section_cells={'all' 'totarget' 'tomoveback' 'back'};
section=section_cells{2};

% if strcmp(conditions{1},'fml')
%     conditions{1}='-2';
% end
% conditions{1}='0';
conditions{1}='2.5';
conditions{2}='3.8';
conditions{3}='4.7';
conditions{4}='6.1';


% conditions{1}='2.4';
% conditions{2}='4.4';
% conditions{3}='5.6';
% conditions{4}='7.5';

graph_folder = [expfolder '\' 'Graphs'];
eps_graph_folder = [expfolder '\' 'Graphs' '\' 'Eps Graphs'];

figure_count = 1;
% %% Reaction Times
% %ordered data with/withoutfml
% %Robstate Reaction Time
% % figure(figure_count);
% Reaction.avg.robstate = mean(Reaction.robstate,2);
% Reaction.ste.robstate = std(Reaction.robstate,[],2)/sqrt(nsubj);
% 
% subplot(1,2,1);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(c,Reaction.robstate(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(Reaction.robstate(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time RobState');
% % legend([ColorPref(:)],subjarray(subjtoload));
% % legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
% axis([0 6 min(min(Reaction.robstate))*.8 max(max(Reaction.robstate))*1.15]); 
% set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
% 
% subplot(1,2,2);
% hold on
% plot(1:nc,Reaction.avg.robstate,'o','Color','k','MarkerFaceColor','k')
% errorbar(1:nc,Reaction.avg.robstate,Reaction.ste.robstate,'k-')
% plot(Reaction.avg.robstate,'k-')
% % plot([0 nc+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time RobState');
% axis([0 nc+1 min(min(Reaction.avg.robstate))*.8 max(max(Reaction.avg.robstate))*1.15]); 
% set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
% 
% % figure_count=figure_count+1;
% 
% %Robstate Reaction Norm
% % figure(figure_count);
% Reaction.avg.robstatenorm = mean(Reaction.norm.robstate,2);
% Reaction.ste.robstatenorm = std(Reaction.norm.robstate,[],2)/sqrt(nsubj);
% 
% subplot(1,2,1);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(c,Reaction.norm.robstate(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(Reaction.norm.robstate(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time RobState NORM');
% %legend([ColorPref(:)],subjarray(subjtoload));
% %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
% axis([0 6 min(min(Reaction.norm.robstate))*.8 max(max(Reaction.norm.robstate))*1.15]); 
% set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
% 
% subplot(1,2,2);
% hold on
% plot(1:nc,Reaction.avg.robstatenorm,'o','Color','k','MarkerFaceColor','k')
% errorbar(1:nc,Reaction.avg.robstatenorm,Reaction.ste.robstatenorm,'k-')
% plot(Reaction.avg.robstatenorm,'k-')
% % plot([0 nc+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time RobState NORM');
% axis([0 nc+1 min(min(Reaction.avg.robstatenorm))*.8 max(max(Reaction.avg.robstatenorm))*1.15]); 
% set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
% 
% % figure_count=figure_count+1;
% 
% %%
% %Athres Reaction Time
% figure(figure_count);
% timings.avg.reactvthres = mean(timings.reaction,2);
% timings.ste.reactvthres = std(timings.reaction,[],2)/sqrt(nsubj);
% 
% subplot(2,2,1);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(str2double(conditions(c)),timings.reaction(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(str2double(conditions),timings.reaction(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Reaction time (s)');
% title('Reaction time Vthres');
% axis([-1 max(str2double(conditions))+1 min(min(timings.reaction))*.8 max(max(timings.reaction))*1.15]); 
% axiscells={'0' '3' '5' '8'};
% set(gca,'XTickLabel',[' ' axiscells ' '],'XTick',[-1,0,3,5,8,9],'TickDir','out')%,'FontSize',14) 
% 
% subplot(2,2,2);
% hold on
% plot([0,3,5,8],timings.avg.reactvthres,'o','Color','k','MarkerFaceColor','k')
% errorbar([0,3,5,8],timings.avg.reactvthres,timings.ste.reactvthres,'k-')
% plot([0,3,5,8],timings.avg.reactvthres,'k-')
% % plot([0 nc+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Reaction time (s)');
% title('Reaction time Vthres');
% axis([-1 max(str2double(conditions))+1 min(min(timings.avg.reactvthres))*.8 max(max(timings.avg.reactvthres))*1.15]); 
% set(gca,'XTickLabel',[' ' axiscells ' '],'XTick',[-1,0,3,5,8,9],'TickDir','out')%,'FontSize',14)
% 
% 
% %Athres Reaction Norm
% % figure(figure_count);
% timings.avg.reactvthresnorm = mean(timings.norm.reaction,2);
% timings.ste.reactvthresnorm = std(timings.norm.reaction,[],2)/sqrt(nsubj);
% 
% subplot(2,2,3);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(str2double(conditions(c)),timings.norm.reaction(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(str2double(conditions),timings.norm.reaction(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Reaction time');
% title('Reaction time Vthres NORM');
% %legend([ColorPref(:)],subjarray(subjtoload));
% %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
% axis([-1 max(str2double(conditions))+1 min(min(timings.norm.reaction))*.8 max(max(timings.norm.reaction))*1.15]); 
% axiscells={'0' '3' '5' '8'};
% set(gca,'XTickLabel',[' ' axiscells ' '],'XTick',[-1,0,3,5,8,9],'TickDir','out')%,'FontSize',14) 
% 
% subplot(2,2,4);
% hold on
% plot([0,3,5,8],timings.avg.reactvthresnorm,'o','Color','k','MarkerFaceColor','k')
% errorbar([0,3,5,8],timings.avg.reactvthresnorm,timings.ste.reactvthresnorm,'k-')
% plot([0,3,5,8],timings.avg.reactvthresnorm,'k-')
% % plot([0 nc+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Reaction time');
% title('Reaction time Vthres NORM');
% axis([-1 max(str2double(conditions))+1 min(min(timings.avg.reactvthresnorm))*.8 max(max(timings.avg.reactvthresnorm))*1.15]); 
% set(gca,'XTickLabel',[' ' axiscells ' '],'XTick',[-1,0,3,5,8,9],'TickDir','out')%,'FontSize',14)
% 
% % figure_count=figure_count+1;
% 
% cd(graph_folder);
% savefig('Reaction Time Athres');
% 
% %% Reaction Times TANGENTIAL VELOCITY tanv
% %ordered data with/withoutfml
% 
% figure(figure_count); clf(figure_count);
% Reaction.avg.tanv = mean(Reaction.tanv,2);
% Reaction.ste.tanv = std(Reaction.tanv,[],2)/sqrt(nsubj);
% 
% subplot(2,2,1);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(str2double(conditions(c)),Reaction.tanv(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(str2double(conditions),Reaction.tanv(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time TanV Thres ');
% axis([min(str2double(conditions)) max(str2double(conditions)) min(min(Reaction.tanv))*.8 max(max(Reaction.tanv))*1.15]);
% % axiscells={'fml' '0' '3' '5' '8'};
% set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% subplot(2,2,2);
% hold on
% plot(str2double(conditions),Reaction.avg.tanv,'o','Color','k','MarkerFaceColor','k')
% errorbar(str2double(conditions),Reaction.avg.tanv,Reaction.ste.tanv,'k-')
% plot(str2double(conditions),Reaction.avg.tanv,'k-')
% % plot([0 nc+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time TanV Thres ')
% axis([min(str2double(conditions)) max(str2double(conditions)) min(min(Reaction.avg.tanv))*.95 max(max(Reaction.avg.tanv))*1.05]);
% % axiscells={'fml' '0' '3' '5' '8'};
% set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% Reaction.avg.tanvnorm = mean(Reaction.norm.tanv,2);
% Reaction.ste.tanvnorm = std(Reaction.norm.tanv,[],2)/sqrt(nsubj);
% 
% subplot(2,2,3);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(str2double(conditions(c)),Reaction.norm.tanv(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(str2double(conditions),Reaction.norm.tanv(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time TanV Thres NorM');
% axis([min(str2double(conditions)) max(str2double(conditions)) min(min(Reaction.avg.tanvnorm))*.9 max(max(Reaction.avg.tanvnorm))*1.15]);
% % axiscells={'fml' '0' '3' '5' '8'};
% set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% subplot(2,2,4);
% hold on
% plot(str2double(conditions),Reaction.avg.tanvnorm,'o','Color','k','MarkerFaceColor','k')
% errorbar(str2double(conditions),Reaction.avg.tanvnorm,Reaction.ste.tanvnorm,'k-')
% plot(str2double(conditions),Reaction.avg.tanvnorm,'k-')
% plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Reaction time (frames, 1 frame=5ms)');
% title('Reaction time TanV Thres NorM');
% axis([min(str2double(conditions)) max(str2double(conditions)) min(min(Reaction.avg.tanvnorm))*.95 max(max(Reaction.avg.tanvnorm))*1.05]); 
% % axiscells={'fml' '0' '3' '5' '8'};
% set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% % figure_count=figure_count+1;
% 
% cd(graph_folder);
% savefig('Reaction Time TanV');
% cd(eps_graph_folder);
% print('Reaction Time TanV','-depsc');
% 
% %%
% 
% %Reaction Difference
% figure(figure_count);clf(figure_count);
% hold on;
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(c,Reaction.dif(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(Reaction.dif(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Difference in reaction time, Robstate - Vthres');
% %legend([ColorPref(:)],subjarray(subjtoload));
% %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
% axis([0 6 min(min(Reaction.dif))*1.15 max(max(Reaction.dif))*.8]); 
% set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
%     
% % figure_count=figure_count+1;
% 
% 
% %% Average speed by condition
% PrefSpeed.avg.(section) = mean(PrefSpeed.(section),2);
% PrefSpeed.ste.(section) = std(PrefSpeed.(section),[],2)/sqrt(nsubj);
% 
% figure(figure_count);clf(figure_count);
%     subplot(2,2,1); hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(str2double(conditions(c)),PrefSpeed.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(str2double(conditions),PrefSpeed.(section)(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Avg speed (m/s)');title(section);
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.15]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     subplot(2,2,2); hold on;
%     plot(str2double(conditions),PrefSpeed.avg.(section),'o','Color','k','MarkerFaceColor','k')
%     errorbar(str2double(conditions),PrefSpeed.avg.(section),PrefSpeed.ste.(section),'k-')
%     xlabel('Condition'); ylabel('Avg speed'); title(section);
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min(PrefSpeed.avg.(section)))*.8 max(max(PrefSpeed.avg.(section)))*1.15]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     PrefSpeed.norm.avg.(section) = mean(PrefSpeed.norm.(section),2);
%     PrefSpeed.norm.ste.(section) = std(PrefSpeed.norm.(section),[],2)/sqrt(nsubj);
% 
%     subplot(2,2,3); hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(str2double(conditions(c)),PrefSpeed.norm.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(str2double(conditions),PrefSpeed.norm.(section)(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Avg speed (m/s), normalized to 0lb');
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min(PrefSpeed.norm.(section)))*.8 max(max(PrefSpeed.norm.(section)))*1.15]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
%     
%     subplot(2,2,4); hold on;
%     plot(str2double(conditions), PrefSpeed.norm.avg.(section),'o','Color','k','MarkerFaceColor','k')
%     errorbar(str2double(conditions), PrefSpeed.norm.avg.(section),PrefSpeed.norm.ste.(section),'k-')
%     plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
%     xlabel('Condition'); ylabel('Avg speed, normalized to 0lb');
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min( PrefSpeed.norm.avg.(section)))*.8 max(max( PrefSpeed.norm.avg.(section)))*1.15]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% %     figure_count=figure_count+1;
%     
%     cd(graph_folder);
%     savefig('Avg Speed by Condition');
%     cd(eps_graph_folder);
%     print('Avg Speed by Condition','-depsc');
    
%% Peak speed by condition
PeakSpeed.avg.(section) = mean(PeakSpeed.(section),2);
PeakSpeed.ste.(section) = std(PeakSpeed.(section),[],2)/sqrt(nsubj);

figure(1);clf(1);
    subplot(2,2,1); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(str2double(conditions(c)),PeakSpeed.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%             ColorPref(subj)=plot(str2double(conditions(c)),PeakSpeed.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(str2double(conditions),PeakSpeed.(section)(:,subj),'k-')
%         plot(str2double(conditions),PeakSpeed.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Peak speed (m/s)');title(section);
%     legend([ColorPref(:)],subjarray(subjtoload));
 %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min(PeakSpeed.(section)))*.8 max(max(PeakSpeed.(section)))*1.15]); 
%     axis([-1 max(str2double(conditions))+1 min(min(PeakSpeed.(section)))*.8 max(max(PeakSpeed.(section)))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

    subplot(2,2,2); hold on;
    plot(str2double(conditions),PeakSpeed.avg.(section),'o','Color','k','MarkerFaceColor','k')
    errorbar(str2double(conditions),PeakSpeed.avg.(section),PeakSpeed.ste.(section),'k-')
    xlabel('Condition'); ylabel('Peak speed'); title(section);
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min(PeakSpeed.avg.(section)))*.8 max(max(PeakSpeed.avg.(section)))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

    PeakSpeed.norm.avg.(section) = mean(PeakSpeed.norm.(section),2);
    PeakSpeed.norm.ste.(section) = std(PeakSpeed.norm.(section),[],2)/sqrt(nsubj);

    subplot(2,2,3); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(str2double(conditions(c)),PeakSpeed.norm.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(str2double(conditions),PeakSpeed.norm.(section)(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Peak speed (m/s), normalized to 0lb');
    %legend([ColorPref(:)],subjarray(subjtoload));
 %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min(PeakSpeed.norm.(section)))*.8 max(max(PeakSpeed.norm.(section)))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

    subplot(2,2,4); hold on;
    plot(str2double(conditions), PeakSpeed.norm.avg.(section),'o','Color','k','MarkerFaceColor','k')
    errorbar(str2double(conditions), PeakSpeed.norm.avg.(section),PeakSpeed.norm.ste.(section),'k-')
    plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Peak speed, normalized to 0lb');
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min( PeakSpeed.norm.avg.(section)))*.8 max(max( PeakSpeed.norm.avg.(section)))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

%     figure_count=figure_count+1;
    
    cd(graph_folder);
    savefig('PeakSpeed by Condition');
    cd(eps_graph_folder);
    print('PeakSpeed by Condition','-depsc');
    
    %% Movement Duration by condition
    timings.avg.reacttotar = mean(timings.reacttotar,2);
    timings.ste.reacttotar = std(timings.reacttotar,[],2)/sqrt(nsubj);

    figure(figure_count);clf(figure_count);
    subplot(2,2,1); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(str2double(conditions(c)),timings.reacttotar(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(str2double(conditions),timings.reacttotar(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Movement Duration (s)');title(section);
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min(timings.reacttotar))*.8 max(max(timings.reacttotar))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

    subplot(2,2,2); hold on;
    plot(str2double(conditions),timings.avg.reacttotar,'o','Color','k','MarkerFaceColor','k')
    errorbar(str2double(conditions),timings.avg.reacttotar,timings.ste.reacttotar,'k-')
    xlabel('Condition'); ylabel('Movement Duration (s)'); title(section);
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min(timings.avg.reacttotar))*.8 max(max(timings.avg.reacttotar))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

    timings.avg.norm.reacttotar = mean(timings.norm.reacttotar,2);
    timings.ste.norm.reacttotar = std(timings.norm.reacttotar,[],2)/sqrt(nsubj);

    subplot(2,2,3); hold on;
    for subj=1:nsubj
        for c=1:nc
            ColorPref(subj)=plot(str2double(conditions(c)),timings.norm.reacttotar(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
        end
        plot(str2double(conditions),timings.norm.reacttotar(:,subj),'k-')
    end
    xlabel('Condition'); ylabel('Movement Duration (s), normalized to 0lb');
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min(timings.norm.reacttotar))*.8 max(max(timings.norm.reacttotar))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

    subplot(2,2,4); hold on;
    plot(str2double(conditions), timings.avg.norm.reacttotar,'o','Color','k','MarkerFaceColor','k')
    errorbar(str2double(conditions), timings.avg.norm.reacttotar,timings.ste.norm.reacttotar,'k-')
    plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
    xlabel('Condition'); ylabel('Movement Duration (s), normalized to 0lb');
    axis([min(str2double(conditions)) max(str2double(conditions)) min(min( timings.avg.norm.reacttotar))*.8 max(max( timings.avg.norm.reacttotar))*1.15]); 
    set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)

%     figure_count=figure_count+1;
    
    cd(graph_folder);
    savefig('Movement Duration by Condition');
    cd(eps_graph_folder);
    print('Movement Duration by Condition','-depsc');
    
% %% Average path length by condition
% % Need to edit for stuctures instead of arrays
% section='totarget';
% PathL_avg = mean(PathL.(section),2);
% PathL_ste = std(PathL.(section),[],2)/sqrt(nsubj);
% 
% figure(figure_count);clf(figure_count);
%     subplot(1,2,1); hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPath(subj)=plot(c,PathL.(section)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(PathL.(section)(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Path Length (m)');title('Full Movement');
%     axis([0 nc+1 min(min(PathL.(section)))*.95 max(max(PathL.(section)))*1.05]);
% %    legend([ColorPath(:)],'Foof','Nathan','Rob','Hannah');
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     subplot(1,2,2); hold on;title(section);
%     plot(1:nc,PathL_avg,'o','Color','k','MarkerFaceColor','k')
%     errorbar(1:nc,PathL_avg,PathL_ste,'k-')
%     plot([0 nc+1], [1 1],'k--')
%     xlabel('Condition'); ylabel('Avg path length');title('Full Movement');
%     axis([0 nc+1 min(min(PathL_avg))*.95 max(max(PathL_avg))*1.05]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     figure_count=figure_count+1;
% 
% %% Max Excursion by condition
% MaxEx.avg = mean(MaxEx.average,2);
% MaxEx.ste = std(MaxEx.average,[],2)/sqrt(nsubj);
% 
% figure(figure_count);clf(figure_count);
%     subplot(2,2,1); hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(str2double(conditions(c)),MaxEx.average(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(str2double(conditions),MaxEx.average(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Max Excursion (m)'); title(section);
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min(MaxEx.average))*.95 max(max(MaxEx.average))*1.05]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     subplot(2,2,2); hold on;
%     plot(str2double(conditions),MaxEx.avg,'o','Color','k','MarkerFaceColor','k')
%     errorbar(str2double(conditions),MaxEx.avg,MaxEx.ste,'k-')
%     xlabel('Condition'); ylabel('Max Excursion (m)'); title(section);
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min(MaxEx.avg))*.95 max(max(MaxEx.avg))*1.05]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     MaxEx.Normavg = mean(MaxEx.Norm,2);
%     MaxEx.Normste = std(MaxEx.Norm,[],2)/sqrt(nsubj);
% 
%     subplot(2,2,3); hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(str2double(conditions(c)),MaxEx.Norm(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(str2double(conditions),MaxEx.Norm(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Max Excursion (m)'); title(section);
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min(MaxEx.Norm))*.95 max(max(MaxEx.Norm))*1.05]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     subplot(2,2,4); hold on;
%     plot(str2double(conditions), MaxEx.Normavg,'o','Color','k','MarkerFaceColor','k')
%     errorbar(str2double(conditions), MaxEx.Normavg,MaxEx.Normste,'k-')
%     plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
%     xlabel('Condition'); ylabel('Max Excursion (m)'); title(section);
%     axis([min(str2double(conditions)) max(str2double(conditions)) min(min( MaxEx.Normavg))*.95 max(max( MaxEx.Normavg))*1.05]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
%     cd(graph_folder);
%     savefig('MaxExcursion by Condition');
%     cd(eps_graph_folder);
%     print('MaxExcursion by Condition','-depsc');
% 
% % figure_count=figure_count+1;
% 
% %% Max Excursion Variance
% %wyut
% MaxEx.VarNormavg = mean(MaxEx.VarNorm,2);
% MaxEx.VarNormste = std(MaxEx.VarNorm,[],2)/sqrt(nsubj);
% 
% subplot(1,2,1);
% hold on
% for subj=1:nsubj
%     for c=1:nc
%         ColorPref(subj)=plot(str2double(conditions(c)),MaxEx.VarNorm(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
%     plot(str2double(conditions),MaxEx.VarNorm(:,subj),'k-')
% end
% 
% xlabel('Condition'); ylabel('Max Excursion Variance');
% title('Max Excursion Variance');
% axis([min(str2double(conditions)) max(str2double(conditions)) min(min(MaxEx.VarNorm))*.8 max(max(MaxEx.VarNorm))*1.15]);
% set(gca,'XTickLabel',[ conditions ],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% 
% subplot(1,2,2);
% hold on
% plot(str2double(conditions),MaxEx.VarNormavg,'o','Color','k','MarkerFaceColor','k')
% errorbar(str2double(conditions),MaxEx.VarNormavg,MaxEx.VarNormste,'k-')
% plot(str2double(conditions),MaxEx.VarNormavg,'k-')
% plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
% xlabel('Condition'); ylabel('Max Excursion Variance');
% title('Max Excursion Variance');
% axis([min(str2double(conditions)) max(str2double(conditions)) min(min(MaxEx.VarNormavg))*.93 max(max(MaxEx.VarNormavg))*1.08]);
% set(gca,'XTickLabel',[conditions],'XTick',[str2double(conditions)],'TickDir','out')%,'FontSize',14)
% 
% %% Miss Angle Variance
% figure(2); clf(2);hold on;
% Miss.angle_comb = zeros(nc,nsubj*200);
% for c=1:nc
%     for subj=1:nsubj
%         Miss.angle_comb(c,200*(subj-1)+1:200*subj) = [Data{c,subj}.miss_angle];
%     end
% end
% 
% for c=1:nc
%     bar(str2double(conditions(c)),std(Miss.angle_comb(c,:)));
% end
% 
% xlabel('Mass Condition (kg)');ylabel('Standard Deviation of miss angle');
% 
% %% OverShoots
% 
% 
% figure(figure_count);clf(figure_count);
% for subj = 1:nsubj
%     subjid = subjarray{subjtoload(subj)};
%     %Curve related metrics
% 
%     % Write a loop for the different conditions, c, and trials, i. 
%     % I'm using v, where v = (vx^2+xy^2)^0.5 (see lin 118)
% 
% %    nTrials_speed = 200; % look at last X trials only; for all, popts.totaltrials
%     for c=1:nc
%         tic
%         if (strcmp(DataSelect,DataSet(1)) | strcmp(DataSelect,DataSet(2)))
%             condition=char(conditions(c));
%             if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
%                 c=2;
%                 condition=char(conditions(c));
%             end
%         elseif strcmp(DataSelect,DataSet(3))
%             condition=char(conditions{subj}(c));
%             if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
%                 c=2;
%                 condition=char(conditions{subj}(c));
%             end
%         end
%         tr_count = 1;
%         
%         
%         if strcmp(DataSetsSelect,'Pilot')
%             if strcmp(condition,'fml')
%                 popts.totaltrials=100;
%                 nTrials_speed=100;
%                 Data{c,subj}.stateframes=zeros([8,100]);
%             elseif ~strcmp(condition,'fml')
%                 popts.totaltrials=200;
%                 nTrials_speed=150;
%                 Data{c,subj}.stateframes=zeros([8,200]);
%             end
%         elseif strcmp(DataSetsSelect,'Not_Pilot')
%             if strcmp(condition,'fml')
%                 popts.totaltrials=400;
%                 nTrials_speed=350;
%                 Data{c,subj}.stateframes=zeros([8,400]);
%             elseif ~strcmp(condition,'fml')
%                 popts.totaltrials=200;
%                 nTrials_speed=150;
%                 Data{c,subj}.stateframes=zeros([8,200]);
%             end
%         end
%         
%         Data{c,subj}.overshoot=0;
%          
%         for i = 1:popts.totaltrials
%             if max(Data{c,subj}.P(:,i))>.11
%                 Data{c,subj}.overshoot=Data{c,subj}.overshoot+1;
%             end
%         end
%         
%         OverShoot(c,subj)=Data{c,subj}.overshoot;
%         
%         
%     end
% end
% 
% bar(transpose(OverShoot))
% legend({'fml' '0' '3' '5' '8'})
% ylabel('Number of OverShoots');
% xlabel('Subject number');
% title('OverShoot Counter');
% 
% % hold on;
% % for subj=1:nsubj
% %     subplot(1,nsubj,subj);
% %     for c=1:nc
% %         ColorPref(subj)=bar(str2double(conditions(c)),Data{c,subj}.overshoot);%,'Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
% %     end
% % end
% 
% cd(graph_folder);
% savefig('OverShoot Counts');
%     
% %% Accuracy to Speed
% Miss.avg.angle = mean(Miss.angle,2);
% Miss.ste.angle = std(Miss.angle,[],2)/sqrt(nsubj);
% 
% figure(figure_count);clf(figure_count);
% hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPeak(subj)=plot(PrefSpeed.(section)(c,subj),Miss.angle(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%     end
%     xlabel('PrefSpeed For condition'); ylabel('Miss Angle (rad)');title(section);
% %    axis([min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.2 min(min(Miss.avg.angle))*.8 max(max(Miss.avg.angle))*1.15]);
% %     figure_count=figure_count+1;
% %     
% % figure(figure_count);
% hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPeak(subj)=plot(PeakSpeed.(section)(c,subj),Miss.angle(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%     end
%     xlabel('PeakSpeed For condition'); ylabel('Miss Angle (rad)');title(section);
% %    axis([min(min(PrefSpeed.(section)))*.8 max(max(PrefSpeed.(section)))*1.2 min(min(Miss.avg.angle))*.8 max(max(Miss.avg.angle))*1.15]);
%     figure_count=figure_count+1;
%     
%     cd(graph_folder);
%     savefig('Speed To Accuracy');
%     
% %% Condition to Accuracy
% % Degrees missed by variable
% variable = 'corr_angle';
% Miss.avg.(variable) = mean(Miss.(variable),2);
% Miss.ste.(variable) = std(Miss.(variable),[],2)/sqrt(nsubj);
% 
% figure(figure_count);
% subplot(1,2,1);
% hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPeak(subj)=plot(c,Miss.(variable)(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(Miss.(variable)(:,subj),'k-');
%     end
%     
%     xlabel('Condition');ylabel(strcat(variable, ' (deg)'));title(strcat(variable, ' (deg)'));
%     axis([0 nc+1 min(min(Miss.(variable)))*1.05 max(max(Miss.(variable)))*1.05]);
%     set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
% 
%     
% figure(figure_count);
% subplot(1,2,2);
% hold on;
% 
% plot(1:nc,Miss.avg.(variable),'o','Color','k','MarkerFaceColor','k');
% errorbar(1:nc,Miss.avg.(variable),Miss.ste.(variable),'k-')
% axis([0 nc+1 min(min(Miss.avg.(variable)))*.7 max(max(Miss.avg.(variable)))*1.3]); 
% xlabel('Condition');ylabel(strcat(variable, ' (deg)'));title(strcat(variable, ' (deg)'));
% set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5])%,'FontSize',14)
% figure_count=figure_count+1;
% 
%     cd(graph_folder);
%     savefig('Condition to Accuracy');
%     
%     %% Average miss distance/angle by condition
% figure(figure_count);
%     subplot(1,2,1);
%     hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(c,Miss.Dist(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%         end
%         plot(Miss.Dist(:,subj),'k-')
%     end
%     xlabel('Condition'); ylabel('Miss Distance (cm)');
%     %legend([ColorPref(:)],subjarray(subjtoload));
%  %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
%     axis([0 6 min(min(Miss.Dist))*.8 max(max(Miss.Dist))*1.15]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
%     
%     figure(figure_count);
% subplot(1,2,2);
%     hold on;
%     for subj=1:nsubj
%         for c=1:nc
%             ColorPref(subj)=plot(c,Miss.angle(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%        
%         end
%         plot(Miss.angle(:,subj),'k-','Color',ColorSet(subj,:))
%     end
%     xlabel('Condition'); ylabel('Miss Angle (radians)');
%     %legend([ColorPref(:)],subjarray(subjtoload));
%  %   legend([ColorPref(:)],'Foof','Nathan','Rob','Hannah');
%     axis([0 6 min(min(Miss.angle))*.8 max(max(Miss.angle))*1.15]); 
%     set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
%     
%     
% %     subplot(1,2,2); hold on;
% %     plot(1:nc,PrefSpeed_norm_avg,'o','Color','k','MarkerFaceColor','k')
% %     errorbar(1:nc,PrefSpeed_norm_avg,PrefSpeed_norm_ste,'k-')
% %     plot(PrefSpeed_norm_avg,'k-')
% %     plot([0 nc+1], [1 1],'k--')
% %     xlabel('Condition'); ylabel('Avg speed, normalized to 0lb');
% %     axis([0 nc+1 min(min(MissDist))*.8 max(max(MissDist))*1.15]); 
% %     set(gca,'XTickLabel',[conditions],'XTick',[0,1,2,3,4,5,6])%,'FontSize',14)
% figure_count=figure_count+1;
% 
%     cd(graph_folder);
%     savefig('Condition to Miss Distance');
% 
%     
% %% Stats (Bonferoni correction???)
% if nsubj > 1
%     fprintf('\n ********************** STATS NOT NORMALIZED **********************  \n')
%     fprintf('Paired t-tests: avg. preferred speed (not normalized) \n') 
%  %PrefSpeed.test.section(1) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(2,:),'paired');
%         
%         PrefSpeed.test(1) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(2,:),'paired');
%         PrefSpeed.test(2) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(3,:),'paired');
%         PrefSpeed.test(3) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(4,:),'paired');
%         PrefSpeed.test(4) = megansttest(PrefSpeed.(section)(1,:),PrefSpeed.(section)(5,:),'paired');
%     fprintf('    ... 0 and 3: %.5g\n',PrefSpeed.test(1)) % use '%%' to insert percent sign
%     fprintf('    ... 0 and 5: %.5g\n',PrefSpeed.test(2))            
%     fprintf('    ... 0 and 8: %.5g\n',PrefSpeed.test(3))
%     fprintf('    ... 0 and 0f: %.5g\n',PrefSpeed.test(4))
%     
%     fprintf('Paired t-tests: avg. peak speed (not normalized) \n') 
%         PeakSpeed.test(1) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(2,:),'paired');
%         PeakSpeed.test(2) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(3,:),'paired');
%         PeakSpeed.test(3) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(4,:),'paired');
%         PeakSpeed.test(4) = megansttest(PeakSpeed.(section)(1,:),PeakSpeed.(section)(5,:),'paired');
%     fprintf('    ... 0 and 3: %.5g\n',PeakSpeed.test(1)) % use '%%' to insert percent sign
%     fprintf('    ... 0 and 5: %.5g\n',PeakSpeed.test(2))            
%     fprintf('    ... 0 and 8: %.5g\n',PeakSpeed.test(3))
%     fprintf('    ... 0 and 0f: %.5g\n',PeakSpeed.test(4))
%     
%     fprintf('Paired t-tests: avg. path length (not normalized) \n') 
%         PathL.test(1) = megansttest(PathL.(section)(1,:),PathL.(section)(2,:),'paired');
%         PathL.test(2) = megansttest(PathL.(section)(1,:),PathL.(section)(3,:),'paired');
%         PathL.test(3) = megansttest(PathL.(section)(1,:),PathL.(section)(4,:),'paired');
%         PathL.test(4) = megansttest(PathL.(section)(1,:),PathL.(section)(5,:),'paired');
%     fprintf('    ... 0 and 3: %.5g\n',PathL.test(1)) % use '%%' to insert percent sign
%     fprintf('    ... 0 and 5: %.5g\n',PathL.test(2))            
%     fprintf('    ... 0 and 8: %.5g\n',PathL.test(3))
%     fprintf('    ... 0 and 0f: %.5g\n',PathL.test(4))
%     
%     fprintf('\n ********************** STATS NORMALIZED **********************  \n')
%     fprintf('Paired t-tests: avg. preferred speed (normalized) \n') 
%         PrefSpeed.norm.test(1) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(2,:),'paired');
%         PrefSpeed.norm.test(2) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(3,:),'paired');
%         PrefSpeed.norm.test(3) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(4,:),'paired');
%         PrefSpeed.norm.test(4) = megansttest(PrefSpeed.norm.(section)(1,:),PrefSpeed.norm.(section)(5,:),'paired');
%     fprintf('    ... 0 and 3: %.5g\n',PrefSpeed.norm.test(1)) % use '%%' to insert percent sign
%     fprintf('    ... 0 and 5: %.5g\n',PrefSpeed.norm.test(2))            
%     fprintf('    ... 0 and 8: %.5g\n',PrefSpeed.norm.test(3))
%     fprintf('    ... 0 and 0f: %.5g\n',PrefSpeed.norm.test(4))
%     
%     fprintf('Paired t-tests: avg. peak speed (normalized) \n') 
%         PeakSpeed.norm.test(1) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(2,:),'paired');
%         PeakSpeed.norm.test(2) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(3,:),'paired');
%         PeakSpeed.norm.test(3) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(4,:),'paired');
%         PeakSpeed.norm.test(4) = megansttest(PeakSpeed.norm.(section)(1,:),PeakSpeed.norm.(section)(5,:),'paired');
%     fprintf('    ... 0 and 3: %.5g\n',PeakSpeed.norm.test(1)) % use '%%' to insert percent sign
%     fprintf('    ... 0 and 5: %.5g\n',PeakSpeed.norm.test(2))            
%     fprintf('    ... 0 and 8: %.5g\n',PeakSpeed.norm.test(3))
%     fprintf('    ... 0 and 0f: %.5g\n',PeakSpeed.norm.test(4))
%     
%     fprintf('Paired t-tests: avg. path length (normalized) \n') 
%         PathL.norm.test(1) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(2,:),'paired');
%         PathL.norm.test(2) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(3,:),'paired');
%         PathL.norm.test(3) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(4,:),'paired');
%         PathL.norm.test(4) = megansttest(PathL.norm.(section)(1,:),PathL.norm.(section)(5,:),'paired');
%     fprintf('    ... 0 and 3: %.5g\n',PathL.norm.test(1)) % use '%%' to insert percent sign
%     fprintf('    ... 0 and 5: %.5g\n',PathL.norm.test(2))            
%     fprintf('    ... 0 and 8: %.5g\n',PathL.norm.test(3))
%     fprintf('    ... 0 and 0f: %.5g\n',PathL.norm.test(4))
%     
%     alpha=.05;
%     figure(figure_count);
%     subplot(1,3,1); 
%     hold on;
%     testcolor=plot(PrefSpeed.test,'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
%     plot(PrefSpeed.test,'k-','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
%     hold on
%     testcolor2=plot(PrefSpeed.norm.test,'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:));
%     plot(PrefSpeed.norm.test,'k-','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:))
%     plot([0 4], [alpha alpha],'k--')
%     xlabel('0-3, 0-5, 0-8, 0-0f'); ylabel('T test paired probability'); 
%     legend([testcolor,testcolor2],'Pref Speed','Pref Speed Norm');
%     
%     figure(figure_count);
%     subplot(1,3,2); 
%     hold on;
%     testcolor=plot(PeakSpeed.test,'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
%     plot(PeakSpeed.test,'k-','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
%     hold on
%     testcolor2=plot(PeakSpeed.norm.test,'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:));
%     plot(PeakSpeed.norm.test,'k-','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:))
%     plot([0 4], [alpha alpha],'k--')
%     xlabel('0-3, 0-5, 0-8, 0-0f'); ylabel('T test paired probability'); title('T tests for tomoveback');
%     legend([testcolor,testcolor2],'Peak Speed','Peak Speed Norm');
%     
%     figure(figure_count);
%     subplot(1,3,3); 
%     hold on;
%     testcolor=plot(PathL.test,'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
%     plot(PathL.test,'k-','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:));
%     hold on
%     testcolor2=plot(PathL.norm.test,'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:));
%     plot(PathL.norm.test,'k-','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:))
%     plot([0 4], [alpha alpha],'k--')
%     xlabel('0-3, 0-5, 0-8, 0-0f'); ylabel('T test paired probability');
%     legend([testcolor,testcolor2],'PathL','PathL Norm');
%         
% end
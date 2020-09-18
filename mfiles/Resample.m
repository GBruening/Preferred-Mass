% Load data file without FML, make sure to change the experiment variable
% for saving the data.

%% My Onset
clear all

DataSets={'Pilot' 'ArcT' '2018'};
exp_labs = {'pilot','smallt','pref'};
% datafiles = {'Pilot_Data-UnorderednoFML',...
%     'DataArcT-UnorderednoFML',...
%     '2018Data-UnorderednoFML'};
datafiles = {'Pilot_Data-UnorderedwithFML',...
    'DataArcT-UnorderedwithFML',...
    '2018Data-UnorderedwithFML'};
basedir = 'F:\Google Drive\Preferred Mass';
for L = [1]%,1]
    DataSetsSelect=DataSets{L};
    cd(strcat(basedir,'\Data'));
    clearvars -except DataSetsSelect exp_labs DataSets datafiles L basedir
    fprintf('Loading %s\n',datafiles{L});
    load(datafiles{L});
    
    indexs = {'idxonset',...
        'idxvthresh_onset',...
        'robotstates.wait4mvt',...
        'idxonsetErik',...
        'idxonset_extrap'};
    index_labs = {'onset','vthresh','wait4mvt','erik','exttrap'};
%     xlabs = {'Frames Around Reaction (Reaction = 20 Frames)',...
%         'Frames Around Reaction (Reaction = 20 Frames)'...
%         'Frames Around Target Show (Target Show = 0 Frames)'};
    xlabs = {'Time Around Reaction',...
        'Time Around Reaction',...
        'Time Around Target Show',...
        'Time Around Reaction',...
        'Time Around Reaction'};
    titles = {'Velocity Around Reaction (Mine).'...
        'Velocity Around Reaction (vthresh).'...
        'Velocity around target show.',...
        'Velocity Around Reaction (Erik).'...
        'Velocity Around Reaction (ExTrap).'};

    experiment = exp_labs{L};

%     masses = {'fml','0','3','5','8','0f'};
    masses = {'0','3','5','8'};
    for j = 1:length(indexs)

        clear ResampleDataReactVel ResampleDataReactVel2
        clear SpmP_abs SpmV_abs SpmC_abs SpmS_abs SpmVabs_abs SpmVsign_abs

        indexmax = 0;
        tr_count2=1;
        for c=1:4  
            tr_count=1;
            for subj=1:nsubj
                mass_c = find(strcmp(masses,condition{c,subj}));
                for i=51:2:eval(strcat('length(MT{c,subj}.',indexs{j},')'))
                    if ~strcmp(indexs{j},'robotstates.wait4mvt')
                        index = MT{c,subj}.(indexs{j})(i);
                    else
                        index = eval(strcat('MT{c,subj}.',indexs{j},'(i)+20'));
                    end
                    if index>20
                        counter=1;
                        for k=-20:1:300
                            if (index+k)<length(Data{c,subj}.v(:,i)) && ~isnan(Data{c,subj}.v(index+k,i))
                                ResampleDataReactVel(mass_c,tr_count,counter) = Data{c,subj}.TanV(index+k,i);
                                SpmP_abs(tr_count2,counter) = abs(Data{c,subj}.P_abs(index+k,i));
                                SpmV_abs(tr_count2,counter) = Data{c,subj}.TanV(index+k,i);
                                SpmVabs_abs(tr_count2,counter) = Data{c,subj}.v(index+k,i);
                                SpmVsign_abs(tr_count2,counter) = Data{c,subj}.v_sign(index+k,i);
                            else
                                ResampleDataReactVel(mass_c,tr_count,counter) = 0;
                                SpmP_abs(tr_count2,counter) = 0;
                                SpmV_abs(tr_count2,counter) = 0;
                            end
                            counter=counter+1;
                        end
                        SpmC1_abs(tr_count2) = str2double(condition{c,subj});
                        SpmC_abs(tr_count2) = str2double(condition{c,subj});
                        SpmS_abs(tr_count2) = subj;
                        SpmM_abs(tr_count2) = 1;
                        SpmT_abs(tr_count2) = Data{c,subj}.targetnumber(i);
                        tr_count2=tr_count2+1;
                    else
                    end
                    ResampleReactionFrame(mass_c,tr_count) = MT{c,subj}.idxonset(i)-MT{c,subj}.robotstates.wait4mvt(i);
                    ResampleTargetFrame(mass_c,tr_count) = MT{c,subj}.idxtarget(i)-MT{c,subj}.robotstates.wait4mvt(i);
                    tr_count=tr_count+1;
                end
            end
        end

        clear a
        for c=1:4
            for k = 1:300
                ResampleDataReactVel2(c,k)=nanmean(ResampleDataReactVel(c,:,k));
                a(c,k) = nanmean(ResampleDataReactVel(c,:,k));
            end
            ResampleDataReactFrame(c) = floor(nanmean(ResampleReactionFrame(c,:)));
            ResampleDataTargetFrame(c) = floor(nanmean(ResampleTargetFrame(c,:)));
        end
        
        fprintf('Plotting %s \n', strcat('Resample_data_',experiment,'_abs_',index_labs{j}))
        figure(61+j);clf(61+j);
        hold on;
        ColorSet = [0,0,0;hot(17)];
        for c=1:4
%             if c==1
%                 ColorPref(c)=plot(ResampleDataReactVel2(c,1:end),'Color',ColorSet(1,:),'LineWidth',3);%[-20:k-21],
%             elseif c == 6
%                 ColorPref(c)=plot(ResampleDataReactVel2(c,1:end),'Color','blue','LineWidth',3);%[-20:k-21],
%             else
                ColorPref(c)=plot(ResampleDataReactVel2(c,1:end),'Color',ColorSet((-c*2)+14,:),'LineWidth',3);%[-20:k-21],
%             end
        %     plot(ResampleDataReactFrame(c),ResampleDataReactVel2(c,ResampleDataReactFrame(c)),'o','Color',ColorSet(c*3,:))
            [maxv,idx]=max(ResampleDataReactVel2(c,:));
            plot(idx,maxv,'o','Color',ColorSet(c,:))
            if ~strcmp(indexs{j},'robotstates.wait4mvt')
                plot(20,ResampleDataReactVel2(c,20),'*','Color',ColorSet(c,:),'MarkerSize',15,'LineWidth',4)
            end
        end
%         legend([ColorPref(:)],condition{1:4});
        legend([ColorPref(:)],{'fml','0','3','5','8','0f'});
        xlabel(xlabs{j});
        xticks([0, 20, 60, 100, 140, 180, 220, 260, 300]);
        xticklabels((xticks-20)/200);
        ylabel('Velocity (m/s)');
        title(titles{j});
        fprintf('Done with %s.\n',indexs{j});
        cd(strcat(basedir,'\Graphs\resamp_graphs_fml'));
        savefig(strcat('Resample_fig_',experiment,'_abs_',index_labs{j}));
        
%         fprintf('Saving SPM %s \n', strcat('Resample_data_',experiment,'_abs_fml_',index_labs{j},'.mat'));
%         cd(strcat(basedir,'\Data'));
%         save(strcat('Resample_data_',experiment,'_abs_',index_labs{j},'.mat'),...
%             'SpmC1_abs',...
%             'SpmC_abs',...
%             'SpmM_abs',...
%             'SpmP_abs',...
%             'SpmS_abs',...
%             'SpmT_abs',...
%             'SpmV_abs',...
%             'SpmVabs_abs',...
%             'SpmVsign_abs')
%         drawnow;
    end 
end

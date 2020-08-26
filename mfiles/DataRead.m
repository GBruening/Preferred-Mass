% Basic script that analyzes robot data
% Experiment type: by conditions (ex. speed)

% Version 1. HJH
% updated get_mvttimes to specify which velocity to use (ex. Vx, Vy, or V)

% statedata
% 1 viewmenu    5 movingout     9  intertrial     13 exitgame
% 2 startgame   6 attarget      10 warning
% 3 home        7 finishmvt     11 game_message
% 4 wait4mvt    8 movingback    12 rest

%%%### Figures have been excluded and have been commented out using '%%%###'

% clear
% clc
% close all
global plot_graphs
plot_graphs = 0;
%% Experiment specific details
if exist('C:\Users\Gary\Documents\School Notes\Grad School\','dir')
    projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
elseif exist('F:\Documents\School notes\Grad School\','dir');
    projpath = 'F:\Documents\School notes\Grad School\';
elseif exist('D:\Users\Gary\Documents\School Notes\Grad School\','dir');
    projpath = 'D:\Users\Gary\Documents\School Notes\Grad School\';
end
% projpath = 'F:\Documents\School notes\Grad School\';
% projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
projpath = 'D:\Users\Gary\Google Drive\';

expname = 'Preferred Mass';
expname2 = 'Mass';
addpath([projpath expname filesep 'mfiles']);


%Which Data, Pilot or Second
DataSets={'Pilot' 'ArcT' '2018'};
% DataSetsSelect=DataSets{3};

if strcmp(DataSetsSelect,'Pilot')
    datafolder_names = ['D:\Users\Gary\Documents\School Notes\Grad School\Mass' filesep 'Pilot_data'];
elseif strcmp(DataSetsSelect,'ArcT')
    datafolder_names = ['D:\Users\Gary\Documents\School Notes\Grad School\Mass' filesep 'Data'];
elseif strcmp(DataSetsSelect,'2018')
    datafolder_names = ['D:\Users\Gary\Documents\School Notes\Grad School\Mass' filesep '2018Data'];
end
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);

%Choose which order to read (control, ordered, unordered)
DataSet={'Control' 'Ordered' 'Unordered'};
DataSelect=DataSet(3);

%Choose if with fml or not
famil={'withFML' 'noFML'};
familSelect=famil(2);

if strcmp(DataSetsSelect,'Pilot')
    filename = char(strcat('Pilot_Data-',DataSelect,familSelect));
elseif strcmp(DataSetsSelect,'ArcT')
    filename = char(strcat('DataArcT-',DataSelect,familSelect));
elseif strcmp(DataSetsSelect,'2018')
    filename = char(strcat(DataSetsSelect,'Data-',DataSelect,familSelect));
end
fprintf('%s \n',filename);

%Pulls the names of the data from the data folder and stores in an array
cd(datafolder_names);
[status,list]=system('dir /B');
list=textscan(list,'%s','delimiter','/n');

if strcmp(DataSetsSelect,DataSets(3))
    if strcmp(DataSelect,DataSet(2))
        subjarray=list{1};
        subjtoload = 1:length(subjarray);
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions={'0' '3' '5' '8'};
            nc=length(conditions);
        elseif strcmp(familSelect,famil(1))
            conditions={'fml' '0' '3' '5' '8'};
            nc=length(conditions);
        end
    end
    if strcmp(DataSelect,DataSet(3))
        subjarray=list{1};
        subjtoload = 1:length(list{1});
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions{1} = {'3' '0' '8' '5'};
            conditions{2} = {'0' '5' '3' '8'};
            conditions{3} = {'5' '8' '0' '3'};
            conditions{4} = {'8' '3' '5' '0'};
            conditions{5} = {'8' '0' '3' '5'};
            conditions{6} = {'3' '5' '0' '8'};
            conditions{7} = {'8' '5' '0' '3'};
            conditions{8} = {'5' '3' '8' '0'};
            conditions{9} = {'0' '3' '8' '5'};
            conditions{10} = {'3' '0' '5' '8'};
            conditions{11} = {'5' '8' '3' '0'};
            conditions{12} = {'0' '8' '5' '3'};
            nc=length(conditions{1});
        elseif strcmp(familSelect,famil(1))
            conditions{1} = {'fml' '3' '0' '8' '5'};
            conditions{2} = {'fml' '0' '5' '3' '8'};
            conditions{3} = {'fml' '5' '8' '0' '3'};
            conditions{4} = {'fml' '8' '3' '5' '0'};
            conditions{5} = {'fml' '8' '0' '3' '5'};
            conditions{6} = {'fml' '3' '5' '0' '8'};
            conditions{7} = {'fml' '8' '5' '0' '3'};
            conditions{8} = {'fml' '5' '3' '8' '0'};
            conditions{9} = {'fml' '0' '3' '8' '5'};
            conditions{10} = {'fml' '3' '0' '5' '8'};
            conditions{11} = {'fml' '5' '8' '3' '0'};
            conditions{12} = {'fml' '0' '8' '5' '3'};
            nc=length(conditions{1});
        end
    end
end

if strcmp(DataSetsSelect,DataSets(1))
    if strcmp(DataSelect,DataSet(1))
        subjarray=list{1}(19:22);
        subjtoload = 1:4;
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(1))
            conditions={'01' '02' '03' '04' '05'};
            nc=length(conditions);
        elseif strcmp(familSelect,famil(1))
            conditions={'fml' '01' '02' '03' '04' '05'};
            nc=length(conditions);
        end
    elseif strcmp(DataSelect,DataSet(2))
        subjarray=list{1}(1:18);  
        subjtoload = 1:18;
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions={'0' '3' '5' '8' '0f'};
            nc=length(conditions);
        elseif strcmp(familSelect,famil(1))
            conditions={'fml' '0' '3' '5' '8' '0f'};
            nc=length(conditions);
        end
    elseif strcmp(DataSelect,DataSet(3))
        subjarray=list{1}(1:18);
        subjtoload = 1:18;
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions{1}={'0' '5' '3' '8' '0f'};
            conditions{2}={'0' '3' '8' '5' '0f'};
            conditions{3}={'0' '3' '5' '8' '0f'};
            conditions{4}={'0' '5' '8' '3' '0f'};
            conditions{5}={'0' '8' '3' '5' '0f'};
            conditions{6}={'0' '8' '5' '3' '0f'};
            conditions{7}={'0' '3' '5' '8' '0f'};
            conditions{8}={'0' '3' '8' '5' '0f'};
            conditions{9}={'0' '5' '3' '8' '0f'};
            conditions{10}={'0' '5' '8' '3' '0f'};
            conditions{11}={'0' '8' '3' '5' '0f'};
            conditions{12}={'0' '8' '5' '3' '0f'};
            conditions{13}={'0' '3' '5' '8' '0f'};
            conditions{14}={'0' '3' '8' '5' '0f'};
            conditions{15}={'0' '5' '8' '3' '0f'};
            conditions{16}={'0' '5' '3' '8' '0f'};
            conditions{17}={'0' '8' '3' '5' '0f'};
            conditions{18}={'0' '8' '5' '3' '0f'};
            nc = length(conditions{1});
        elseif strcmp(familSelect,famil(1))
            conditions{1}={'fml' '0' '5' '3' '8' '0f'};
            conditions{2}={'fml' '0' '3' '8' '5' '0f'};
            conditions{3}={'fml' '0' '3' '5' '8' '0f'};
            conditions{4}={'fml' '0' '5' '8' '3' '0f'};
            conditions{5}={'fml' '0' '8' '3' '5' '0f'};
            conditions{6}={'fml' '0' '8' '5' '3' '0f'};
            conditions{7}={'fml' '0' '3' '5' '8' '0f'};
            conditions{8}={'fml' '0' '3' '8' '5' '0f'};
            conditions{9}={'fml' '0' '5' '3' '8' '0f'};
            conditions{10}={'fml' '0' '5' '8' '3' '0f'};
            conditions{11}={'fml' '0' '8' '3' '5' '0f'};
            conditions{12}={'fml' '0' '8' '5' '3' '0f'};
            conditions{13}={'fml' '0' '3' '5' '8' '0f'};
            conditions{14}={'fml' '0' '3' '8' '5' '0f'};
            conditions{15}={'fml' '0' '5' '8' '3' '0f'};
            conditions{16}={'fml' '0' '5' '3' '8' '0f'};
            conditions{17}={'fml' '0' '8' '3' '5' '0f'};
            conditions{18}={'fml' '0' '8' '5' '3' '0f'};  
            nc = length(conditions{1});
        end
    end
elseif strcmp(DataSetsSelect,DataSets(2))
    if strcmp(DataSelect,DataSet(1))
        subjarray=list{1}(1:8);
        subjtoload = 1:8;
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions={'01' '02' '03' '04' '05'};
            nc=length(conditions);
        elseif strcmp(familSelect,famil(1))
            conditions={'fml' '01' '02' '03' '04' '05'};
            nc=length(conditions);
        end
    elseif strcmp(DataSelect,DataSet(2))
        subjarray=list{1}(1:12);  
        subjtoload = 1:12;
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions={'0' '3' '5' '8'};
            nc=length(conditions);
        elseif strcmp(familSelect,famil(1))
            conditions={'fml' '0' '3' '5' '8'};
            nc=length(conditions);
        end
    elseif strcmp(DataSelect,DataSet(3))
        subjarray=list{1}(1:12);
        subjtoload = 1:12;
        nsubj=length(subjtoload);
        cd(expfolder);
        if strcmp(familSelect,famil(2))
            conditions{1}={'8' '0' '5' '3'};
            conditions{2}={'0' '5' '8' '3'};
            conditions{3}={'3' '8' '5' '0'};
            conditions{4}={'5' '3' '0' '8'};
            conditions{5}={'8' '3' '5' '0'};
            conditions{6}={'0' '8' '3' '5'};
            conditions{7}={'3' '5' '0' '8'};
            conditions{8}={'5' '0' '8' '3'};
            
            conditions{nsubj-3}={'0' '3' '5' '8'};
            conditions{nsubj-2}={'5' '8' '0' '3'};
            conditions{nsubj-1}={'3' '0' '8' '5'};
            conditions{nsubj}={'8' '5' '3' '0'};
            nc = length(conditions{1});
        elseif strcmp(familSelect,famil(1))
            conditions{1}={'fml' '8' '0' '5' '3'};
            conditions{2}={'fml' '0' '5' '8' '3'};
            conditions{3}={'fml' '3' '8' '5' '0'};
            conditions{4}={'fml' '5' '3' '0' '8'};
            conditions{5}={'fml' '8' '3' '5' '0'};
            conditions{6}={'fml' '0' '8' '3' '5'};
            conditions{7}={'fml' '3' '5' '0' '8'};
            conditions{8}={'fml' '5' '0' '8' '3'};
            
            conditions{nsubj-3}={'fml' '0' '3' '5' '8'};
            conditions{nsubj-2}={'fml' '5' '8' '0' '3'};
            conditions{nsubj-1}={'fml' '3' '0' '8' '5'};
            conditions{nsubj}={'fml' '8' '5' '3' '0'};
            nc = length(conditions{1});
        end
    end
end

ColorSet = parula(nsubj);

% end threshold for movement end, one for each condition
endthres = 0.015*ones(1,nc);
% Threshold for target distance
tarthres = 0.10*ones(1,nc);
% vthres for movement onsets, one for each condition
vthres = 0.01*ones(1,nc);

% protocol details
popts.practicetrials = 0; % # familiarization trials, without metabolic data
popts.totaltrials = 400;  % # total trials

fsR=200; tsR=1/fsR; % robot sampling frequency

ropts.rotate = 0;
ropts.switchhometar = 0;
ropts.longtrialtime_frames = 5*fsR; %4 seconds

scrsz = get(0,'ScreenSize');
color2use = {'k' 'b' 'r' 'g' 'm' 'c' 'k' 'b' 'r' 'g' 'm' 'c'};

%% Load Robot Data
%  Get robot info
[ropts.statenames, ropts.avstatenames, ropts.robotvars] = get_robotinfo(expname2);

T{nc,nsubj} = []; Ev{nc,nsubj} = []; Data{nc,nsubj} = []; MT{nc,nsubj} = [];
% datafolder = cell(1,nsubj);

for subj = 1:nsubj
    subjid = subjarray{subjtoload(subj)};
    for c = 1:nc
        if (strcmp(DataSelect,DataSet(1)) | strcmp(DataSelect,DataSet(2)) & strcmp(DataSetsSelect,'Pilot'))
            condition{c,subj}=char(conditions(c));
            if (strcmp(subjid,'PLO') & strcmp(condition{c,subj},'fml'));
                c=2;
                condition{c,subj}=char(conditions(c));
            end
        elseif strcmp(DataSelect,DataSet(3)) && ~strcmp(DataSetsSelect,'Pilot')
            condition{c,subj}=char(conditions{subj}(c));
            if (strcmp(subjid,'PLO') & strcmp(condition{c,subj},'fml'));
                c=2;
                condition{c,subj}=char(conditions{subj}(c));
            end
        elseif strcmp(DataSetsSelect,'Not_Pilot')
            if strcmp(DataSelect,'Ordered');
                condition{c,subj}=char(conditions{c});
            else
                condition{c,subj}=char(conditions{subj}(c));
            end
        elseif strcmp(DataSetsSelect,'2018')
            if strcmp(DataSelect,'Ordered');
                condition{c,subj}=char(conditions{c});
            else
                condition{c,subj}=char(conditions{subj}(c));
            end
        end
        
        condition{c,subj}=char(conditions{subj}(c));
%         condition{c,subj}=char(conditions(c));
        
        if strcmp(DataSetsSelect,'Pilot')
            datafolder{c,subj} = ['D:\Users\Gary\Documents\School Notes\Grad School\Mass' filesep 'Pilot_Data' filesep subjid filesep subjid '_' condition{c,subj}];
        elseif strcmp(DataSetsSelect,'ArcT')
            datafolder{c,subj} = ['D:\Users\Gary\Documents\School Notes\Grad School\Mass' filesep 'Data' filesep subjid filesep subjid '_' condition{c,subj}];
        elseif strcmp(DataSetsSelect,'2018')
            datafolder{c,subj} = ['D:\Users\Gary\Documents\School Notes\Grad School\Mass' filesep '2018Data' filesep subjid filesep subjid '_' condition{c,subj}];
        end
        
        if strcmp(DataSetsSelect,'Pilot') 
            if strcmp(condition{c,subj},'fml')
                num_trials{c,subj}=100;
            else
                num_trials{c,subj}=200;
            end
        elseif strcmp(DataSetsSelect,'ArcT') 
            if strcmp(condition{c,subj},'fml')
                num_trials{c,subj}=400;
            else
                num_trials{c,subj}=200;
            end
        elseif strcmp(DataSetsSelect,'2018') 
            if strcmp(condition{c,subj},'fml')
                num_trials{c,subj}=400;
            else
                num_trials{c,subj}=400;
            end
        end
    end
end

for subj = 1:nsubj
    subjid = subjarray{subjtoload(subj)};
    for c = 1:nc
%         if (strcmp(DataSelect,DataSet(1)) | strcmp(DataSelect,DataSet(2)) & strcmp(DataSetsSelect,'Pilot'))
%             condition{c,subj}=char(conditions(c));
%             if (strcmp(subjid,'PLO') & strcmp(condition{c,subj},'fml'));
%                 c=2;
%                 condition{c,subj}=char(conditions(c));
%             end
%         elseif strcmp(DataSelect,DataSet(3))
%             condition{c,subj}=char(conditions{subj }(c));
%             if (strcmp(subjid,'PLO') & strcmp(condition{c,subj},'fml'));
%                 c=2;
%                 condition{c,subj}=char(conditions{subj}(c));
%             end
%         elseif strcmp(DataSetsSelect,'Not_Pilot')
%             if strcmp(DataSelect,'Ordered');
%                 condition{c,subj}=char(conditions(c));
%             else
%                 condition{c,subj}=char(conditions{subj}(c));
%             end
%         end
        cd(datafolder{c,subj})
    end
    for c = 1:nc
        % read robot .dat files
        T{c,subj}=dataread_robot(subjid,datafolder{c,subj});
    end
    for c = 1:nc
%         if (strcmp(subjid,'PLU') && c==5)
%             names=fieldnames(T{5,3}.framedata(1));
%             for k=1:length(names)
%                 name=names{k};
%                 T{5,3}.framedata(1).(name)=T{5,3}.framedata(1).(name)(400:936);
%                 T{5,3}.framedata(1).statenumber(1:3)=3;
%             end
%             clear name names
%         end
        
        % Get robot events
        Ev{c,subj} = get_robotevents(T{c,subj}.framedata, ropts.statenames, ropts.avstatenames);

        % Data is structure of matrices concatenated from T.framedata
        % Then remove framedata field from T
        [Data{c,subj}, Ev{c,subj}] = analyze_robot_basic(T{c,subj}, Ev{c,subj}, ropts,c,subj);

        % Get movement position and velocity
        Data{c,subj}.v = (Data{c,subj}.vx.^2+Data{c,subj}.vy.^2).^0.5;
        Data{c,subj}.p = ((Data{c,subj}.x).^2 + (Data{c,subj}.y).^2).^0.5;

        % Get velocity by differentiating position (Data.v is bumpy)
        Data{c,subj} = get_vsign(Data{c,subj},num_trials{c,subj});
        
        
    end
    for c = 1:nc
        % Get movement times
        [MT{c,subj},Data{c,subj}] = get_mvttimes_2018(Data{c,subj},...
            Data{c,subj}.v_sign, Data{c,subj}.p, Ev{c,subj}, vthres(c), endthres(c), tarthres(c),c,subj);
%         MT{c,subj} = get_mvttimes_aa(Data{c,subj}, Data{c,subj}.v_sign, Ev{c,subj}, vthres(c));%, endthres(c), tarthres(c),c,subj);
        fprintf('Subject %g %s Condition %s Processed\n',subj,subjid,condition{c,subj});
    end
end

% poolobj=gcp('nocreate');
% delete(poolobj);
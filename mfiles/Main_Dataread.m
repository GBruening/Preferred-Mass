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

%clear all
clc
% close all
global plot_graphs
plot_graphs = 0;
%% Experiment specific details
% projpath = 'F:\Documents\School notes\Grad School\';
projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
expname = 'Mass';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);

%Pulls the names of the data from the data folder and stores in an array
cd(datafolder);
[status,list]=system('dir /B');
list=textscan(list,'%s','delimiter','/n');
subjarray=list{1}(1:18);  
subjtoload = 1:18;
nsubj=length(subjtoload);
cd(expfolder);

conditions={'fml' '0' '3' '5' '8' '0f'};
% conditions={'0' '3' '5' '8' '0f'};
nc=length(conditions);

ColorSet = parula(nsubj);

% end threshold for movement end, one for each condition
endthres = 0.015*ones(1,nc);
% Threshold for target distance
tarthres = 0.10*ones(1,nc);
% vthres for movement onsets, one for each condition
vthres = 0.01*ones(1,nc);

% protocol details
popts.practicetrials = 0; % # familiarization trials, without metabolic data
popts.totaltrials = 200;  % # total trials

fsR=200; tsR=1/fsR; % robot sampling frequency

ropts.rotate = 0;
ropts.switchhometar = 0;
ropts.longtrialtime_frames = 4*fsR; %4 seconds

scrsz = get(0,'ScreenSize');
color2use = {'k' 'b' 'r' 'g' 'm' 'c' 'k' 'b' 'r' 'g' 'm' 'c'};

%% Load Robot Data
%  Get robot info
[ropts.statenames, ropts.avstatenames, ropts.robotvars] = get_robotinfo(expname);

T{nc,nsubj} = []; Ev{nc,nsubj} = []; Data{nc,nsubj} = []; MT{nc,nsubj} = [];

for subj = 1:18
    subjid = subjarray{subjtoload(subj)};
    for c = 1:nc        
        condition=char(conditions{c});        
        if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
            c=2;
            condition=char(conditions{c});
        end
        
        datafolder = [projpath expname filesep 'Pilot_Data' filesep subjid filesep subjid '_' condition];
        cd(datafolder)

        % read robot .dat files
        T{c,subj}=dataread_robot(subjid,datafolder);
        
        % Get robot events
        Ev{c,subj} = get_robotevents(T{c,subj}.framedata, ropts.statenames, ropts.avstatenames);

        % Data is structure of matrices concatenated from T.framedata
        % Then remove framedata field from T
        [Data{c,subj}, Ev{c,subj}] = analyze_robot_basic(T{c,subj}, Ev{c,subj}, ropts,c,subj);

        % Get movement times
        Data{c,subj}.v = (Data{c,subj}.vx.^2+Data{c,subj}.vy.^2).^0.5;
        Data{c,subj}.P = ((Data{c,subj}.x).^2 + (Data{c,subj}.y).^2).^0.5;
        
         % Get velocity by differentiating position (Data.v is bumpy)
        if strcmp(condition,'fml')
            num_trials=100;
        else
            num_trials=200;
        end
        Px = Data{c,subj}.x; Py = Data{c,subj}.y;
        P = (Px.^2 + Py.^2).^0.5;
        Data{c,subj}.v = nan(size(P));
        time = Data{c,subj}.time;
        Data{c,subj}.v(1,:) = zeros(1,num_trials);
        for i=1:num_trials
            num_frames(i) = sum(~isnan(P(:,i)));
            Pdiff{i} = diff23f5( P(1:num_frames(i),i), 1/200, 10 ); %doesn't work very well
            Data{c,subj}.v_sign(2:num_frames(i)+1,i) = Pdiff{i}(:,2);
        end
        % Filter robot velocity using Savitzky-Golay filter (smooths w/o greatly distorting signal)
        Data{c,subj}.vx_orig=Data{c,subj}.vx;
        Data{c,subj}.vy_orig=Data{c,subj}.vy;
        Data{c,subj}.vx = sgolayfilt(Data{c,subj}.vx,3,21);
        Data{c,subj}.vy = sgolayfilt(Data{c,subj}.vy,3,21);
        Data{c,subj}.v = (Data{c,subj}.vx.^2+Data{c,subj}.vy.^2).^0.5;
        
        MT{c,subj} = get_mvttimes(Data{c,subj}, Data{c,subj}.v, Data{c,subj}.P, Ev{c,subj}, vthres(c), endthres(c), tarthres(c),c,subj);

        %pause
        fprintf('Subject %1.0f %s Condition %s Processed\n',subj,subjid,condition);
     end


end

cd(expfolder);

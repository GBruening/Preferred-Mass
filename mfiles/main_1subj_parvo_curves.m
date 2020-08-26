% Basic script that analyzes robot, parvo data
% Experiment type: by conditions (ex. speed)

% Version 1. HJH
% updated get_mvttimes to specify which velocity to use (ex. Vx, Vy, or V)

%%%### Figures have been excluded and have been commented out using '%%%###'

%clear all;
clc
close all;
global plot_graphs
plot_graphs = 0;
%% Experiment specific details
%projpath = 'C:\Users\Neuromechanics\Desktop\Megan\';
projpath = '/Users/obrienmk/Documents/NeuroLab/MATLAB/Data Analysis/';
expname = 'Mass';
addpath([projpath filesep expname filesep 'mfiles']);

% subjs = {'NPO' 'IFD' 'FTF' 'NUU'};
%subjid = input('Enter Subject ID: ','s');
%subjs = {'BFL' 'CUB' 'NPO' 'IFD' 'FTF' 'NUU'};
subjid = 'NLP20';
% if you leave it as '', a popup will appear for you to select the file
% or you can write in the filename here
% parvofile = [projpath filesep expname filesep subjid filesep subjid '10262012_parvo.xls'];
parvofile = '';

conditions = {'0_0' '0_3' '0_5' '0_8' '0_0f'};
nc = length(conditions);
ColorSet = jet(nc);

blocks = {'B1' 'B2' 'B3' '0_0' '0_3' '0_5' '0_8' '0_0f' 'B4'};

% vthres for movement onsets, one for each speed
vthres = 0.03*ones(1,nc);

% protocol details
popts.practicetrials = 0; % # familiarization trials, without metabolic data
popts.totaltrials = 200;  % # total trials

fsR=200; tsR=1/fsR; % robot sampling frequency

ropts.rotate = 0;
ropts.switchhometar = 1;
ropts.longtrialtime_frames = 4*fsR; %4 seconds

%% What to plot
parvovars2plot = {'PA.MP_W_kg' 'PA.MP_W_kg_net'};
% parvovars2plot = {'PA.VO2_kg' 'PA.VO2_kg_net'};
nmin = 3; % plot average parvo data over the last nmin minutes

scrsz = get(0,'ScreenSize');
color2use = {'k' 'b' 'r' 'g' 'm' 'c' 'k' 'b' 'r' 'g' 'm' 'c'};

%% Load Parvo Data

cd([projpath expname filesep subjid])

if isempty(parvofile)
    [parvofile, pathname] = uigetfile({'*.xls'; '*.txt'}, 'Pick your parvo file file.');
    cd(pathname);
end

[pathstr, name, ext] = fileparts(parvofile);
if strcmpi(ext, '.xls') || strcmpi(ext, '.xlsx')
    P = dataread_parvo_xls(parvofile);
elseif strcmpi(ext, '.txt')
    P = dataread_parvo_txt(parvofile);
else
    error('No parvo file.');
end

%% Basic parvo analysis
% get time weighted average for last x min, in winsize_min
winsize_min = [1 2 3 4];
[PA, P] = analyze_parvo_basic(P, blocks, P.blocknames, P.blocktimes, winsize_min);

%% Calculate net for parvo vars of interest
parvovars = {'PA.MP_W_kg' 'PA.MP_W' 'PA.VO2_kg'};

baselineblocks = strncmp('B',blocks,1);
for p = 1:length(parvovars)
    for d = 1:length(winsize_min)
        eval(['[C PA.baselineblock(d)] = min(' parvovars{p} '(d,baselineblocks));']);
        eval([parvovars{p} '_net(d,:) = ' parvovars{p} '(d,:)-' parvovars{p} '(d,PA.baselineblock(d));']);
    end
end
%% Plot time weighted averaged metabolic data
if plot_graphs
    figure('Position',[scrsz(3)*0.1 scrsz(4)*0.1 scrsz(3)*0.85 scrsz(4)*0.6], 'color', 'white');
    
    for v = 1:length(parvovars2plot)
        subplot(1,length(parvovars2plot),v)
        eval(['data2plot = ' parvovars2plot{v} ';'])
        bar(1:length(blocks),data2plot(nmin,:));
        set(gca, 'xticklabel', blocks); box off
        ylabel([parvovars2plot{v} ', last '  num2str(nmin) ' min']);
        for i = 1:length(blocks)
            text(i, data2plot(nmin,i)+range(data2plot(nmin,:))*0.05, num2str(round(data2plot(nmin,i)*100)/100), 'horizontalalignment','center');
        end
    end
end
%% Load Robot Data
%  Get robot info
[ropts.statenames, ropts.avstatenames, ropts.robotvars] = get_robotinfo(expname);

T{nc} = []; Ev{nc} = []; Data{nc} = []; MT{nc} = [];

for c = 1:nc   
    datafolder = [projpath expname filesep subjid filesep subjid '_' conditions{c}];
    cd(datafolder)
    
    % read robot .dat files
    T{c}=dataread_robot(subjid,datafolder);
    
    % Get robot events
    Ev{c} = get_robotevents(T{c}.framedata, ropts.statenames, ropts.avstatenames);
      
    % Data is structure of matrices concatenated from T.framedata
    % Then remove framedata field from T
    [Data{c}, Ev{c}] = analyze_robot_basic(T{c}, Ev{c}, ropts);
    
    % Get movement times
    Data{c}.v = (Data{c}.vx.^2+Data{c}.vy.^2).^0.5;
    MT{c} = get_mvttimes(Data{c}, Data{c}.v, Ev{c}, vthres(c));
    
    %pause
 end

%% Interpolate parvo data to coincide with robot trials

% First check that the duration of the block based on the written times is
% similar to the duration indicated by the robot data
firstmettrial = popts.practicetrials+1;
for c = 1:nc
    bi = find(strcmp(conditions{c},P.blocknames));
    leavehomeidx = Ev{c}{1,1+firstmettrial}{1}(strcmp('home',Ev{c}{1,1+firstmettrial}{3})); 
    block_duration_robot(c) = (Data{c}.time_ms(end,end)-Data{c}.time_ms(leavehomeidx,firstmettrial))*0.001/60;
    
    % Check that block duration based on the written times is within +/-15
    % seconds of the duration based on the robot
    if abs(block_duration_robot(c)-diff(P.blocktimes(bi,:))) > 0.25
        error('Check written times. Mismatch in block duration between written times and robot times.');
    else
        
        % Interpolate parvo data to correspond with robot data
        % The interpolated time points equal the times of the last frame in
        % home
        PI{c} = align_parvo_withrobot(P, Data{c}, P.blocktimes(bi,:), Ev{c}, popts);
    end
end

% Average net metabolic cost by condition
mettime_ind = length(winsize_min); % Met data is over X time (X = last entry in winsize_min)
MCost=PA.MP_W_kg_net(mettime_ind,:)*winsize_min(mettime_ind)*60;  % multiply by time (last entry in winsize_min)

figure(50);
    subplot(121);  hold on;
    for c=1:nc
        plot(c,MCost(c),'o','Color',ColorSet(c,:),'MarkerFaceColor',ColorSet(c,:))
    end
    plot(MCost,'k-')
    xlabel('Condition'); ylabel('Net Met cost (J/kg)');
    axis([0 nc+1 0 160]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'FontSize',14)

%  Metabolic data by trials

%% Curve related metrics

% Write a loop for the different conditions, c, and trials, i. 
% I'm using v, where v = (vx^2+xy^2)^0.5 (see lin 118)

nTrials_speed = popts.totaltrials; % look at last X trials only
for c=1:nc
    for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
        % Average velocity
        Data{c}.avevel(i) = mean(Data{c}.v(MT{c}.idxonset(i):MT{c}.idxendpt(i),i));

        % Peak velocity
        Data{c}.peakvel(i) = max(Data{c}.v(MT{c}.idxonset(i):MT{c}.idxendpt(i),i));

        % Endpoint variability
        % Data{c}.sdvel(i) = std(Data{c}.v(MT{c}.idxonset(i):MT{c}.idxendpt(i),i));

        % Movement error

        % Smoothness??
        % Gets average movement time per trajectory and saves as
        % 'SubjIDmovttimedata'
        %%%avemovttimes

        %Gets average velocity per trajectory and saves as 'SubjIDdata'
        %%%velocityaverageTrial

        %%%distance
    end

    PrefSpeed(c)=mean(Data{c}.avevel);

end

% Average speed by condition
figure(50);
    subplot(122); hold on;
    for c=1:nc
        plot(c,PrefSpeed(c),'o','Color',ColorSet(c,:),'MarkerFaceColor',ColorSet(c,:))
    end
    plot(PrefSpeed,'k-')
    xlabel('Condition'); ylabel('Avg speed (m/s)');
    axis([0 nc+1 0.15 0.30]); 
    set(gca,'XTickLabel',[' ' conditions ' '],'FontSize',14)
    
% Energy vs. speed
figure(51);  hold on;
    for c=1:nc
         plot(PrefSpeed(c),MCost(c),'o','Color',ColorSet(c,:),'MarkerFaceColor',ColorSet(c,:))
    end
    xlabel('Speed (m/s)'); ylabel('Cost (J/kg)');
    set(gca,'FontSize',14)

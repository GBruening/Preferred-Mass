% plots have been commented out and marked by '%%%###'
function I = align_parvo_withrobot(P, Data, subjblocktimes, Ev, opts)

ntrials = size(Data.time,2);

varnames = fieldnames(P);
varnames = varnames(~ismember(varnames,{'info' 'blocknames' 'blocktimes' 'writtentimes'}));
nv = length(varnames);

t_offset = subjblocktimes(1);
disp(['time offset: ' num2str(t_offset)])

%% Put robot times in minutes, restarting time of first trial at zero
I.trialtime_min = nan(ntrials,1); % in min wrt overall protocol

% end of home for first trial with metabolics, after practice trials
% first 1 is because the first column of the cell array Ev is a label
i1 = Ev{1,1+opts.practicetrials+1}{1}(strcmp('home',Ev{1,1+opts.practicetrials+1}{3})); 

% loop through trials with metabolics
for i = opts.practicetrials+1:ntrials
    
    % find end of home for that trial
    ii = Ev{1,1+i}{1}(strcmp('home',Ev{1,1+i}{3})); 
    
    % recalculate times for each robot trial to be in minutes
    % with respect to the end of home
    I.trialtime_min(i) = (Data.time_ms(ii,i)-Data.time_ms(i1,opts.practicetrials+1))*0.001/60 + t_offset;
end

%% Interpolate parvo data to trialtime_min

[C, i] = min(abs(P.TIME-subjblocktimes(1)));
[C, ii] = min(abs(P.TIME-subjblocktimes(2)));

for v = 1:nv
    eval(['I.' varnames{v} ' = interp1(P.TIME(i:ii), P.' varnames{v} '(i:ii), I.trialtime_min(opts.practicetrials+1:ntrials));']);
end

%% Figure to check interp data
 figure

 plot(P.TIME(i:ii), P.MP_W_kg(i:ii), 'bo-');
hold on
 plot(I.TIME, I.MP_W_kg, 'r.-');
ylimits = ylim(gca);
set(gca,'ylim',[0 ylimits(2)])
ylabel('MP W/kg'); xlabel('Time (min)');
title('Check interp');


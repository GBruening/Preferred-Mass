%% OverShoots


for subj = 1:nsubj
    subjid = subjarray{subjtoload(subj)};
    %Curve related metrics

    % Write a loop for the different conditions, c, and trials, i. 
    % I'm using v, where v = (vx^2+xy^2)^0.5 (see lin 118)

%    nTrials_speed = 200; % look at last X trials only; for all, popts.totaltrials
    for c=1:nc
        tic
        if (strcmp(DataSelect,DataSet(1)) | strcmp(DataSelect,DataSet(2)))
            condition=char(conditions(c));
            if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
                c=2;
                condition=char(conditions(c));
            end
        elseif strcmp(DataSelect,DataSet(3))
            condition=char(conditions{subj}(c));
            if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
                c=2;
                condition=char(conditions{subj}(c));
            end
        end
        tr_count = 1;
        
        
        if strcmp(DataSetsSelect,'Pilot')
            if strcmp(condition,'fml')
                popts.totaltrials=100;
                nTrials_speed=100;
                Data{c,subj}.stateframes=zeros([8,100]);
            elseif ~strcmp(condition,'fml')
                popts.totaltrials=200;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,200]);
            end
        elseif strcmp(DataSetsSelect,'Not_Pilot')
            if strcmp(condition,'fml')
                popts.totaltrials=400;
                nTrials_speed=350;
                Data{c,subj}.stateframes=zeros([8,400]);
            elseif ~strcmp(condition,'fml')
                popts.totaltrials=200;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,200]);
            end
        end
        
        Data{c,subj}.overshoot=0;
         
        for i = 1:popts.totaltrials
            if max(Data{c,subj}.P(:,i))>.11
                Data{c,subj}.overshoot=Data{c,subj}.overshoot+1;
            end
        end
        
        OverShoot(c,subj)=Data{c,subj}.overshoot;
        
        
    end
end

bar(transpose(OverShoot))
legend({'fml' '0' '3' '5' '8'})
ylabel('Number of OverShoots');
xlabel('Subject number');
title('OverShoot Counter');

% hold on;
% for subj=1:nsubj
%     subplot(1,nsubj,subj);
%     for c=1:nc
%         ColorPref(subj)=bar(str2double(conditions(c)),Data{c,subj}.overshoot);%,'Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
%     end
% end

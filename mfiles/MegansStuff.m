for subj=1:nsubj
    tr_count=1;
    for c=1:nc
        condition=char(conditions(c));
        if strcmp(condition,'fml')
            popts.totaltrials=400;
            nTrials_speed=400;
        elseif ~strcmp(condition,'fml')
            popts.totaltrials=200;
            nTrials_speed=200;
        end
        
        for i=1:nTrials_speed
            
            AvevelMatrix(subj,tr_count)=Data{c,subj}.avevel.totarget(i);
            PeakvelMatrix(subj,tr_count)=Data{c,subj}.peakvel.totarget(i);
            ReactionMatrix(subj,tr_count)=Data{c,subj}.timings.reaction(i);
            DurationMatrix(subj,tr_count)=Data{c,subj}.timings.reacttotar(i);
            
            tr_count=tr_count+1;
        end
    end
%     ConditionArray{subj}=[char(conditions{subj}(:,1)),char(conditions{subj}(2:5))'];
end
filename='MegansStuff';

ConditionArray={'fml0358' 'fml5803' 'fml3085' 'fml8530' 'fml8053' 'fml0583' 'fml3850' 'fml5308' 'fml8350' 'fml0835' 'fml3508' 'fml5083'};

save(filename,'AvevelMatrix','PeakvelMatrix','ReactionMatrix','DurationMatrix','ConditionArray');
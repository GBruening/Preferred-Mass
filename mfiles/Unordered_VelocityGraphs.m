
for subj=1:nsubj
k=1;    
    for c=1:nc
        
        if (c==1 & subj==15)
            c=2;
        end
        
        if c==1
            popts.totaltrials=400;
            nTrials_speed=400;
        elseif c~=1
            popts.totaltrials=200;
            nTrials_speed=200;
        end
        
        for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials            
            AllTrialVelocityData(subj,k) = Data{c,subj}.avevel.all(i);
            k=k+1;
        end
    end
    fprintf('Done with subject %d \n',subj);
end

for subj=1:nsubj
for c=1:nc
    popts.totaltrials=200;
    nTrials_speed=200;
    if (c==1 & subj==15)
        c=2;
    end

    if c==1
        popts.totaltrials=400;
        nTrials_speed=400;
    elseif c~=1
        popts.totaltrials=200;
        nTrials_speed=200;
    end
        
    for k=popts.totaltrials-nTrials_speed+6:popts.totaltrials-6        
        Data{c,subj}.averagedavevel(k)=mean(Data{c,subj}.avevel.all(k-5:k+5));
    end
end
end

for subj=1:nsubj
    p=1;
%     if subj~=15
%         starttrials=11;
%         alltrials=190;
%     else
%         starttrials=111;
%         alltrials=1190;
%     end

    starttrials=11;
    alltrials=1190;
    for i=starttrials:alltrials
        ATVDave(subj,p)=mean(AllTrialVelocityData(subj,i-10:i+10));
        p=p+1;
    end
end

hold on
for subj=1:nsubj
    
    plot(ATVDave(subj,:));
%     title(conditions{subj});
    
end
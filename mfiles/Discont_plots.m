for subj=16:nsubj
    for c=1:nc
        for k=1:length(Data{c,subj}.discont.trials)
            plot(Data{c,subj}.v(:,k))
            b=sprintf('Subject: %g, condition: %g, trial: %g',subj,c,Data{c,subj}.discont.trials(k));
            title(b);
        end
    end
end
for subj=15:nsubj
    for c=1:nc
        
        if (subj==15 & c==1);
            c=2;
        end
        
        subj
        c
        
        isfield(Data{c,subj},'high_reaction')
        Data{c,subj}.high_reaction
        if (isfield(Data{c,subj},'high_reaction'))
            if ~isempty(Data{c,subj}.high_reaction);
            for k=1:length(Data{c,subj}.high_reaction)
                figure(1);
                plot(Data{c,subj}.v(:,Data{c,subj}.high_reaction(k)));
                a=sprintf('High Reacttion frame = %g',Data{c,subj}.reaction_vthres(Data{c,subj}.high_reaction(k)));
                xlabel(a);
                b=sprintf('Subject: %g, condition: %g, trial: %g',subj,c,Data{c,subj}.high_reaction(k));
                title(b);
                figure(2);
                plot(Data{c,subj}.x(:,Data{c,subj}.high_reaction(k)),Data{c,subj}.y(:,Data{c,subj}.high_reaction(k)));
                b=sprintf('Subject: %g, condition: %g, trial: %g',subj,c,Data{c,subj}.high_reaction(k));
                axis([-.1 .1 -.1 .1]);
                title(b);
            end
            end
        end
    end
end
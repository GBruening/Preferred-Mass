notsig=0;
sig=0;
trialcutoff=3;

fileID=fopen('pvalueTrialCutoff.txt','w');

while (sig<90 & trialcutoff<198);
notsig=0;
sig=0;
    
trialcutoff=trialcutoff+1;

for subj=1:nsubj
    for c=1:nc
        p=ttests(Data{c,subj}.avevel.tomoveback(1:trialcutoff),Data{c,subj}.avevel.tomoveback(trialcutoff+1:200),'unpaired');
        if p>.05
            notsig=notsig+1;
        else
            sig=sig+1;
        end
        TCOff_NotSig(trialcutoff)=notsig;
        TCOFF_Sig(trialcutoff)=sig;
    end
end

end

for subj=1:nsubj
    for c=1:nc
        p=ttests(Data{c,subj}.avevel.tomoveback(1:trialcutoff),Data{c,subj}.avevel.tomoveback(trialcutoff+1:200),'unpaired');
        
        A=[subj conditions{c} p];
        fprintf(fileID,'%f %s %f ',subj, conditions{c}, p);
        fprintf(fileID,'\n');
    end
end


%fclose(fileID);

notsig
sig
trialcutoff
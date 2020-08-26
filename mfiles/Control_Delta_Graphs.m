% load('ControlData.mat');

% cd(expfolder);

graphfolder=[expfolder '\' 'Graphs' '\' 'Delta Velocity graphs by subject'];
clear ColorPref

loopnumber=0;
TrialCutoff=1;
delcount=0;

delcondstr={'-8' '-5' '-3' '-2' '2' '3' '5' '8'};

%% Delta Line graphs by trial
% All subjects

ColorSet=parula(18);

del1count=1;
del2count=1;
del3count=1;
del4count=1;
del5count=1;

clear Delta1 Delta2

trialcutoff=20;

for subj=1:nsubj
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{c});
        if c>2
            condition_prev=char(conditions{c});
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'01')
            condition_cur=1;
            condition_cur1=1;
        elseif strcmp(condition_cur,'02')
            condition_cur=2;
            condition_cur1=2;
        elseif strcmp(condition_cur,'03')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'04')
            condition_cur=4;
            condition_cur1=4;
        elseif strcmp(condition_cur,'05')
            condition_cur=5;
            condition_cur1=5;
        end
        
        if c==2
            condition_prev=0;
        end
        
        switch condition_cur
%             case 0
%                 Delta1(3,deln3count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
%                 deln3count=deln3count+1;
            case 01
                Delta1(1,del1count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del1count=del1count+1;
            case 02
                Delta1(2,del2count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del2count=del2count+1;
            case 03
                Delta1(3,del3count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del3count=del3count+1;
            case 04
                Delta1(4,del4count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del4count=del4count+1;
            case 05
                Delta1(5,del5count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del5count=del5count+1;
        end        
    end    
end

for k=2:5
    for j=1:trialcutoff
        Delta2(k,j)=mean(Delta1(k,:,j));
        Delta2er(k,j)=std(Delta1(k,:,j),[],2)/sqrt(12);
    end
end

figure(1);
hold on
for k=2:5
    ColorPref(k)=plot(1:trialcutoff,Delta2(k,:),'Color',ColorSet((4*k-2),:),'MarkerFaceColor',ColorSet((4*k-2),:));
%     lineprops=ColorPref(k);
   shadedErrorBar(1:trialcutoff,Delta2(k,1:trialcutoff),Delta2er(k,1:trialcutoff),{'Color',ColorSet((4*k-2),:),'MarkerFaceColor',ColorSet((4*k-2),:)},'transparent');
end

legend([ColorPref(2:5)],{'02' '03' '04' '05'})
xlabel('Trial #');ylabel('Velocity Normalized to last condition of previous block');
titlestr=sprintf('Avg over control Subject Velocity norm to prev cond, trial 1-%g',trialcutoff);
title(titlestr);
cd(graphfolder);
savefig(titlestr);
print(titlestr,'-dpdf');
cd(expfolder);

%% Delta Line graphs by trial REACTION TIMES
% All subjects

ColorSet=parula(18);

del1count=1;
del2count=1;
del3count=1;
del4count=1;
del5count=1;

clear Delta1 Delta2

trialcutoff=20;

for subj=1:nsubj
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{c});
        if c>2
            condition_prev=char(conditions{c});
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'01')
            condition_cur=1;
            condition_cur1=1;
        elseif strcmp(condition_cur,'02')
            condition_cur=2;
            condition_cur1=2;
        elseif strcmp(condition_cur,'03')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'04')
            condition_cur=4;
            condition_cur1=4;
        elseif strcmp(condition_cur,'05')
            condition_cur=5;
            condition_cur1=5;
        end
        
        if c==2
            condition_prev=0;
        end
        
        switch condition_cur
%             case 0
%                 Delta1(3,deln3count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
%                 deln3count=deln3count+1;
            case 01
                Delta1(1,del1count,1:200)=Data{c,subj}.reaction_vthres/mean(Data{c-1,subj}.reaction_vthres(196:200));
                del1count=del1count+1;
            case 02
                Delta1(2,del2count,1:200)=Data{c,subj}.reaction_vthres/mean(Data{c-1,subj}.reaction_vthres(196:200));
                del2count=del2count+1;
            case 03
                Delta1(3,del3count,1:200)=Data{c,subj}.reaction_vthres/mean(Data{c-1,subj}.reaction_vthres(196:200));
                del3count=del3count+1;
            case 04
                Delta1(4,del4count,1:200)=Data{c,subj}.reaction_vthres/mean(Data{c-1,subj}.reaction_vthres(196:200));
                del4count=del4count+1;
            case 05
                Delta1(5,del5count,1:200)=Data{c,subj}.reaction_vthres/mean(Data{c-1,subj}.reaction_vthres(196:200));
                del5count=del5count+1;
        end        
    end    
end

for k=2:5
    for j=1:trialcutoff
        Delta2(k,j)=mean(Delta1(k,:,j));
        Delta2er(k,j)=std(Delta1(k,:,j),[],2)/sqrt(12);
    end
end

figure(2);
hold on
for k=2:5
    ColorPref(k)=plot(1:trialcutoff,Delta2(k,:),'Color',ColorSet((4*k-2),:),'MarkerFaceColor',ColorSet((4*k-2),:));
%     lineprops=ColorPref(k);
   shadedErrorBar(1:trialcutoff,Delta2(k,1:trialcutoff),Delta2er(k,1:trialcutoff),{'Color',ColorSet((4*k-2),:),'MarkerFaceColor',ColorSet((4*k-2),:)},'transparent');
end

legend([ColorPref(2:5)],{'02' '03' '04' '05'})
xlabel('Trial #');ylabel('Reaction Normalized to last condition of previous block');
titlestr=sprintf('Avg over Control Subject Reaction norm to prev cond, trial 1-%g',trialcutoff);
title(titlestr);
cd(graphfolder);
savefig(titlestr);
print(titlestr,'-dpdf');
cd(expfolder);

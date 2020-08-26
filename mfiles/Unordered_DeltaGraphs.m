% load('Data-UnorderedwithFML.mat');

% cd(expfolder);

graphfolder=[expfolder '\' 'Graphs' '\' 'Delta Velocity graphs by subject'];
clear ColorPref

figure_count=1;


TrialCutoff=1;
delcount=0;

delcondstr={'-8' '-5' '-3' '-2' '2' '3' '5' '8'};

%% Delta condition to normalized Velocity

TrialCutoff=1;
delcount=0;
loopnumber=0;
ColorSet=parula(18);

del8count=1;
del5count=1;
del3count=1;
del2count=1;
deln2count=1;
deln3count=1;
deln5count=1;
deln8count=1;
clear Delta1 Delta2 delta_condition1

trialcutoff=20;

figure(figure_count);
hold on;

Delta1_count=1;
Delta2_count=1;


for subj=1:12

    %    figure(subj);
%    close all;
    delcount=0;
    for c=2:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>1
            condition_prev=char(conditions{subj}(c-1));
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==1
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        if delta_condition==0
            1;
        end
%         delta_condition1(delcount)=condition_cur-condition_prev;
%         delta_condition1(loopnumber)=condition_cur-condition_prev;
        
%         if subj<10
%             plot(delta_condition,PrefSpeed.all(c,subj)/PrefSpeed.all(c-1,subj),'o','Color',ColorSet((subj*2)-1,:),'MarkerFaceColor',ColorSet((subj*2)-1,:));
%         else
%             plot(delta_condition,PrefSpeed.all(c,subj)/PrefSpeed.all(c-1,subj),'*','Color',ColorSet((subj-9)*2-1,:),'MarkerFaceColor',ColorSet((subj-9)*2-1,:));
%         end

%         Delta1(loopnumber)=(PrefSpeed.all(c,subj)/PrefSpeed.all(c-1,subj));

        Delta_vel=PrefSpeed.all(c,subj)/PrefSpeed.all(c-1,subj);
        plot(delta_condition,Delta_vel,'o','Color',ColorSet(1,:),'MarkerFaceColor',ColorSet(1,:));
        if delta_condition<0
            Delta1(Delta1_count)=(PrefSpeed.all(c,subj)/PrefSpeed.all(c-1,subj));
            delta_condition1(Delta1_count)=delta_condition;
            subjects_number1(Delta1_count)=subj;
            Delta1_count=Delta1_count+1;
        elseif delta_condition>0
            Delta2(Delta2_count)=(PrefSpeed.all(c,subj)/PrefSpeed.all(c-1,subj));
            delta_condition2(Delta2_count)=delta_condition;
            subjects_number2(Delta2_count)=subj;
            Delta2_count=Delta2_count+1;
        end

    end    
end

xlabel('Delta Condition');ylabel('Speed normalized to previous condition');
% [p,x1,yline,yfit,rsq_adj]=regression(delta_condition1,Delta1,1);
% plot(x1,yline,'Color',ColorSet(2,:)); %refline(0,1);

refline(0,1);
[p,x1,yline,yfit1,rsq_adj1]=regression(delta_condition1,Delta1,1);
plot(x1,yline,'Color',ColorSet(2,:)); %refline(0,1);
y1string=sprintf('y = %g * x + %g', p(1),p(2));

[p,x2,y2line,yfit2,rsq_adj2]=regression(delta_condition2,Delta2,1);
plot(x2,y2line,'Color',ColorSet(2,:)); %refline(0,1);
y2string=sprintf('y = %g * x + %g', p(1),p(2));

delta_condition=[delta_condition1,delta_condition2];
Delta=[Delta1,Delta2];
yfit=[yfit1,yfit2];
subjects_number=[subjects_number1,subjects_number2];
y=Delta;
yresid=y-yfit;
SSresid=sum(yresid.^2);
SStotal=(length(y)-1)*var(y);
rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(p));

rstring=sprintf('R^2 = %f',rsq_adj);
% ystring=sprintf('y = %g x^{2} + %g x + %g', p(1),p(2),p(3));
r1string=sprintf('R^2 = %f',rsq_adj1);
r2string=sprintf('R^2 = %f',rsq_adj2);
% y1string=sprintf('y = %g * x + %g', p(1),p(2));
title('Delta condition to delta speed');
text(-6,.97,r1string);
text(-6,.96,y1string);
text(2,1.07,r2string);
text(2,1.06,y2string);
text(0,1.15,rstring);
% text(0,1.24,ystring);

%% Delta Line graphs by trial REACTION TIMES
% All subjects

ColorSet=jet(16);

variable = 'avevel.totarget';
% variable = 'reaction_tanv';
% variable = 'peakvel.totarget';

del8count=1;
del5count=1;
del3count=1;
del2count=1;
deln2count=1;
deln3count=1;
deln5count=1;
deln8count=1;

cond0count=1;
cond3count=1;
cond5count=1;
cond8count=1;

clear Delta1 Delta2 Delta3 Delta1er Delta2er Delta3er

trialcutoff=200;
bin_size=5;
loopnumber=0;

for subj=1:nsubj
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>2
            condition_prev=char(conditions{subj}(c-1));
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==2
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        delta_condition1(delcount)=condition_cur-condition_prev;
        delta_condition1(loopnumber)=condition_cur-condition_prev;
         
        switch delta_condition
            case -8
                Delta1(1,deln8count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                deln8count=deln8count+1;
            case -5
                Delta1(2,deln5count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                deln5count=deln5count+1;
            case -3
                Delta1(3,deln3count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                deln3count=deln3count+1;
            case -2
                Delta1(4,deln2count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                deln2count=deln2count+1;
            case 2
                Delta1(5,del2count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                del2count=del2count+1;
            case 3
                Delta1(6,del3count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                del3count=del3count+1;
            case 5
                Delta1(7,del5count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                del5count=del5count+1;
            case 8
                Delta1(8,del8count,1:200)=eval(['Data{c,subj}.' variable])/mean(eval(['Data{c-1,subj}.' variable '(180:200)']));
                del8count=del8count+1;
        end



%         switch condition_cur
%             
%             case 0
%                 Delta1(1,cond0count,1:200)=Data{c,subj}.(variable);
%                 cond0count=cond0count+1;
%             case 3
%                 Delta1(2,cond3count,1:200)=Data{c,subj}.(variable);
%                 cond3count=cond3count+1;
%             case 5
%                 Delta1(3,cond5count,1:200)=Data{c,subj}.(variable);
%                 cond5count=cond5count+1;
%             case 8
%                 Delta1(4,cond8count,1:200)=Data{c,subj}.(variable);
%                 cond8count=cond8count+1;
%         end

        
        
        
    end    
end

for k=8:-1:1
    for j=1:trialcutoff
%         if (k==1 || k==4 || k==5 || k==8)
%             Delta2(k,j)=mean(Delta1(k,1:6,j));
%             Delta2er(k,j)=std(Delta1(k,1:6,j),[],2)/sqrt(6);
%         else
            Delta2(k,j)=mean(nonzeros(Delta1(k,:,j)));
            Delta2er(k,j)=std(Delta1(k,1:6,j),[],2)/sqrt(12);
%         end
    end
    Delta3(k,:)=mean(reshape(Delta2(k,:),bin_size,trialcutoff/bin_size),1);
    Delta3er(k,:)=mean(reshape(Delta2er(k,:),bin_size,trialcutoff/bin_size),1);
end

figure(5);
clf(5);
hold on
for k=1:8
    ColorPref(k)=plot(1:trialcutoff/bin_size,Delta3(k,:),'Color',ColorSet(k*2,:),'MarkerFaceColor',ColorSet(k*2,:),'LineWidth',3);
%     lineprops=ColorPref(k);
   shadedErrorBar(1:trialcutoff/bin_size,Delta3(k,1:trialcutoff/bin_size),Delta3er(k,1:trialcutoff/bin_size),{'Color',ColorSet(k*2,:),'MarkerFaceColor',ColorSet(k*2,:)},'transparent');
end

legend([ColorPref(1:8)],{'-8' '-5' '-3' '-2' '2' '3' '5' '8'})
% legend([ColorPref(1:4)],{'0' '3' '5' '8'});
xlabel('Trial #');ylabel(variable);
set(gca,'Xtick',linspace(0,trialcutoff/bin_size,9),'XTickLabel',bin_size*linspace(0,trialcutoff/bin_size,9));
titlestr=sprintf(strcat('Average over Subject, ', variable ,', trial 1-%g'),trialcutoff);
title(titlestr);
% cd(graphfolder);
% savefig(titlestr);
% print(titlestr,'-dpdf');
cd(expfolder);

%%  Batched Delta Line graphs by trial

ColorSet=jet(18);

del8count=1;
del5count=1;
del3count=1;
del2count=1;
deln2count=1;
deln3count=1;
deln5count=1;
deln8count=1;

clear Delta1 Delta2

for subj=1:18
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>2
            condition_prev=char(conditions{subj}(c-1));
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==2
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        delta_condition1(delcount)=condition_cur-condition_prev;
        delta_condition1(loopnumber)=condition_cur-condition_prev;
         
        switch delta_condition
            case -8
                Delta1(1,deln8count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                deln8count=deln8count+1;
            case -5
                Delta1(2,deln5count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                deln5count=deln5count+1;
            case -3
                Delta1(3,deln3count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                deln3count=deln3count+1;
            case -2
                Delta1(4,deln2count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                deln2count=deln2count+1;
            case 2
                Delta1(5,del2count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del2count=del2count+1;
            case 3
                Delta1(6,del3count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del3count=del3count+1;
            case 5
                Delta1(7,del5count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del5count=del5count+1;
            case 8
                Delta1(8,del8count,1:200)=Data{c,subj}.avevel.all/mean(Data{c-1,subj}.avevel.all(196:200));
                del8count=del8count+1;
        end
        
    end    
end

for k=1:8
    for j=1:200
        if (k==1 | k==4 | k==5 | k==8)
            Delta2(k,j)=mean(Delta1(k,1:6,j));
        else
            Delta2(k,j)=mean(Delta1(k,:,j));
        end
    end
end

figure(1);
hold on
for k=1:8
    ColorPref(k)=plot(1:200,Delta2(k,:),'Color',ColorSet(k*2,:),'MarkerFaceColor',ColorSet(k*2,:));
end
legend([ColorPref(:)],delcondstr)
xlabel('Trial #');ylabel('Velocity Normalized to last condition of previous block');
titlestr=sprintf('Average over Subject Velocity norm to prev cond',subj);
title(titlestr);
cd(graphfolder);
savefig(titlestr);
cd(expfolder);

%% Individual subjects delta line plots
graphfolder=[expfolder '\' 'Graphs' '\' 'Delta Velocity graphs by subject'];

for subj=1:18
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>2
            condition_prev=char(conditions{subj}(c-1));
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==2
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        delta_condition1(delcount)=condition_cur-condition_prev;
        delta_condition1(loopnumber)=condition_cur-condition_prev;
        
        figure(subj)
        ColorSet=parula(18);
        hold on
        %Plot Individual Subjects
        switch delta_condition
            case -8
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(1,:),'MarkerFaceColor',ColorSet(1,:));
                lgnd(c-2)={'-8'};
            case -5
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(3,:),'MarkerFaceColor',ColorSet(3,:));;
                lgnd(c-2)={'-5'};
            case -3
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(5,:),'MarkerFaceColor',ColorSet(5,:));;
                lgnd(c-2)={'-3'};
            case -2
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(7,:),'MarkerFaceColor',ColorSet(7,:));;
                lgnd(c-2)={'-2'};
            case 2
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(9,:),'MarkerFaceColor',ColorSet(9,:));;
                lgnd(c-2)={'2'};
            case 3
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(11,:),'MarkerFaceColor',ColorSet(11,:));;
                lgnd(c-2)={'3'};
            case 5
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(13,:),'MarkerFaceColor',ColorSet(13,:));;
                lgnd(c-2)={'5'};
            case 8
                ColorPref(c-2)=plot(1:200,Data{c,subj}.avevel.all/Data{c-1,subj}.avevel.all(200),'Color',ColorSet(15,:),'MarkerFaceColor',ColorSet(15,:));;
                lgnd(c-2)={'8'};
        end
        
        subjid = subjarray{subjtoload(subj)};
                
        Condition{c,subj}.current=condition_cur;
        Condition{c,subj}.delta=delta_condition;
    end
    legend([ColorPref(:)],lgnd(1:4));
    xlabel('Trial #');ylabel('Velocity Normalized to last condition of previous block');
    titlestr=sprintf('Subject %g Velocity norm to prev cond',subj);
    title(titlestr);
    cd(graphfolder);
    savefig(titlestr);
    cd(expfolder);
end
 

%% Plotting reaction times
clear ColorPref

for subj=1:18
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>2
            condition_prev=char(conditions{subj}(c-1));
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==2
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        delta_condition1(delcount)=condition_cur-condition_prev;
        delta_condition1(loopnumber)=condition_cur-condition_prev;
              
        subjid = subjarray{subjtoload(subj)};
                
        Condition{c,subj}.current=condition_cur;
        Condition{c,subj}.delta=delta_condition;
        
        figure(1);
%         ColorPref(Color)=plot(c-1,PrefSpeed.all(c,subj),'o','Color',ColorSet(Color * 2,:),'MarkerFaceColor',ColorSet(Color * 2,:),'LineWidth',3);

        hold on
        %Plotting reaction times normalized to previous condition
        ColorPref(1)=plot(delta_condition,Data{c,subj}.reaction_vthres(1)/mean(Data{c-1,subj}.reaction_vthres(195:200)),'o','Color',ColorSet(2,:),'MarkerFaceColor',ColorSet(2,:),'LineWidth',2);
        ColorPref(2)=plot(delta_condition,Data{c,subj}.reaction_vthres(2)/mean(Data{c-1,subj}.reaction_vthres(195:200)),'o','Color',ColorSet(10,:),'MarkerFaceColor',ColorSet(10,:),'LineWidth',2);
        ColorPref(3)=plot(delta_condition,Data{c,subj}.reaction_vthres(3)/mean(Data{c-1,subj}.reaction_vthres(195:200)),'o','Color',ColorSet(17,:),'MarkerFaceColor',ColorSet(17,:),'LineWidth',2);
        
        One(loopnumber)=Data{c,subj}.reaction_vthres(1)/mean(Data{c-1,subj}.reaction_vthres(195:200));
        Two(loopnumber)=Data{c,subj}.reaction_vthres(2)/mean(Data{c-1,subj}.reaction_vthres(195:200));
        Thr(loopnumber)=Data{c,subj}.reaction_vthres(3)/mean(Data{c-1,subj}.reaction_vthres(195:200));
    end
 end

legend([ColorPref(:)],delcondstr)

xlabel('Delta Condition');ylabel('RxnTime (Trial 1 norm to previous condition avg)');
title('Reaction time carryover');
[p,x1,yline,rsq_adj]=regression(delta_condition1,One,1);
plot(x1,yline,'Color',ColorSet(2,:)); refline(0,1);
rstring=sprintf('R^2 one = %f',rsq_adj);
text(5.2,2.2,rstring);

[p,x1,yline,rsq_adj]=regression(delta_condition1,Two,1);
plot(x1,yline,'Color',ColorSet(10,:)); refline(0,1);
rstring=sprintf('R^2 two = %f',rsq_adj);
text(5.2,2.1,rstring);

[p,x1,yline,rsq_adj]=regression(delta_condition1,Thr,1);
plot(x1,yline,'Color',ColorSet(17,:)); refline(0,1);
rstring=sprintf('R^2 thr = %f',rsq_adj);
text(5.2,2,rstring);
legend([ColorPref(:)],{'One' 'Two' 'Thr'})

%% Delta Line graphs by trial
% All subjects

ColorSet=jet(18);

p8count=1;
p5count=1;
p3count=1;
p0count=1;

loopnumber=0;
deln2count=1;
delnp3count=1;
delnp5count=1;
delnp8count=1;
clear Delta1 Delta2

trialcutoff=200;

for subj=1:12
%    figure(subj);
%    close all;
    delcount=0;
    for c=1:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>2
            condition_prev=char(conditions{subj}(c-1));
        else
            condition_prev='0';
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==2
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        delta_condition1(delcount)=condition_cur-condition_prev;
        delta_condition1(loopnumber)=condition_cur-condition_prev;
         
        switch condition_cur
            case 0
                Delta1(1,p0count,1:200)=Data{c,subj}.avevel.all/mean(Data{c,subj}.avevel.all(196:200));
                p0count=p0count+1;
            case 3
                Delta1(2,p3count,1:200)=Data{c,subj}.avevel.all/mean(Data{c,subj}.avevel.all(196:200));
                p3count=p3count+1;
            case 5
                Delta1(3,p5count,1:200)=Data{c,subj}.avevel.all/mean(Data{c,subj}.avevel.all(196:200));
                p5count=p5count+1;
            case 8
                Delta1(4,p8count,1:200)=Data{c,subj}.avevel.all/mean(Data{c,subj}.avevel.all(196:200));
                p8count=p8count+1;
        end
        
    end    
end

for k=1:4
    for j=1:trialcutoff
%         if (k==1 | k==4 | k==5 | k==8)
            Delta2(k,j)=mean(Delta1(k,1:6,j));
            Delta2er(k,j)=std(Delta1(k,1:6,j),[],2)/sqrt(6);
%         else
%             Delta2(k,j)=mean(Delta1(k,:,j));
%             Delta2er(k,j)=std(Delta1(k,1:6,j),[],2)/sqrt(12);
%         end
    end
end

figure(1);
hold on
for k=1:4
    ColorPref(k)=plot(1:trialcutoff,Delta2(k,:),'Color',ColorSet(k*2,:),'MarkerFaceColor',ColorSet(k*2,:));
%     lineprops=ColorPref(k);
   shadedErrorBar(1:trialcutoff,Delta2(k,1:trialcutoff),Delta2er(k,1:trialcutoff),{'Color',ColorSet(k*2,:),'MarkerFaceColor',ColorSet(k*2,:)},'transparent');
end
legend([ColorPref(:)],{'0' '3' '5' '8'})
xlabel('Trial #');ylabel('Velocity Normalized to end of block');
titlestr=sprintf('Average over Subject Velocity norm to end of block, trial 1-%g',trialcutoff);
title(titlestr);
% cd(graphfolder);
% savefig(titlestr);
% print(titlestr,'-dpdf');
cd(expfolder);


%% Sensitivity Plots

TrialCutoff=1;
delcount=0;
loopnumber=0;
ColorSet=parula(18);

del8count=1;
del5count=1;
del3count=1;
del2count=1;
deln2count=1;
deln3count=1;
deln5count=1;
deln8count=1;
clear Delta1 Delta2 delta_condition1

trialcutoff=20;

figure(figure_count);
hold on;

for subj=1:18
%    figure(subj);
%    close all;
    delcount=0;
    for c=3:nc
        loopnumber=loopnumber+1;
        condition_cur=char(conditions{subj}(c));
        if c>2
            condition_prev=char(conditions{subj}(c-1));
        end
        
        if strcmp(condition_cur,'fml')
%             condition=1;
        elseif strcmp(condition_cur,'0')
            condition_cur=0;
            condition_cur1=0;
        elseif strcmp(condition_cur,'3')
            condition_cur=3;
            condition_cur1=3;
        elseif strcmp(condition_cur,'5')
            condition_cur=5;
            condition_cur1=5;
        elseif strcmp(condition_cur,'8')
            condition_cur=8;
            condition_cur1=8;
        elseif strcmp(condition_cur,'0f')
            condition_cur=0;
            condition_cur1=10;
        end
        
        if c==2
            condition_prev=0;
        end
        
        if strcmp(condition_prev,'fml')
%             condition=1;
        elseif strcmp(condition_prev,'0')
            condition_prev=0;
        elseif strcmp(condition_prev,'3')
            condition_prev=3;
        elseif strcmp(condition_prev,'5')
            condition_prev=5;
        elseif strcmp(condition_prev,'8')
            condition_prev=8;
        elseif strcmp(condition_prev,'0f')
            condition_prev=0;                
        end
        
        delcount=delcount+1;
        
        delta_condition=condition_cur-condition_prev;
        delta_condition1(delcount)=condition_cur-condition_prev;
        delta_condition1(loopnumber)=condition_cur-condition_prev;
        
        Sensitivity(c,subj) = (PrefSpeed.totarget(c,subj)-PrefSpeed.totarget(2,subj))/delta_condition;        
    end
    SensArray(subj) = (PrefSpeed.totarget(c,subj)-PrefSpeed.totarget(2,subj))/delta_condition;
    SpeedArray(subj) = PrefSpeed.totarget(2,subj);
    hold on
    plot(PrefSpeed.totarget(2,subj),mean(Sensitivity(3:6,subj)),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
end

xlabel('0 Condition Velocity');ylabel('Average Sensitivity to change in Mass');
title('Sensitivity to Initial Velocity');
[p,x1,yline,rsq_adj]=regression(SpeedArray,SensArray,1);
plot(x1,yline,'Color',ColorSet(2,:));% refline(0,1);x
rstring=sprintf('R^2 = %f',rsq_adj);
ystring=sprintf('y = %g * x + %g', p(1),p(2));
text(.2,-9e-3,rstring);
text(.2,-11e-3,ystring);

% load('Data-UnorderedwithFML.mat');

% cd(expfolder);

loopnumber=0;
TrialCutoff=1;
delcount=0;
Colors = jet(5);

trialstring={'Trial 1' 'Trial 2' 'Trial 3' 'Trial 4' 'Average'};

for subj=1:nsubj
%    figure(subj);
%    close all;
    delcount=0;
    hold on
    for c=2:nc
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
        tr_count=TrialCutoff;
        
        firstavg(loopnumber)=mean(Data{c,subj}.avevel.all(1:5));%-Data{c-1,subj}.avevel.all(1:5));
        lastavg(loopnumber)=mean(Data{c,subj}.avevel.all(6:200));%-Data{c-1,subj}.avevel.all(6:200));
        
%         Color(1)=plot(delta_condition,firstavg(delcount),'o','Color',ColorSet(3,:),'MarkerFaceColor',ColorSet(3,:),'LineWidth',1);
%         Color(2)=plot(delta_condition,lastavg(delcount),'o','Color',ColorSet(15,:),'MarkerFaceColor',ColorSet(15,:),'LineWidth',1);
%         
%         plot(Data{c,subj}.avevel.all,'Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:),'LineWidth',1);
        
        
%         
%         Color(1)=plot(delta_condition,Data{c,subj}.avevel.all(1),'o','Color',ColorSet(3,:),'MarkerFaceColor',ColorSet(3,:),'LineWidth',1);
%         Color(2)=plot(delta_condition,Data{c,subj}.avevel.all(2),'o','Color',ColorSet(6,:),'MarkerFaceColor',ColorSet(6,:),'LineWidth',1);
%         Color(3)=plot(delta_condition,Data{c,subj}.avevel.all(3),'o','Color',ColorSet(9,:),'MarkerFaceColor',ColorSet(9,:),'LineWidth',1);
%         Color(4)=plot(delta_condition,Data{c,subj}.avevel.all(4),'o','Color',ColorSet(12,:),'MarkerFaceColor',ColorSet(11,:),'LineWidth',1);
%         Color(5)=plot(delta_condition,lastavg(delcount),'o','Color',ColorSet(15,:),'MarkerFaceColor',ColorSet(15,:),'LineWidth',1);
%         legend([Color(:)],trialstring);
%         
%         One(loopnumber)=Data{c,subj}.avevel.all(1);
%         Two(loopnumber)=Data{c,subj}.avevel.all(2);
%         Three(loopnumber)=Data{c,subj}.avevel.all(3);
%         Four(loopnumber)=Data{c,subj}.avevel.all(4);
%         Five(loopnumber)=lastavg(delcount);
%                         
%         velo(1,delcount)=Data{c,subj}.avevel.all(1);
%         velo(2,delcount)=Data{c,subj}.avevel.all(2);
%         velo(3,delcount)=Data{c,subj}.avevel.all(3);
%         velo(4,delcount)=Data{c,subj}.avevel.all(4);
%         velo(5,delcount)=Data{c,subj}.avevel.all(5);
%         
        
        
    end
    
%     xlabel('Delta Condition');ylabel('Velocity m/s');title(subj);
%     
%     for q=1:5
%         [p,x1,yline,rsq_adj]=regression(delta_condition1,velo(q,:),1);
%         plot(x1,yline,'Color',ColorSet(3*q,:)); %refline(0,0);
%     end   
%     
%    hold off
end


%         [p,x1,yline,rsq_adj]=regression(delta_condition1,One,1);
%         Color1(1)=plot(x1,yline,'Color',ColorSet(3,:)); %refline(0,0);
%         [p,x1,yline,rsq_adj]=regression(delta_condition1,Two,1);
%         Color1(2)=plot(x1,yline,'Color',ColorSet(6,:)); %refline(0,0);
%         [p,x1,yline,rsq_adj]=regression(delta_condition1,Three,1);
%         Color1(3)=plot(x1,yline,'Color',ColorSet(9,:)); %refline(0,0);
%         [p,x1,yline,rsq_adj]=regression(delta_condition1,Four,1);
%         Color1(4)=plot(x1,yline,'Color',ColorSet(12,:)); %refline(0,0);
%         [p,x1,yline,rsq_adj]=regression(delta_condition1,Five,1);
%         Color1(5)=plot(x1,yline,'Color',ColorSet(15,:)); %refline(0,0);
%         xlabel('Delta Condition');ylabel('Avg Speed m/s');

Color(1)=plot(delta_condition1,firstavg,'o','Color',ColorSet(3,:),'MarkerFaceColor',ColorSet(3,:));
Color(2)=plot(delta_condition1,lastavg,'o','Color',ColorSet(15,:),'MarkerFaceColor',ColorSet(15,:));

[p,x1,yline,rsq_adj]=regression(delta_condition1,firstavg,1);
Color(1)=plot(x1,yline,'Color',ColorSet(3,:)); %refline(0,0);
[p,x1,yline,rsq_adj]=regression(delta_condition1,lastavg,1);
Color(2)=plot(x1,yline,'Color',ColorSet(15,:)); %refline(0,0);
legend([Color(:)],{'First Avg' 'Last Avg'});
xlabel('Change in mass from previous condition');ylabel('Change in Speed');

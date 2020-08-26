cd(expfolder);

% fileID=fopen('VeloctiybyTrial_avg2.csv','w');
fileID=fopen('PathlengthbyTrial.csv','w');

TrialCutoff=1;

nTrials_speed=200;


order(1)=3;
order(2)=2;
order(3)=1;
order(4)=4;
order(5)=5;
order(6)=6;
order(7)=1;
order(8)=2;
order(9)=3;
order(10)=4;
order(11)=5;
order(12)=6;
order(13)=1;
order(14)=2;
order(15)=4;
order(16)=3;
order(17)=5;
order(18)=6;

delcount=0;

for subj=1:nsubj
    
    subjid = subjarray{subjtoload(subj)};
    tr_count=TrialCutoff;
    
    for c=2:nc %Check if using FML or not
        
%         if (strcmp(subjid,'PLO')&c==1);
%             c=2;
%         end
%         
%         if c==1
%             popts.totaltrials=100;
%             nTrials_speed=100;
%         elseif c~=1
%             popts.totaltrials=200;
%             nTrials_speed=200;
%         end
        
%         condition_cur=char(conditions{subj}(c));
        condition_cur=char(conditions{c});
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
                
        for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials

%         for i=TrialCutoff:popts.totaltrials
            if c~=2
                Delta_Velocity=Data{c,subj}.avevel.all(i)-Data{c-1,subj}.avevel.all(i);
            else
                Delta_Velocity=0;
            end
            
            %A=[subj delta_condition condition_cur order(subj) tr_count Data{c,subj}.avevel.all(i)];
            
            %This A is for delta velocities
%             A=[subj delta_condition condition_cur1 order(subj) Data{c,subj}.targetnumber(i) tr_count Data{c,subj}.avevel.all(i) Delta_Velocity];
            
            %This A is for Path Lengths
            A=[subj delta_condtion condition_cur order(subj) Data{c,subj}.pathlength.all(i);

            fprintf(fileID,'%f ',A);
            fprintf(fileID,'\n');
            tr_count=tr_count+1;
        end
%         

        
%         DeltaSpeed=PrefSpeed.all(c,subj)-PrefSpeed.all(c-1,subj);
%         DeltaSpeed1(delcount)=PrefSpeed.all(c,subj)-PrefSpeed.all(c-1,subj);
        
%         A=[subj delta_condition condition_cur DeltaSpeed];
%         fprintf(fileID,'%f ',A);
%         fprintf(fileID,'\n');
%         tr_count=tr_count+1;
        
%         hold on
%         ColorPref(c)=plot(delta_condition1(delcount), DeltaSpeed1(delcount),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:),'LineWidth',1);
%         xlabel('Delta Condtion');ylabel('Delta Speed');title(['Delta Condtion vs Delta Speed, 1st order']);
       
        
    end
    
end

% p=polyfit(delta_condition1,DeltaSpeed1,1);
% y=DeltaSpeed1;
% x=-8:.05:8;
% %yfit=p(1).*x.^3+p(2)*x.^2+p(3)*x+p(4);
% 
% yfit=p(1)*x+p(2);
% 
% plot(x,yfit)
% 
% yfit = polyval(p,delta_condition1);
% yresid = DeltaSpeed - yfit;
% SSresid = sum(yresid.^2);
% SStotal = (length(y)-1) * var(y);
% rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(p));
% 
% hold on
% [p,x1,yline,rsq_adj]=regression(delta_condition1,DeltaSpeed1,1);
% plot(x1,yline); refline(0,0);
% 
% text(4,.05,['R^2 = ' num2str(rsq_adj)]);
% % text([4,.05,num2str(p)]);

% fclose(fileID);
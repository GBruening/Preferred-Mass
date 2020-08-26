%Load Undorded without FML

projpath = 'F:\Documents\School notes\Grad School\';
%  projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);
cd(expfolder);

% fileID=fopen('VeloctiybyTrial_avg2.csv','w');
% fileID=fopen('FullData_noFML_no0f.csv','w');
fileID=fopen('FullData_noFML.csv','w');

TrialCutoff=101;

nTrials_speed=100;

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

A=['subj ' 'condition ' 'delcond ' 'order ' 'targetnum ' 'trial ' 'pathltar ' 'pathlall ' 'maxex ' 'avevel ' 'peakvel ' 'missangle ' 'absmissangle ' 'corrang' 'reaction_vthres2'];

fprintf(fileID,A);
fprintf(fileID,'\n');


for subj=1:nsubj
    
    subjid = subjarray{subjtoload(subj)};
    tr_count=TrialCutoff;
    
    if subj~=15
        
        for c=1:(nc-1) %Check if using FML or not

            condition_cur=char(conditions{subj}(c));

            if c>=2
                condition_prev=char(conditions{subj}(c-1));
            end

            if strcmp(condition_cur,'fml')
                condition_cur=0;
                condition_cur1=0;
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
                condition_cur=0;
                condition_cur1=0;
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
            
            if c~=1
                for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
                    %This A is for Everything
                    A=[subj condition_cur delta_condition1(delcount) order(subj) Data{c,subj}.targetnumber(i) tr_count Data{c,subj}.pathlength.totarget(i) Data{c,subj}.pathlength.all(i) max(Data{c,subj}.P(:,i)) Data{c,subj}.avevel.all(i) Data{c,subj}.peakvel.all(i) Data{c,subj}.miss_angle(i) abs(Data{c,subj}.miss_angle(i)) Data{c,subj}.corr_angle(i) Data{c,subj}.reaction_vthres2(i)];

                    fprintf(fileID,'%f ',A);
                    fprintf(fileID,'\n');
                    tr_count=tr_count+1;                
                end    
            elseif c==1
                for i=1:100
                    %This A is for Everything
                    A=[subj condition_cur delta_condition1(delcount) order(subj) Data{c,subj}.targetnumber(i) tr_count Data{c,subj}.pathlength.totarget(i) Data{c,subj}.pathlength.all(i) max(Data{c,subj}.P(:,i)) Data{c,subj}.avevel.all(i) Data{c,subj}.peakvel.all(i) Data{c,subj}.miss_angle(i) abs(Data{c,subj}.miss_angle(i)) Data{c,subj}.corr_angle(i) Data{c,subj}.reaction_vthres2(i)];

                    fprintf(fileID,'%f ',A);
                    fprintf(fileID,'\n');
                    tr_count=tr_count+1;                
                end
            end
        end
    else
        for c=2:(nc-1) %Check if using FML or not

            condition_cur=char(conditions{subj}(c));

            if c>=2
                condition_prev=char(conditions{subj}(c-1));
            end

            if strcmp(condition_cur,'fml')
                condition_cur=0;
                condition_cur1=0;
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
                condition_cur1=0;
            end

            if c==2
                condition_prev=0;
            end

            if strcmp(condition_prev,'fml')
                condition_cur=0;
                condition_cur1=0;
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
            if c~=1
                for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
                    %This A is for Everything
                    A=[subj...
                         condition_cur...
                         delta_condition1(delcount) ...
                        order(subj) ...
                        Data{c,subj}.targetnumber(i) ...
                        tr_count ...
                        Data{c,subj}.pathlength.totarget(i) ...
                        Data{c,subj}.pathlength.all(i) ...
                        max(Data{c,subj}.P(:,i)) ...
                        Data{c,subj}.avevel.all(i) ...
                        Data{c,subj}.peakvel.all(i) ...
                        Data{c,subj}.miss_angle(i) ...
                        abs(Data{c,subj}.miss_angle(i)) ...
                        Data{c,subj}.corr_angle(i) ...
                        Data{c,subj}.reaction_vthres2(i)];

                    fprintf(fileID,'%f ',A);
                    fprintf(fileID,'\n');
                    tr_count=tr_count+1;                
                end    
            elseif c==1
                for i=1:100
                    %This A is for Everything
                    A=[subj...
                        condition_cur...
                        delta_condition1(delcount)...
                        order(subj) Data{c,subj}.targetnumber(i)...
                        tr_count Data{c,subj}.pathlength.totarget(i)...
                        Data{c,subj}.pathlength.all(i) max(Data{c,subj}.P(:,i))...
                         Data{c,subj}.avevel.all(i)...
                         Data{c,subj}.peakvel.all(i)...
                         Data{c,subj}.miss_angle(i)...
                         abs(Data{c,subj}.miss_angle(i))...
                         Data{c,subj}.corr_angle(i)...
                         Data{c,subj}.reaction_vthres2(i)];

                    fprintf(fileID,'%f ',A);
                    fprintf(fileID,'\n');
                    tr_count=tr_count+1;                
                end
            end           
        end
    end
        
end

fclose(fileID);
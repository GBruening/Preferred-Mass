% Load unordered Data




% projpath = 'F:\Documents\School notes\Grad School\';
 projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
expname = 'Mass';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);
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

A=['subj ' 'Conditon ' 'Trial ' 'PathL ' 'Speed'];

fprintf(fileID,A);
fprintf(fileID,'\n');


for subj=1:nsubj
    
    subjid = subjarray{subjtoload(subj)};
    tr_count=TrialCutoff;
    
    for c=1:nc %Check if using FML or not
        
        condition_cur=char(conditions{subj}(c));
        
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
        
        
        delcount=delcount+1;
                
%         if c~=1
%             for i=1:200
% 
%                 %This A is for Path Lengths
%                 A=[subj c tr_count Data{c,subj}.pathlength.all(i) Data{2,1}.avevel.all(i)];
% 
%                 fprintf(fileID,'%f ',A);
%                 fprintf(fileID,'\n');
%                 tr_count=tr_count+1;
%             end
%         else
             for i=1:200
                %This A is for Path Lengths
%                 c
%                 subj
%                 i
                A=[subj condition_cur tr_count Data{c,subj}.pathlength.all(i) Data{2,1}.avevel.all(i)];

                fprintf(fileID,'%f ',A);
                fprintf(fileID,'\n');
                tr_count=tr_count+1;
             end
%         end

    end
end

fclose(fileID);
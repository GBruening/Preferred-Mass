% Control path length graphing
% Load control data

% projpath = 'F:\Documents\School notes\Grad School\';
 projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);
cd(expfolder);

% fileID=fopen('VeloctiybyTrial_avg2.csv','w');
fileID=fopen('ControlData.csv','w');

TrialCutoff=1;

nTrials_speed=200;

delcount=0;

A=['subj ' 'Block ' 'Trial ' 'PathL ' 'Speed'];

fprintf(fileID,A);
fprintf(fileID,'\n');


for subj=1:nsubj
    
    subjid = subjarray{subjtoload(subj)};
    tr_count=TrialCutoff;
    
    for c=1:nc %Check if using FML or not
        
        condition_cur=char(conditions{c});
        
        delcount=delcount+1;
        
        if c~=1
            for i=1:200

                %This A is for Path Lengths
                A=[subj c tr_count Data{c,subj}.pathlength.all(i) Data{2,1}.avevel.all(i)];

                fprintf(fileID,'%f ',A);
                fprintf(fileID,'\n');
                tr_count=tr_count+1;
            end
        else
             for i=1:100
                %This A is for Path Lengths
                A=[subj c tr_count Data{c,subj}.pathlength.all(i) Data{2,1}.avevel.all(i)];

                fprintf(fileID,'%f ',A);
                fprintf(fileID,'\n');
                tr_count=tr_count+1;
             end
        end
    end
end

fclose(fileID);
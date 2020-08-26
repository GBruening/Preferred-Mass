projpath = 'F:\Documents\School notes\Grad School\';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);
cd(expfolder);

% fileID=fopen('VeloctiybyTrial_avg2.csv','w');
fileID=fopen('FullData_control.csv','w');

TrialCutoff=1;

nTrials_speed=200;
delcount=0;

A=['subj ' 'targetnum ' 'trial ' 'pathltar ' 'tathlall ' 'maxex ' 'avevel ' 'peakvel ' 'missangle ' 'absmissangle ' 'corrang'];

fprintf(fileID,A);
fprintf(fileID,'\n');

for subj=1:nsubj    
    subjid = subjarray{subjtoload(subj)};
    tr_count=TrialCutoff;    
    for c=1:nc %Check if using FML or not 
       if c~=1
            for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
                %This A is for Everything
                A=[subj Data{c,subj}.targetnumber(i) tr_count Data{c,subj}.pathlength.totarget(i) Data{c,subj}.pathlength.all(i) max(Data{c,subj}.P(:,i)) Data{c,subj}.avevel.all(i) Data{c,subj}.peakvel.all(i) Data{c,subj}.miss_angle(i) abs(Data{c,subj}.miss_angle(i)) Data{c,subj}.corr_angle(i)];

                fprintf(fileID,'%f ',A);
                fprintf(fileID,'\n');
                tr_count=tr_count+1;
            end
        elseif strcmp(char(conditions{c}),'fml')
            for i=1:100
                %This A is for Everything
                A=[subj Data{c,subj}.targetnumber(i) tr_count Data{c,subj}.pathlength.totarget(i) Data{c,subj}.pathlength.all(i) max(Data{c,subj}.P(:,i)) Data{c,subj}.avevel.all(i) Data{c,subj}.peakvel.all(i) Data{c,subj}.miss_angle(i) abs(Data{c,subj}.miss_angle(i)) Data{c,subj}.corr_angle(i)];

                fprintf(fileID,'%f ',A);
                fprintf(fileID,'\n');
                tr_count=tr_count+1;
            end
        end
    end    
end

clear A tr_count delcount

fclose(fileID);
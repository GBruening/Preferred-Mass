% Do the math

projpath = 'F:\Documents\School notes\Grad School\';
%  projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
expname = 'Mass';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);

section_cells={'all' 'totarget' 'tomoveback' 'back'};
nsec=length(section_cells);
section=section_cells{1};

nTrials_speed=100;
trial_number=num2str(nTrials_speed);

Avgendpt_one_count=1;
Avgendpt_two_count=1;
Avgendpt_thr_count=1;
Avgendpt_fou_count=1;

for subj = 1:nsubj
    subjid = subjarray{subjtoload(subj)};
    nTrials_speed = 200; % look at last X trials only; for all, popts.totaltrials
    for c=1:nc  %Check to see if were using FML or not
%         condition=char(conditions{subj}(c));        
%         if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
%             c=2;
%             condition=char(conditions{subj}(c));
%         end
        
        condition=char(conditions(c));
        if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
            c=2;
            condition=char(conditions(c));
        end

        tr_count = 1;
        
        tarone_count=1;
        tartwo_count=1;
        tarthr_count=1;
        tarfou_count=1;
        
        if strcmp(condition,'fml')
            popts.totaltrials=100;
            nTrials_speed=100;
        elseif ~strcmp(condition,'fml')
            popts.totaltrials=200;
            nTrials_speed=200;
        end
        
        for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials            
            %Create new data stucture target for variables depending on
            %target
            switch Data{c,subj}.targetnumber(i)
                case 1
                    TargetData{c,subj}.one.PrefSpeed(tarone_count)=Data{c,subj}.avevel.(section)(i);
                    TargetData{c,subj}.one.PeakSpeed(tarone_count)=Data{c,subj}.peakvel.(section)(i);
                    TargetData{c,subj}.one.ReactionVthres(tarone_count)=Data{c,subj}.reaction_vthres(i);                    
                    AvgAngle.one(Avgendpt_one_count)=Data{c,subj}.moveangle(i);
                    Avgendpt_one_count=Avgendpt_one_count+1;                    
                    tarone_count=tarone_count+1;
                case 2
                    TargetData{c,subj}.two.PrefSpeed(tartwo_count)=Data{c,subj}.avevel.(section)(i);
                    TargetData{c,subj}.two.PeakSpeed(tartwo_count)=Data{c,subj}.peakvel.(section)(i);
                    TargetData{c,subj}.two.ReactionVthres(tartwo_count)=Data{c,subj}.reaction_vthres(i);                    
                    AvgAngle.two(Avgendpt_two_count)=Data{c,subj}.moveangle(i);
                    Avgendpt_two_count=Avgendpt_two_count+1;                    
                    tartwo_count=tartwo_count+1;
                case 3
                    TargetData{c,subj}.thr.PrefSpeed(tarthr_count)=Data{c,subj}.avevel.(section)(i);
                    TargetData{c,subj}.thr.PeakSpeed(tarthr_count)=Data{c,subj}.peakvel.(section)(i);
                    TargetData{c,subj}.thr.ReactionVthres(tarthr_count)=Data{c,subj}.reaction_vthres(i);                    
                    AvgAngle.thr(Avgendpt_thr_count)=Data{c,subj}.moveangle(i);
                    Avgendpt_thr_count=Avgendpt_thr_count+1;
                    tarthr_count=tarthr_count+1;                    
                case 4
                    TargetData{c,subj}.fou.PrefSpeed(tarfou_count)=Data{c,subj}.avevel.(section)(i);
                    TargetData{c,subj}.fou.PeakSpeed(tarfou_count)=Data{c,subj}.peakvel.(section)(i);
                    TargetData{c,subj}.fou.ReactionVthres(tarfou_count)=Data{c,subj}.reaction_vthres(i);                    
                    AvgAngle.fou(Avgendpt_fou_count)=Data{c,subj}.moveangle(i);
                    Avgendpt_fou_count=Avgendpt_fou_count+1;                    
                    tarfou_count=tarfou_count+1;                    
            end
        end
        fprintf('Subject %s %s Condition %s Processed\n',subj,subjid,condition);
     end
end

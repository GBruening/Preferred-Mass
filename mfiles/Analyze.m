% Do the math
%  projpath = 'F:\Documents\School notes\Grad School\';
% projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
% expname = 'Mass';
% datafolder = [projpath expname filesep 'Pilot_data'];
% expfolder= [projpath expname];
% addpath([projpath filesep expname filesep 'mfiles']);

nTrials_speed=200;
trial_number=num2str(nTrials_speed);

section_cells={'all' 'totarget' 'tomoveback' 'back'};
nsec=length(section_cells);
section=section_cells{1};

Avgendpt_one_count=ones(nc,subj);
Avgendpt_two_count=ones(nc,subj);
Avgendpt_thr_count=ones(nc,subj);
Avgendpt_fou_count=ones(nc,subj);

% Can use parfor but need to pre-initialize variables


PeakSpeed.totarget = zeros(nc,nsubj);
PeakSpeed.tomoveback = zeros(nc,nsubj);
PeakSpeed.back = zeros(nc,nsubj);
PeakSpeed.all = zeros(nc,nsubj);


for subj = 1:nsubj
    subjid = subjarray{subjtoload(subj)};
    %Curve related metrics

    % Write a loop for the different conditions, c, and trials, i.

%    nTrials_speed = 200; % look at last X trials only; for all, popts.totaltrials
    for c=1:nc
        tic
        if (strcmp(DataSelect,DataSet(1)) | strcmp(DataSelect,DataSet(2)))
            if (strcmp(subjid,'PLO') & strcmp(condition{c,subj},'fml'));
                continue
            end
        elseif strcmp(DataSelect,DataSet(3))
            if (strcmp(subjid,'PLO') & strcmp(condition{c,subj},'fml'));
                continue
            end
        end
        tr_count = 1;
        
        if strcmp(DataSetsSelect,'Pilot')
            if strcmp(condition{c,subj},'fml')
                popts.totaltrials=100;
                nTrials_speed=100;
                Data{c,subj}.stateframes=zeros([8,100]);
            elseif ~strcmp(condition{c,subj},'fml')
                popts.totaltrials=200;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,200]);
            end
        elseif strcmp(DataSetsSelect,'Not_Pilot')
            if strcmp(condition{c,subj},'fml')
                popts.totaltrials=400;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,400]);
            elseif ~strcmp(condition{c,subj},'fml')
                popts.totaltrials=200;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,200]);
            end
        elseif strcmp(DataSetsSelect,'ArcT')
            if strcmp(condition{c,subj},'fml')
                popts.totaltrials=200;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,400]);
            elseif ~strcmp(condition{c,subj},'fml')
                popts.totaltrials=200;
                nTrials_speed=150;
                Data{c,subj}.stateframes=zeros([8,200]);
            end
        end
        tarone_count=1;
        tartwo_count=1;
        tarthr_count=1;
        tarfou_count=1;
        
        Data{c,subj}.overshoot=0;
        
        for i = 1:popts.totaltrials
            %Target Number
            x1 = 0.070710725027900; x2 = -0.070710537390700; y1 = 0.070710818846400; y2 = -0.070710631209400;
            if abs(Data{c,subj}.targetposition_act(i,2)-y1)<.00001
                if abs(Data{c,subj}.targetposition_act(i,1)-x1)<.00001
                    Data{c,subj}.targetnumber(tr_count)=1;
                elseif abs(Data{c,subj}.targetposition_act(i,1)-x2)<.00001
                    Data{c,subj}.targetnumber(tr_count)=2;
                end
            elseif abs(Data{c,subj}.targetposition_act(i,2)-y2)<.00001
                if abs(Data{c,subj}.targetposition_act(i,1)-x1)<.00001
                    Data{c,subj}.targetnumber(tr_count)=4;
                elseif abs(Data{c,subj}.targetposition_act(i,1)-x2)<.00001
                    Data{c,subj}.targetnumber(tr_count)=3;
                end
            end
            if Data{c,subj}.targetposition_act(i,1)==0
                Data{c,subj}.targetnumber(tr_count) = Data{c,subj}.targetnumber(tr_count-1)+4;
            end
            
            %Movement Duration
            % Uses idxonset which is tangential velocity
            Data{c,subj}.timings.movedur.frames(tr_count)=MT{c,subj}.idxendpt(i)-MT{c,subj}.idxonset(i);
            Data{c,subj}.timings.movedur.sec(tr_count)=.005*(MT{c,subj}.idxendpt(i)-MT{c,subj}.idxonset(i));
            Data{c,subj}.timings.timetotarget(tr_count)=.005*MT{c,subj}.idxtarget(i);
            Data{c,subj}.timings.targetshow(tr_count)=(T{c,subj}.framedata(i).time_ms(MT{c,subj}.robotstates.wait4mvt(i))-T{c,subj}.framedata(i).time_ms(MT{c,subj}.robotstates.home(i)))/1000;
            Data{c,subj}.timings.reaction(tr_count)=(T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxonset(i))-T{c,subj}.framedata(i).time_ms(MT{c,subj}.robotstates.wait4mvt(i)))/1000;
            Data{c,subj}.timings.reacttotar(tr_count)=(T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxtarget(i))-T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxonset(i)))/1000;
            Data{c,subj}.timings.reacttoendpt(tr_count)=(T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxendpt(i))-T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxonset(i)))/1000;
            if Data{c,subj}.timings.reacttoendpt(tr_count)>1.3
                1;
            end
            if (i~=popts.totaltrials) %% & i~=21)
                Data{c,subj}.timings.tartotrial(tr_count)=(T{c,subj}.framedata(i+1).time_ms(MT{c,subj}.robotstates.wait4mvt(i+1))-T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxtarget(i)))/1000;
                Data{c,subj}.timings.trialtime(tr_count)=(T{c,subj}.framedata(i+1).time_ms(1)-T{c,subj}.framedata(i).time_ms(1))/1000;
            else
                Data{c,subj}.timings.tartotrial(tr_count)=(max(T{c,subj}.framedata(i).time_ms)-T{c,subj}.framedata(i).time_ms(MT{c,subj}.idxendpt(i)))/1000;
                Data{c,subj}.timings.trialtime(tr_count)=(max(T{c,subj}.framedata(i).time_ms)-T{c,subj}.framedata(i).time_ms(1))/1000;
            end 
            
            % Average velocity
            Data{c,subj}.avevel.totarget(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i)); %change idxendpt to idxtarget
            if isnan(Data{c,subj}.avevel.totarget(tr_count))
                1;
            end
            Data{c,subj}.avevel.tomoveback(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxmoveback(i),i));
%             Data{c,subj}.avevel.back(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxtarget(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.avevel.all(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i));
            
            % Peak velocity
            Data{c,subj}.peakvel.totarget(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i)); %change idxendpt to idxtarget
            Data{c,subj}.peakvel.tomoveback(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxmoveback(i),i));
%             Data{c,subj}.peakvel.back(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxtarget(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.peakvel.all(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.peakvel.RadV(tr_count) = max(Data{c,subj}.RadV(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i));
            
            % Average velocity2
            Data{c,subj}.avevel2.totarget(tr_count) = mean(Data{c,subj}.v_sign(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i)*Data{c,subj}.vsigns(i)); %change idxendpt to idxtarget
            if isnan(Data{c,subj}.avevel.totarget(tr_count))
                1;
            end
            Data{c,subj}.avevel2.tomoveback(tr_count) = mean(Data{c,subj}.v_sign(MT{c,subj}.idxonset(i):MT{c,subj}.idxmoveback(i),i)*Data{c,subj}.vsigns(i));
%             Data{c,subj}.avevel.back(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxtarget(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.avevel2.all(tr_count) = mean(Data{c,subj}.v_sign(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i)*Data{c,subj}.vsigns(i));
            
            % Peak velocity2
            Data{c,subj}.peakvel2.totarget(tr_count) = max(Data{c,subj}.v_sign(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i)*Data{c,subj}.vsigns(i)); %change idxendpt to idxtarget
            Data{c,subj}.peakvel2.tomoveback(tr_count) = max(Data{c,subj}.v_sign(MT{c,subj}.idxonset(i):MT{c,subj}.idxmoveback(i),i)*Data{c,subj}.vsigns(i));
%             Data{c,subj}.peakvel.back(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxtarget(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.peakvel2.all(tr_count) = max(Data{c,subj}.v_sign(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i)*Data{c,subj}.vsigns(i));
            
            
            %Max Excursion
            Data{c,subj}.MaxEx(tr_count)=max(Data{c,subj}.p(:,i));
            
            % Path length            
            %totarget
            PathL_tmp = 0;
            Px = Data{c,subj}.x; Py = Data{c,subj}.y;
            fr = MT{c,subj}.idxonset(i);
            while fr < MT{c,subj}.idxtarget(i) %change idxendpt to idxtarget
                X = [Px(fr,i),Py(fr,i);Px(fr+1,i),Py(fr+1,i)];
                PathL_tmp = PathL_tmp + pdist(X,'euclidean');
                fr = fr+1;
            end
            Data{c,subj}.pathlength.totarget(tr_count) = PathL_tmp;
            
            %tomoveback
            PathL_tmp = 0;
            Px = Data{c,subj}.x; Py = Data{c,subj}.y;
            fr = MT{c,subj}.idxonset(i);
            while fr < MT{c,subj}.idxmoveback(i) %change idxendpt to idxtarget
                X = [Px(fr,i),Py(fr,i);Px(fr+1,i),Py(fr+1,i)];
                PathL_tmp = PathL_tmp + pdist(X,'euclidean');
                fr = fr+1;
            end
            Data{c,subj}.pathlength.tomoveback(tr_count) = PathL_tmp;
            
            %Back
            PathL_tmp = 0;
            Px = Data{c,subj}.x; Py = Data{c,subj}.y;
            fr = MT{c,subj}.idxtarget(i);
            while fr < MT{c,subj}.idxendpt(i) %change idxendpt to idxtarget
                X = [Px(fr,i),Py(fr,i);Px(fr+1,i),Py(fr+1,i)];
                PathL_tmp = PathL_tmp + pdist(X,'euclidean');
                fr = fr+1;
            end
            Data{c,subj}.pathlength.back(tr_count) = PathL_tmp;
            
            %All
            PathL_tmp = 0;
            Px = Data{c,subj}.x; Py = Data{c,subj}.y;
            fr = MT{c,subj}.idxonset(i);
            while fr < MT{c,subj}.idxendpt(i) %change idxendpt to idxtarget
                X = [Px(fr,i),Py(fr,i);Px(fr+1,i),Py(fr+1,i)];
                PathL_tmp = PathL_tmp + pdist(X,'euclidean');
                fr = fr+1;
            end
            Data{c,subj}.pathlength.all(tr_count) = PathL_tmp;
                        
            %State Times
            fr = MT{c,subj}.idxonset(i);
            for k = 3:8
                Data{c,subj}.stateframes(k,i) = 0;
            end
            while fr < MT{c,subj}.idxendpt(i) %change idxendpt to idxtarget
                switch Data{c,subj}.statenumber(fr,i)
                    case 3
                        Data{c,subj}.stateframes(3,i)=Data{c,subj}.stateframes(3,i)+1;
                    case 4
                        Data{c,subj}.stateframes(4,i)=Data{c,subj}.stateframes(4,i)+1;
                    case 5
                        Data{c,subj}.stateframes(5,i)=Data{c,subj}.stateframes(5,i)+1;
                    case 6
                        Data{c,subj}.stateframes(6,i)=Data{c,subj}.stateframes(6,i)+1;
                    case 7
                        Data{c,subj}.stateframes(7,i)=Data{c,subj}.stateframes(7,i)+1;
                    case 8
                        Data{c,subj}.stateframes(8,i)=Data{c,subj}.stateframes(8,i)+1;
                end
                fr=fr+1;
            end
            
            % Reaction Times
            Data{c,subj}.reaction_robstate(tr_count)=MT{c,subj}.robotstates.movingout(i)-MT{c,subj}.robotstates.wait4mvt(i);
            Data{c,subj}.reaction_vthres(tr_count)=MT{c,subj}.idxonset(i)-MT{c,subj}.robotstates.wait4mvt(i);
            Data{c,subj}.reaction_tanv(tr_count)=MT{c,subj}.idxonset(i)-MT{c,subj}.robotstates.wait4mvt(i); 
            Data{c,subj}.reaction_tanvvel(tr_count) = Data{c,subj}.v_sign(MT{c,subj}.idxonset(i),i);
            
            % OverShoot
            if max(Data{c,subj}.p(:,i))>.11
                Data{c,subj}.overshoot=Data{c,subj}.overshoot+1;
            end
            
            % Accuracey
            X = [Data{c,subj}.targetposition(i,1),Data{c,subj}.targetposition(i,2);...
                 Data{c,subj}.x(MT{c,subj}.idxendpt(i),i),Data{c,subj}.y(MT{c,subj}.idxendpt(i),i)];
            Data{c,subj}.miss_dist(tr_count) = pdist(X,'euclidean');
            
            %Angular Miss
            if strcmp(DataSetsSelect,'Pref')
                if i == 1
                    initvector=[Data{c,subj}.x(MT{c,subj}.idxonset(i)+5,i),...
                        Data{c,subj}.y(MT{c,subj}.idxonset(i)+5,i),0];
                    targetvector=[Data{c,subj}.targetposition(i,1)...
                        ,Data{c,subj}.targetposition(i,2),0];
                    missvector=[Data{c,subj}.x(MT{c,subj}.idxendpt(i),i),...
                        Data{c,subj}.y(MT{c,subj}.idxendpt(i),i),0];
                else
                    initvector=[Data{c,subj}.x(MT{c,subj}.idxonset(i)+5,i),...
                        Data{c,subj}.y(MT{c,subj}.idxonset(i)+5,i),0];
                    targetvector=[Data{c,subj}.targetposition(i,1)-Data{c,subj}.targetposition(i-1,1)...
                        ,Data{c,subj}.targetposition(i,2)-Data{c,subj}.targetposition(i-1,2),0];
                    missvector=[Data{c,subj}.x(MT{c,subj}.idxendpt(i),i)-Data{c,subj}.targetposition(i-1,1),...
                        Data{c,subj}.y(MT{c,subj}.idxendpt(i),i)-Data{c,subj}.targetposition(i-1,2),0];
%                     THIS_NEEDS_TO_BE_CHECKED
                end
            end
            if ~strcmp(DataSetsSelect,'Pref')
                initvector=[Data{c,subj}.x(MT{c,subj}.idxonset(i)+5,i),...
                    Data{c,subj}.y(MT{c,subj}.idxonset(i)+5,i),0];
                targetvector=[Data{c,subj}.targetposition(i,1)...
                    ,Data{c,subj}.targetposition(i,2),0];
                missvector=[Data{c,subj}.x(MT{c,subj}.idxmoveback(i),i),...
                        Data{c,subj}.y(MT{c,subj}.idxmoveback(i),i),0];
            end 
%             adjust_vector=[Data{c,subj}.x(MT{c,subj}.idxcorrection(i),i),Data{c,subj}.y(MT{c,subj}.idxcorrection(i),i),0];
            
            %USE THIS FOR MISS ANGLE SIGNED
            %atan2d(x(1)*y(2)-y(1)*x(2),x(1)*x(2)+y(1)*y(2))
           Data{c,subj}.miss_angle(tr_count) = atan2d(targetvector(1)*missvector(2)-targetvector(2)*missvector(1),...
                targetvector(1)*missvector(1)+targetvector(2)*missvector(2));
            if abs(Data{c,subj}.miss_angle(tr_count))>30
                1;
            end
            %             Data{c,subj}.corr_angle(tr_count) = atan2d(initvector(1)*targetvector(2)-initvector(2)*targetvector(1),initvector(1)*targetvector(1)+initvector(2)*targetvector(2));
            Data{c,subj}.inittotar_angle(tr_count) = atan2d(targetvector(1)*initvector(2)-targetvector(2)*initvector(1),targetvector(1)*initvector(1)+targetvector(2)*initvector(2));
            Data{c,subj}.moveangle(tr_count) = atan2d(missvector(2),missvector(1));
%             Data{c,subj}.adjust_angle(tr_count) = atan2d(targetvector(1)*adjust_vector(2)-targetvector(2)*adjust_vector(1),targetvector(1)*adjust_vector(1)+targetvector(2)*adjust_vector(2));
            
            % Check if they moved in the correct diretion first
            if MT{c,subj}.idxonset(tr_count)>=100 || tr_count<=popts.totaltrials-nTrials_speed+1 || max(Data{c,subj}.p(:,tr_count))>.13...
                    || MT{c,subj}.idxonset(i)-MT{c,subj}.robotstates.wait4mvt(i)<20 || MT{c,subj}.mvttime(i) > 3
                Data{c,subj}.goodtrial(tr_count) = 0;
            else 
                Data{c,subj}.goodtrial(tr_count) = 1;
            end
            
            RobotState{c,subj}.three=mean(Data{c,subj}.stateframes(3,:));
            RobotState{c,subj}.four=mean(Data{c,subj}.stateframes(4,:));
            RobotState{c,subj}.five=mean(Data{c,subj}.stateframes(5,:));
%             RobotState{c,subj}.six=mean(Data{c,subj}.stateframes(6,:));
%             RobotState{c,subj}.seven=mean(Data{c,subj}.stateframes(7,:));
%             RobotState{c,subj}.eight=mean(Data{c,subj}.stateframes(8,:));
            
            %Create new data stucture target for variables depending on
            %target
            if strcmp(subjid,'PLU')&strcmp(conditions(c),'04')&(tr_count==1)&strcmp(DataSelect,'Control')
                Data{c,subj}.targetnumber(tr_count)=1;
            end
            switch Data{c,subj}.targetnumber(tr_count)
                case 1
                    TargetData{c,subj}.one.PrefSpeed(tarone_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.one.PeakSpeed(tarone_count)=Data{c,subj}.peakvel.(section)(tr_count);                    
                    MissData{c,subj}.one.angle(tarone_count)=Data{c,subj}.miss_angle(tr_count);                    
                    tarone_count=tarone_count+1;                 
                case 2
                    TargetData{c,subj}.two.PrefSpeed(tartwo_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.two.PeakSpeed(tartwo_count)=Data{c,subj}.peakvel.(section)(tr_count);                    
                    MissData{c,subj}.two.angle(tartwo_count)=Data{c,subj}.miss_angle(tr_count);                    
                    tartwo_count=tartwo_count+1;
                case 3
                    TargetData{c,subj}.thr.PrefSpeed(tarthr_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.thr.PeakSpeed(tarthr_count)=Data{c,subj}.peakvel.(section)(tr_count);                    
                    MissData{c,subj}.thr.angle(tarthr_count)=Data{c,subj}.miss_angle(tr_count);                    
                    tarthr_count=tarthr_count+1;
                case 4
                    TargetData{c,subj}.fou.PrefSpeed(tarfou_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.fou.PeakSpeed(tarfou_count)=Data{c,subj}.peakvel.(section)(tr_count);                    
                    MissData{c,subj}.fou.angle(tarfou_count)=Data{c,subj}.miss_angle(tr_count);                    
                    tarfou_count=tarfou_count+1;
            end
            switch Data{c,subj}.targetnumber(tr_count)
                case 1
                    TargetData{c,subj}.one.PrefSpeed(tarone_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.one.PeakSpeed(tarone_count)=Data{c,subj}.peakvel.(section)(tr_count);
                    TargetData{c,subj}.one.ReactionVthres(tarone_count)=Data{c,subj}.reaction_vthres(tr_count);                    
                    AvgAngle{c,subj}.one(Avgendpt_one_count)=Data{c,subj}.moveangle(tr_count);
                    Avgendpt_one_count=Avgendpt_one_count+1;                    
                    tarone_count=tarone_count+1;
                case 2
                    TargetData{c,subj}.two.PrefSpeed(tartwo_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.two.PeakSpeed(tartwo_count)=Data{c,subj}.peakvel.(section)(tr_count);
                    TargetData{c,subj}.two.ReactionVthres(tartwo_count)=Data{c,subj}.reaction_vthres(tr_count);                    
                    AvgAngle{c,subj}.two(Avgendpt_two_count)=Data{c,subj}.moveangle(tr_count);
                    Avgendpt_two_count=Avgendpt_two_count+1;                    
                    tartwo_count=tartwo_count+1;
                case 3
                    TargetData{c,subj}.thr.PrefSpeed(tarthr_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.thr.PeakSpeed(tarthr_count)=Data{c,subj}.peakvel.(section)(tr_count);
                    TargetData{c,subj}.thr.ReactionVthres(tarthr_count)=Data{c,subj}.reaction_vthres(tr_count);                    
                    AvgAngle{c,subj}.thr(Avgendpt_thr_count)=Data{c,subj}.moveangle(tr_count);
                    Avgendpt_thr_count=Avgendpt_thr_count+1;
                    tarthr_count=tarthr_count+1;                    
                case 4
                    TargetData{c,subj}.fou.PrefSpeed(tarfou_count)=Data{c,subj}.avevel.(section)(tr_count);
                    TargetData{c,subj}.fou.PeakSpeed(tarfou_count)=Data{c,subj}.peakvel.(section)(tr_count);
                    TargetData{c,subj}.fou.ReactionVthres(tarfou_count)=Data{c,subj}.reaction_vthres(tr_count);                    
                    AvgAngle{c,subj}.fou(Avgendpt_fou_count)=Data{c,subj}.moveangle(tr_count);
                    Avgendpt_fou_count=Avgendpt_fou_count+1;                    
                    tarfou_count=tarfou_count+1;                    
            end            
            tr_count = tr_count+1;
        end
        
        %Use something like this so it ignores that bad trials
%         mean(Data{c,subj}.reaction_robstate(Data{c,subj}.goodtrial==1))
        
        trials2use = popts.totaltrials-nTrials_speed+1:popts.totaltrials;
%         trials2use = (Data{c,subj}.goodtrial(==1);
        

%         Data{c,subj}.MaxEx=mean(max(Data{c,subj}.P(:,trials2use)));
        MaxEx.average(c,subj)=mean(Data{c,subj}.MaxEx(trials2use));
        MaxEx.standarderror(c,subj)=std(Data{c,subj}.MaxEx(trials2use),[],2)/sqrt(sum(trials2use));
        OverShoot(c,subj)=Data{c,subj}.overshoot;
        
        %Reaction Times
        Reaction.robstate(c,subj)=mean(Data{c,subj}.reaction_robstate(:,trials2use));
        Reaction.vthres(c,subj)=mean(Data{c,subj}.reaction_vthres(:,trials2use));
        Reaction.tanv(c,subj)=mean(Data{c,subj}.reaction_tanv(:,trials2use));
        Reaction.tanvstd(c,subj)=std(Data{c,subj}.reaction_tanv(:,trials2use));
%         Reaction.vthres2(c,subj)=mean(Data{c,subj}.reaction_vthres2);
        Reaction.dif(c,subj)=Reaction.robstate(c,subj)-Reaction.vthres(c,subj);
        
        Reaction.tanvvel(c,subj) = mean(Data{c,subj}.reaction_tanvvel(:,trials2use));
        
        Data{c,subj}.high_reaction=find(MT{c,subj}.idxonset>100);
        
        %Miss Data
        Miss.Dist(c,subj)=mean(Data{c,subj}.miss_dist(:,trials2use));
        Miss.angle(c,subj)=mean(Data{c,subj}.miss_angle(:,trials2use));
        Miss.absangle(c,subj)=mean(abs(Data{c,subj}.miss_angle(:,trials2use)));
%         Miss.adjustangle(c,subj)=mean(Data{c,subj}.adjust_angle(:,trials2use));
        
        %Movement Duration
        timings.MovementDur.frames(c,subj)=mean(Data{c,subj}.timings.movedur.frames(:,trials2use));
        
        timings.MovementDur.sec(c,subj)=mean(Data{c,subj}.timings.movedur.sec(:,trials2use));
        timings.MovementDur.secdev(c,subj) = std(Data{c,subj}.timings.movedur.sec(:,trials2use));
        timings.MovementDur.secerr(c,subj) = std(Data{c,subj}.timings.movedur.sec(:,trials2use))/sqrt(length(trials2use));
        
        timings.timetotarget.avgt(c,subj)=mean(Data{c,subj}.timings.timetotarget(:,trials2use));
        timings.targetshow(c,subj)=mean(Data{c,subj}.timings.targetshow(:,trials2use));
        
        timings.reaction(c,subj)=mean(Data{c,subj}.timings.reaction(:,trials2use));
        timings.reactiondev(c,subj)=std(Data{c,subj}.timings.reaction(:,trials2use));
        timings.reactiondev(c,subj)=std(Data{c,subj}.timings.reaction(:,trials2use))/sqrt(length(trials2use));
        
        timings.reacttotar(c,subj)=mean(Data{c,subj}.timings.reacttotar(:,trials2use));
        timings.tartotrial(c,subj)=mean(Data{c,subj}.timings.tartotrial(:,trials2use));
        timings.trialtime(c,subj)=mean(Data{c,subj}.timings.trialtime(:,trials2use));
                
        %PrefSpeed
        PrefSpeed.totarget(c,subj)=mean(Data{c,subj}.avevel.totarget(:,trials2use));
        PrefSpeed.tomoveback(c,subj)=mean(Data{c,subj}.avevel.tomoveback(:,trials2use));
%         PrefSpeed.back(c,subj)=mean(Data{c,subj}.avevel.back(:,trials2use));
        PrefSpeed.all(c,subj)=mean(Data{c,subj}.avevel.all(:,trials2use));
        
%         PrefSpeed.all
        
        PeakSpeed.totarget(c,subj)=mean(Data{c,subj}.peakvel.totarget(:,trials2use));
        PeakSpeed.totargetdev(c,subj)=std(Data{c,subj}.peakvel.totarget(:,trials2use));
        PeakSpeed.totargetdev(c,subj)=std(Data{c,subj}.peakvel.totarget(:,trials2use))/sqrt(length(trials2use));
%         PeakSpeed(c,subj).totarget = mean(Data{c,subj}.peakvel.totarget(:,trials2use));
        PeakSpeed.tomoveback(c,subj)=mean(Data{c,subj}.peakvel.tomoveback(:,trials2use));
%         PeakSpeed.back(c,subj)=mean(Data{c,subj}.peakvel.back(:,trials2use));
        PeakSpeed.all(c,subj)=mean(Data{c,subj}.peakvel.all(:,trials2use));        
        
        PathL.totarget(c,subj)=mean(Data{c,subj}.pathlength.totarget(:,trials2use));
        PathL.tomoveback(c,subj)=mean(Data{c,subj}.pathlength.tomoveback(:,trials2use));
        PathL.back(c,subj)=mean(Data{c,subj}.pathlength.back(:,trials2use));
        PathL.all(c,subj)=mean(Data{c,subj}.pathlength.all(:,trials2use));
                
        fprintf('Subject %1.0f %s Condition %s Processed\n',subj,subjid,condition{c,subj});
         
        toc
        mean(Data{c,subj}.timings.reacttoendpt)
    end
    if strcmp(DataSetsSelect,DataSets(1)) %If Pilot data
       if nc==6
             timings.norm.MovementDur.frames(:,subj) = timings.MovementDur.frames(:,subj) / timings.MovementDur.frames(2,subj);
             timings.norm.MovementDur.sec(:,subj) = timings.MovementDur.sec(:,subj) / timings.MovementDur.sec(2,subj);
             timings.norm.timetotarget.norm(:,subj) = timings.timetotarget.avgt(:,subj) / timings.timetotarget.avgt(2,subj);
             timings.norm.targetshow(:,subj) = timings.targetshow(:,subj) / timings.targetshow(2,subj);
             timings.norm.reaction(:,subj) = timings.reaction(:,subj) / timings.reaction(2,subj);
             timings.norm.reacttotar(:,subj) = timings.reacttotar(:,subj) / timings.reacttotar(2,subj);
             timings.norm.tartotrial(:,subj) = timings.tartotrial(:,subj) / timings.tartotrial(2,subj);

             PrefSpeed.norm.totarget(:,subj) = PrefSpeed.totarget(:,subj) / PrefSpeed.totarget(2,subj);
             PrefSpeed.norm.tomoveback(:,subj) = PrefSpeed.tomoveback(:,subj) / PrefSpeed.tomoveback(2,subj);
             PrefSpeed.norm.back(:,subj) = PrefSpeed.back(:,subj) / PrefSpeed.back(2,subj);
             PrefSpeed.norm.all(:,subj) = PrefSpeed.all(:,subj) / PrefSpeed.all(2,subj);

             PeakSpeed.norm.totarget(:,subj) = PeakSpeed.totarget(:,subj) / PeakSpeed.totarget(2,subj);
             PeakSpeed.norm.tomoveback(:,subj) = PeakSpeed.tomoveback(:,subj) / PeakSpeed.tomoveback(2,subj);
             PeakSpeed.norm.back(:,subj) = PeakSpeed.back(:,subj) / PeakSpeed.back(2,subj);
             PeakSpeed.norm.all(:,subj) = PeakSpeed.all(:,subj) / PeakSpeed.all(2,subj);

             PathL.norm.totarget(:,subj) = PathL.totarget(:,subj) / PathL.totarget(2,subj);
             PathL.norm.tomoveback(:,subj) = PathL.tomoveback(:,subj) / PathL.tomoveback(2,subj);
             PathL.norm.back(:,subj) = PathL.back(:,subj) / PathL.back(2,subj);
             PathL.norm.all(:,subj) = PathL.all(:,subj) / PathL.all(2,subj);

             Reaction.norm.robstate(:,subj)=Reaction.robstate(:,subj)./Reaction.robstate(2,subj);
             Reaction.norm.vthres(:,subj)=Reaction.vthres(:,subj)./Reaction.vthres(2,subj);
             Reaction.norm.tanv(:,subj)=Reaction.tanv(:,subj)./Reaction.tanv(2,subj);
    %          Reaction.norm.vthres2(:,subj)=Reaction.vthres2(:,subj)./Reaction.vthres2(1,subj);
             Reaction.norm.dif(:,subj)=Reaction.dif(:,subj)./Reaction.dif(2,subj);
             
             MaxEx.Norm(:,subj)=MaxEx.average(:,subj)./MaxEx.average(2,subj);
             MaxEx.VarNorm(:,subj)=MaxEx.standarderror(:,subj)./MaxEx.standarderror(2,subj);
        elseif nc==5 
             timings.norm.MovementDur.frames(:,subj) = timings.MovementDur.frames(:,subj) / timings.MovementDur.frames(1,subj);
             timings.norm.MovementDur.sec(:,subj) = timings.MovementDur.sec(:,subj) / timings.MovementDur.sec(1,subj);
             timings.norm.timetotarget(:,subj) = timings.timetotarget.avgt(:,subj) / timings.timetotarget.avgt(1,subj);
             timings.norm.targetshow(:,subj) = timings.targetshow(:,subj) / timings.targetshow(1,subj);
             timings.norm.reaction(:,subj) = timings.reaction(:,subj) / timings.reaction(1,subj);
             timings.norm.reacttotar(:,subj) = timings.reacttotar(:,subj) / timings.reacttotar(1,subj);
             timings.norm.tartotrial(:,subj) = timings.tartotrial(:,subj) / timings.tartotrial(1,subj);

             PrefSpeed.norm.totarget(:,subj) = PrefSpeed.totarget(:,subj) / PrefSpeed.totarget(1,subj);
             PrefSpeed.norm.tomoveback(:,subj) = PrefSpeed.tomoveback(:,subj) / PrefSpeed.tomoveback(1,subj);
%              PrefSpeed.norm.back(:,subj) = PrefSpeed.back(:,subj) / PrefSpeed.back(1,subj);
             PrefSpeed.norm.all(:,subj) = PrefSpeed.all(:,subj) / PrefSpeed.all(1,subj);

             PeakSpeed.norm.totarget(:,subj) = PeakSpeed.totarget(:,subj) / PeakSpeed.totarget(1,subj);
             PeakSpeed.norm.tomoveback(:,subj) = PeakSpeed.tomoveback(:,subj) / PeakSpeed.tomoveback(1,subj);
%              PeakSpeed.norm.back(:,subj) = PeakSpeed.back(:,subj) / PeakSpeed.back(1,subj);
             PeakSpeed.norm.all(:,subj) = PeakSpeed.all(:,subj) / PeakSpeed.all(1,subj);

             PathL.norm.totarget(:,subj) = PathL.totarget(:,subj) / PathL.totarget(1,subj);
             PathL.norm.tomoveback(:,subj) = PathL.tomoveback(:,subj) / PathL.tomoveback(1,subj);
%              PathL.norm.back(:,subj) = PathL.back(:,subj) / PathL.back(1,subj);
             PathL.norm.all(:,subj) = PathL.all(:,subj) / PathL.all(1,subj);

             Reaction.norm.robstate(:,subj)=Reaction.robstate(:,subj)./Reaction.robstate(1,subj);
             Reaction.norm.vthres(:,subj)=Reaction.vthres(:,subj)./Reaction.vthres(1,subj);
             Reaction.norm.tanv(:,subj)=Reaction.tanv(:,subj)./Reaction.tanv(1,subj);
    %          Reaction.norm.vthres2(:,subj)=Reaction.vthres2(:,subj)./Reaction.vthres2(1,subj);
             Reaction.norm.dif(:,subj)=Reaction.dif(:,subj)./Reaction.dif(1,subj);
             
             MaxEx.Norm(:,subj)=MaxEx.average(:,subj)./MaxEx.average(1,subj);
             MaxEx.VarNorm(:,subj)=MaxEx.standarderror(:,subj)./MaxEx.standarderror(1,subj);
       end
    else
        if nc==5 % if not pilot data
         timings.norm.MovementDur.frames(:,subj) = timings.MovementDur.frames(:,subj) / timings.MovementDur.frames(2,subj);
         timings.norm.MovementDur.sec(:,subj) = timings.MovementDur.sec(:,subj) / timings.MovementDur.sec(2,subj);
         timings.norm.timetotarget.norm(:,subj) = timings.timetotarget.avgt(:,subj) / timings.timetotarget.avgt(2,subj);
         timings.norm.targetshow(:,subj) = timings.targetshow(:,subj) / timings.targetshow(2,subj);
         timings.norm.reaction(:,subj) = timings.reaction(:,subj) / timings.reaction(2,subj);
         timings.norm.reacttotar(:,subj) = timings.reacttotar(:,subj) / timings.reacttotar(2,subj);
         timings.norm.tartotrial(:,subj) = timings.tartotrial(:,subj) / timings.tartotrial(2,subj);
        
         PrefSpeed.norm.totarget(:,subj) = PrefSpeed.totarget(:,subj) / PrefSpeed.totarget(2,subj);
         PrefSpeed.norm.tomoveback(:,subj) = PrefSpeed.tomoveback(:,subj) / PrefSpeed.tomoveback(2,subj);
         PrefSpeed.norm.back(:,subj) = PrefSpeed.back(:,subj) / PrefSpeed.back(2,subj);
         PrefSpeed.norm.all(:,subj) = PrefSpeed.all(:,subj) / PrefSpeed.all(2,subj);
         
         PeakSpeed.norm.totarget(:,subj) = PeakSpeed.totarget(:,subj) / PeakSpeed.totarget(2,subj);
         PeakSpeed.norm.tomoveback(:,subj) = PeakSpeed.tomoveback(:,subj) / PeakSpeed.tomoveback(2,subj);
         PeakSpeed.norm.back(:,subj) = PeakSpeed.back(:,subj) / PeakSpeed.back(2,subj);
         PeakSpeed.norm.all(:,subj) = PeakSpeed.all(:,subj) / PeakSpeed.all(2,subj);
         
         PathL.norm.totarget(:,subj) = PathL.totarget(:,subj) / PathL.totarget(2,subj);
         PathL.norm.tomoveback(:,subj) = PathL.tomoveback(:,subj) / PathL.tomoveback(2,subj);
         PathL.norm.back(:,subj) = PathL.back(:,subj) / PathL.back(2,subj);
         PathL.norm.all(:,subj) = PathL.all(:,subj) / PathL.all(2,subj);
         
         Reaction.norm.robstate(:,subj)=Reaction.robstate(:,subj)./Reaction.robstate(2,subj);
         Reaction.norm.vthres(:,subj)=Reaction.vthres(:,subj)./Reaction.vthres(2,subj);
         Reaction.norm.tanv(:,subj)=Reaction.tanv(:,subj)./Reaction.tanv(2,subj);
%          Reaction.norm.vthres2(:,subj)=Reaction.vthres2(:,subj)./Reaction.vthres2(1,subj);
         Reaction.norm.dif(:,subj)=Reaction.dif(:,subj)./Reaction.dif(2,subj);
         
         MaxEx.Norm(:,subj)=MaxEx.average(:,subj)./MaxEx.average(2,subj);
         MaxEx.VarNorm(:,subj)=MaxEx.standarderror(:,subj)./MaxEx.standarderror(2,subj);
        elseif nc==4
         timings.norm.MovementDur.frames(:,subj) = timings.MovementDur.frames(:,subj) / timings.MovementDur.frames(1,subj);
         timings.norm.MovementDur.sec(:,subj) = timings.MovementDur.sec(:,subj) / timings.MovementDur.sec(1,subj);
         timings.norm.timetotarget(:,subj) = timings.timetotarget.avgt(:,subj) / timings.timetotarget.avgt(1,subj);
         timings.norm.targetshow(:,subj) = timings.targetshow(:,subj) / timings.targetshow(1,subj);
         timings.norm.reaction(:,subj) = timings.reaction(:,subj) / timings.reaction(1,subj);
         timings.norm.reacttotar(:,subj) = timings.reacttotar(:,subj) / timings.reacttotar(1,subj);
         timings.norm.tartotrial(:,subj) = timings.tartotrial(:,subj) / timings.tartotrial(1,subj);
         
         PrefSpeed.norm.totarget(:,subj) = PrefSpeed.totarget(:,subj) / PrefSpeed.totarget(1,subj);
         PrefSpeed.norm.tomoveback(:,subj) = PrefSpeed.tomoveback(:,subj) / PrefSpeed.tomoveback(1,subj);
%          PrefSpeed.norm.back(:,subj) = PrefSpeed.back(:,subj) / PrefSpeed.back(1,subj);
         PrefSpeed.norm.all(:,subj) = PrefSpeed.all(:,subj) / PrefSpeed.all(1,subj);
         
         PeakSpeed.norm.totarget(:,subj) = PeakSpeed.totarget(:,subj) / PeakSpeed.totarget(1,subj);
         PeakSpeed.norm.tomoveback(:,subj) = PeakSpeed.tomoveback(:,subj) / PeakSpeed.tomoveback(1,subj);
         PeakSpeed.norm.back(:,subj) = PeakSpeed.back(:,subj) / PeakSpeed.back(1,subj);
         PeakSpeed.norm.all(:,subj) = PeakSpeed.all(:,subj) / PeakSpeed.all(1,subj);
         
         PathL.norm.totarget(:,subj) = PathL.totarget(:,subj) / PathL.totarget(1,subj);
         PathL.norm.tomoveback(:,subj) = PathL.tomoveback(:,subj) / PathL.tomoveback(1,subj);
         PathL.norm.back(:,subj) = PathL.back(:,subj) / PathL.back(1,subj);
         PathL.norm.all(:,subj) = PathL.all(:,subj) / PathL.all(1,subj);
         
         Reaction.norm.robstate(:,subj)=Reaction.robstate(:,subj)./Reaction.robstate(1,subj);
         Reaction.norm.vthres(:,subj)=Reaction.vthres(:,subj)./Reaction.vthres(1,subj);
         Reaction.norm.tanv(:,subj)=Reaction.tanv(:,subj)./Reaction.tanv(1,subj);
%          Reaction.norm.vthres2(:,subj)=Reaction.vthres2(:,subj)./Reaction.vthres2(1,subj);
         Reaction.norm.dif(:,subj)=Reaction.dif(:,subj)./Reaction.dif(1,subj);
         
         MaxEx.Norm(:,subj)=MaxEx.average(:,subj)./MaxEx.average(1,subj);
         MaxEx.VarNorm(:,subj)=MaxEx.standarderror(:,subj)./MaxEx.standarderror(1,subj);
        end
    end
end

cd(expfolder);
% save(filename,'-v7.3');
excel_file = strcat(filename,'.csv');
Write_Data
filename = strcat(filename);%,'_test')
cd('D:\Users\Gary\Google Drive\Preferred Mass\Data');
fprintf('Saving file as: %s \n',filename);
save(filename,'-v7.3');
fprintf('File saved as: %s \n',filename);
fprintf('Saved in: %s\n',expfolder);
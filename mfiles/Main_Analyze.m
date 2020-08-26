% Do the math
 projpath = 'F:\Documents\School notes\Grad School\';
% projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
expname = 'Mass';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);

nTrials_speed=200;
% for k=1:20
%  
% nTrails_speed=200-((k-1)*10);
trial_number=num2str(nTrials_speed);
% 
% conditions = {'0' '3' '5' '8' '0f'};
% nc = length(conditions);

for subj = 1:18
    subjid = subjarray{subjtoload(subj)};
    %Curve related metrics

    % Write a loop for the different conditions, c, and trials, i. 
    % I'm using v, where v = (vx^2+xy^2)^0.5 (see lin 118)

%    nTrials_speed = 200; % look at last X trials only; for all, popts.totaltrials
    for c=1:nc
        tic
        condition=char(conditions(c));
        if (strcmp(subjid,'PLO') & strcmp(condition,'fml'));
            c=2;
        end
        tr_count = 1;
        
        Data{c,subj}.stateframes=zeros([8,200]);
        if strcmp(condition,'fml')
            popts.totaltrials=100;
            nTrials_speed=100;
        elseif ~strcmp(condition,'fml')
            popts.totaltrials=200;
            nTrials_speed=200;
        end
        for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
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
            
            
            % Average velocity
            Data{c,subj}.avevel.totarget(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxtarget(i),i)); %change idxendpt to idxtarget
            Data{c,subj}.avevel.tomoveback(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxmoveback(i),i));
            Data{c,subj}.avevel.back(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxtarget(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.avevel.all(tr_count) = mean(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i));

            % Peak velocity
            Data{c,subj}.peakvel.totarget(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxtarget(i),i)); %change idxendpt to idxtarget
            Data{c,subj}.peakvel.tomoveback(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxmoveback(i),i));
            Data{c,subj}.peakvel.back(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxtarget(i):MT{c,subj}.idxendpt(i),i));
            Data{c,subj}.peakvel.all(tr_count) = max(Data{c,subj}.v(MT{c,subj}.idxonset(i):MT{c,subj}.idxendpt(i),i));
            
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
            while fr < MT{c,subj}.idxtarget(i) %change idxendpt to idxtarget
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
            
            %Reaction Times
            Data{c,subj}.reaction_robstate(tr_count)=MT{c,subj}.robotstates.movingout(i)-MT{c,subj}.robotstates.wait4mvt(i);
            Data{c,subj}.reaction_vthres(tr_count)=MT{c,subj}.idxonset(i)-MT{c,subj}.robotstates.wait4mvt(i);         
            
            % Accuracey
            X = [Data{c,subj}.targetposition(i,1),Data{c,subj}.targetposition(i,2);Data{c,subj}.x(MT{c,subj}.idxtarget(i),i),Data{c,subj}.y(MT{c,subj}.idxtarget(i),i)];
            Data{c,subj}.miss_dist(tr_count) = pdist(X,'euclidean');
            
            %Angular Miss
            initvector=[Data{c,subj}.x(MT{c,subj}.idxonset(i),i),Data{c,subj}.y(MT{c,subj}.idxonset(i),i),0];
            targetvector=[Data{c,subj}.targetposition(i,1),Data{c,subj}.targetposition(i,2),0];
            missvector=[Data{c,subj}.x(MT{c,subj}.idxtarget(i),i),Data{c,subj}.y(MT{c,subj}.idxtarget(i),i),0];
            
            %USE THIS FOR MISS ANGLE SIGNED
            %atan2d(x(1)*y(2)-y(1)*x(2),x(1)*x(2)+y(1)*y(2))
            
            Data{c,subj}.miss_angle(tr_count) = atan2d(targetvector(1)*missvector(2)-targetvector(2)*missvector(1),targetvector(1)*missvector(1)+targetvector(2)*missvector(2));
            Data{c,subj}.corr_angle(tr_count) = atan2d(initvector(1)*missvector(2)-initvector(2)*missvector(1),initvector(1)*missvector(1)+initvector(2)*missvector(2));
            Data{c,subj}.inittotar_angle(tr_count) = atan2d(targetvector(1)*initvector(2)-targetvector(2)*initvector(1),targetvector(1)*initvector(1)+targetvector(2)*initvector(2));
            Data{c,subj}.moveangle(tr_count) = atan2d(missvector(2),missvector(1));            
            
            RobotState{c,subj}.three=mean(Data{c,subj}.stateframes(3,:));
            RobotState{c,subj}.four=mean(Data{c,subj}.stateframes(4,:));
            RobotState{c,subj}.five=mean(Data{c,subj}.stateframes(5,:));
%             RobotState{c,subj}.six=mean(Data{c,subj}.stateframes(6,:));
%             RobotState{c,subj}.seven=mean(Data{c,subj}.stateframes(7,:));
%             RobotState{c,subj}.eight=mean(Data{c,subj}.stateframes(8,:));
           
            tr_count = tr_count+1;
        end
        
        Data{c,subj}.MaxEx=mean(max(Data{c,subj}.P));
        MaxEx(c,subj)=Data{c,subj}.MaxEx;
        
        Reaction.robstate(c,subj)=mean(Data{c,subj}.reaction_robstate);
        Reaction.vthres(c,subj)=mean(Data{c,subj}.reaction_vthres);
        Reaction.dif(c,subj)=Reaction.robstate(c,subj)-Reaction.vthres(c,subj);
        Data{c,subj}.high_reaction=find(MT{c,subj}.idxonset>100);
        
        Miss.Dist(c,subj)=mean(Data{c,subj}.miss_dist);
        Miss.angle(c,subj)=mean(Data{c,subj}.miss_angle);
        Miss.absangle(c,subj)=mean(abs(Data{c,subj}.miss_angle));
        
        PrefSpeed.totarget(c,subj)=mean(Data{c,subj}.avevel.totarget);
        PrefSpeed.tomoveback(c,subj)=mean(Data{c,subj}.avevel.tomoveback);
        PrefSpeed.back(c,subj)=mean(Data{c,subj}.avevel.back);
        PrefSpeed.all(c,subj)=mean(Data{c,subj}.avevel.all);
        
        PeakSpeed.totarget(c,subj)=mean(Data{c,subj}.peakvel.totarget);
        PeakSpeed.tomoveback(c,subj)=mean(Data{c,subj}.peakvel.tomoveback);
        PeakSpeed.back(c,subj)=mean(Data{c,subj}.peakvel.back);
        PeakSpeed.all(c,subj)=mean(Data{c,subj}.peakvel.all);        
        
        PathL.totarget(c,subj)=mean(Data{c,subj}.pathlength.totarget);
        PathL.tomoveback(c,subj)=mean(Data{c,subj}.pathlength.tomoveback);
        PathL.back(c,subj)=mean(Data{c,subj}.pathlength.back);
        PathL.all(c,subj)=mean(Data{c,subj}.pathlength.all);
        
        MaxEx(c,subj)=mean(Data{c,subj}.MaxEx);
        
        fprintf('Subject %1.0f %s Condition %s Processed\n',subj,subjid,condition);
         
        toc
    end
         PrefSpeed.norm.totarget(:,subj) = PrefSpeed.totarget(:,subj) / PrefSpeed.totarget(1,subj);
         PrefSpeed.norm.tomoveback(:,subj) = PrefSpeed.tomoveback(:,subj) / PrefSpeed.tomoveback(1,subj);
         PrefSpeed.norm.back(:,subj) = PrefSpeed.back(:,subj) / PrefSpeed.back(1,subj);
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
         Reaction.norm.dif(:,subj)=Reaction.dif(:,subj)./Reaction.dif(1,subj);
end

% filename=strcat('Data',trial_number);
 cd(expfolder);
% save(filename);
 
% end
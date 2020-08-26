% Do the math
% Need to load the ordered data to do this.

% projpath = 'F:\Documents\School notes\Grad School\';
 projpath = 'C:\Users\Gary\Documents\School Notes\Grad School\';
expname = 'Mass';
datafolder = [projpath expname filesep 'Pilot_data'];
expfolder= [projpath expname];
addpath([projpath filesep expname filesep 'mfiles']);

section_cells={'all' 'totarget' 'tomoveback' 'back'};
target_cells={'one' 'two' 'thr' 'fou'};
nsec=length(section_cells);
section=section_cells{1};

figure_count=1;

nTrials_speed=100;
trial_number=num2str(nTrials_speed);


for subj = 1:nsubj
    subjid = subjarray{subjtoload(subj)};
    nTrials_speed = 200; % look at last X trials only; for all, popts.totaltrials
    for c=1:nc        
        condition=char(conditions{c});
        tr_count = 1;
        tarone_count=1;
        tartwo_count=1;
        tarthr_count=1;
        tarfou_count=1;
        
        for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
            %Create new data stucture target for variables depending on
            %target
%             Data{c,subj}.targetnumber(tr_count)
            switch Data{c,subj}.targetnumber(tr_count)
                case 1
                    MissData{c,subj}.one.angle(tarone_count)=Data{c,subj}.miss_angle(tr_count);
                    AbsMissData{c,subj}.one.angle(tarone_count)=abs(Data{c,subj}.miss_angle(tr_count));
                    MoveangleData{c,subj}.one(tarone_count)=Data{c,subj}.moveangle(tr_count);
                    PathLTarget{c,subj}.totarget.one(tarone_count)=Data{c,subj}.pathlength.totarget(tr_count);
                    PathLTarget{c,subj}.all.one(tarone_count)=Data{c,subj}.pathlength.all(tr_count);
                    PathLTarget{c,subj}.P.one(tarone_count)=Data{c,subj}.P(tr_count);
                    tarone_count=tarone_count+1;
                case 2
                    MissData{c,subj}.two.angle(tartwo_count)=Data{c,subj}.miss_angle(tr_count);  
                    AbsMissData{c,subj}.two.angle(tartwo_count)=abs(Data{c,subj}.miss_angle(tr_count));
                    MoveangleData{c,subj}.two(tartwo_count)=Data{c,subj}.moveangle(tr_count);
                    PathLTarget{c,subj}.totarget.two(tartwo_count)=Data{c,subj}.pathlength.totarget(tr_count);
                    PathLTarget{c,subj}.all.two(tartwo_count)=Data{c,subj}.pathlength.all(tr_count);
                    PathLTarget{c,subj}.P.two(tartwo_count)=Data{c,subj}.P(tr_count);
                    tartwo_count=tartwo_count+1;
                case 3
                    MissData{c,subj}.thr.angle(tarthr_count)=Data{c,subj}.miss_angle(tr_count);
                    AbsMissData{c,subj}.thr.angle(tarthr_count)=abs(Data{c,subj}.miss_angle(tr_count));
                    MoveangleData{c,subj}.thr(tarthr_count)=Data{c,subj}.moveangle(tr_count);
                    PathLTarget{c,subj}.totarget.thr(tarthr_count)=Data{c,subj}.pathlength.totarget(tr_count);
                    PathLTarget{c,subj}.all.thr(tarthr_count)=Data{c,subj}.pathlength.all(tr_count);
                    PathLTarget{c,subj}.P.thr(tarthr_count)=Data{c,subj}.P(tr_count);
                    tarthr_count=tarthr_count+1;
                case 4
                    MissData{c,subj}.fou.angle(tarfou_count)=Data{c,subj}.miss_angle(tr_count);
                    AbsMissData{c,subj}.fou.angle(tarfou_count)=abs(Data{c,subj}.miss_angle(tr_count));
                    MoveangleData{c,subj}.fou(tarfou_count)=Data{c,subj}.moveangle(tr_count);
                    PathLTarget{c,subj}.totarget.fou(tarfou_count)=Data{c,subj}.pathlength.totarget(tr_count);
                    PathLTarget{c,subj}.all.fou(tarfou_count)=Data{c,subj}.pathlength.all(tr_count);
                    PathLTarget{c,subj}.P.fou(tarfou_count)=Data{c,subj}.P(tr_count);
                    tarfou_count=tarfou_count+1;
            end
            tr_count=tr_count+1;
        end              
     %    fprintf('Subject %s %s Condition %s Processed\n',subj,subjid,condition);
        end
end

for subj=1:nsubj
    for c=1:nc
        for k=1:4            
            target=target_cells{k};
            MissData{c,subj}.(target).ste=std(MissData{c,subj}.(target).angle,[],2)/sqrt(length(MissData{c,subj}.(target).angle));
            MissDataArray(c,subj,k)=MissData{c,subj}.(target).ste;
            
            AbsMissData{c,subj}.(target).ste=std(AbsMissData{c,subj}.(target).angle,[],2)/sqrt(length(MissData{c,subj}.(target).angle));
            AbsMissDataArray(c,subj,k)=AbsMissData{c,subj}.(target).ste;
            
            MoveAngleData{c,subj}.(target).ste=std(MoveangleData{c,subj}.(target),[],2)/sqrt(length(MoveangleData{c,subj}.(target)));
            MoveAngleArray(c,subj,k)=MoveAngleData{c,subj}.(target).ste;            
            
            PathLTargetAllArray(c,subj,k)=mean(PathLTarget{c,subj}.all.(target));
            PathLTargetToTargetArray(c,subj,k)=mean(PathLTarget{c,subj}.totarget.(target));
            MaxExArray(c,subj,k)=mean(max(PathLTarget{c,subj}.P.(target)));
            
        end
    end
end

for subj=1:nsubj
    for c=1:nc
        for k=1:4
            MissDataArrayNorm(c,subj,k)=MissDataArray(c,subj,k)./MissDataArray(1,subj,k);
            AbsMissDataArrayNorm(c,subj,k)=AbsMissDataArray(c,subj,k)./AbsMissDataArray(1,subj,k);
            MoveAngleArrayNorm(c,subj,k)=MoveAngleArray(c,subj,k)./MoveAngleArray(1,subj,k);
            
            PathLTargetAllArrayNorm(c,subj,k)=PathLTargetAllArray(c,subj,k)./PathLTargetAllArray(1,subj,k);
            PathLTargetToTargetArrayNorm(c,subj,k)=PathLTargetToTargetArray(c,subj,k)./PathLTargetToTargetArray(1,subj,k);
            MaxExArrayNorm(c,subj,k)=MaxExArray(c,subj,k)./MaxExArray(1,subj,k);
            
        end
    end
end

%% Plots
figure(figure_count);
hold on
for c=1:nc
    for k=1:4
        target=target_cells{k};
        
        ColorPref(c)=plot(k,mean(MissDataArray(c,:,k)),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
    end
    line(1:4)=mean(MissDataArray(c,:,:),2);
    plot(line,'Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
end
axis([0.5 4.5 .5 1]);
set(gca,'XTick',[0,1,2,3,4,5]);
xlabel('Target Number');ylabel('Standard Error');title('Standard error for each target');
legend([ColorPref(:)],conditions(:));
figure_count=figure_count+1;

figure(figure_count);
clear ColorPref;
hold on;
for k=1:4
    for c=1:nc
        target=target_cells{k};
        
        ColorPref(k)=plot(c,mean(MissDataArray(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end
    plot(mean(MissDataArray(:,:,k),2),'Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
end
axis([0.5 5.5 .5 1]);
set(gca,'XTick',[0,1,2,3,4,5],'XtickLabel',[' ' conditions ' ']);
xlabel('Condition');ylabel('Standard Error');title('Standard error PerCondition');
legend([ColorPref(:)],target_cells(:));
figure_count=figure_count+1;

%Absolute Miss Angles
figure(figure_count);
hold on
for c=1:nc
    for k=1:4
        target=target_cells{k};
        
        ColorPref(c)=plot(k,mean(AbsMissDataArray(c,:,k)),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
    end
    line(1:4)=mean(AbsMissDataArray(c,:,:),2);
    plot(line,'Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
end
axis([0.5 4.5 .4 .8]);
set(gca,'XTick',[0,1,2,3,4,5]);
xlabel('Target Number');ylabel('SE of ABSOLUTE Miss Angle');title('Standard error for each target');
legend([ColorPref(:)],conditions(:));
figure_count=figure_count+1;

%% Normalized Miss Angles
figure(figure_count);
hold on
for c=1:nc
    for k=1:4
        target=target_cells{k};
        
        ColorPref(c)=plot(k,mean(MissDataArrayNorm(c,:,k)),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
    end
    line(1:4)=mean(MissDataArrayNorm(c,:,:),2);
    plot(line,'Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
end
axis ([.5 4.5 .7 1.1]);
set(gca,'XTick',[0,1,2,3,4,5]);
xlabel('Target Number');ylabel('Standard Error NORMALIZED');title('Standard error for each target NORM');
legend([ColorPref(:)],conditions(:));
figure_count=figure_count+1;

figure(figure_count);
clear ColorPref;
hold on;
for k=1:4
    for c=1:nc
        target=target_cells{k};
        
        ColorPref(k)=plot(c,mean(MissDataArrayNorm(c,:,k)),'o','Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
    end
    plot(mean(MissDataArrayNorm(:,:,k),2),'Color',ColorSet(k*3,:),'MarkerFaceColor',ColorSet(k*3,:));
end
axis ([.5 5.5 .75 1.05]);
set(gca,'XTick',[0,1,2,3,4,5],'XtickLabel',[' ' conditions ' ']);
xlabel('Condition');ylabel('Standard Error NORMALIZED');title('Standard error NORM PerCondition');
legend([ColorPref(:)],target_cells(:));
figure_count=figure_count+1;

%Absolute Miss Angles
figure(figure_count);
hold on
for c=1:nc
    for k=1:4
        target=target_cells{k};
        
        ColorPref(c)=plot(k,mean(AbsMissDataArrayNorm(c,:,k)),'o','Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
    end
    line(1:4)=mean(AbsMissDataArrayNorm(c,:,:),2);
    plot(line,'Color',ColorSet(c*3,:),'MarkerFaceColor',ColorSet(c*3,:));
end
% axis ([0 5 .025 .112]);
set(gca,'XTick',[0,1,2,3,4,5]);
xlabel('Target Number');ylabel('SE of ABSOLUTE Miss Angle');title('Target Condition SE ABS MissAngle');
legend([ColorPref(:)],conditions(:));
figure_count=figure_count+1;

%% Move Angles STE
figure(figure_count);
clear ColorPref;
hold on;
for k=1:4
    for c=1:nc
        target=target_cells{k};
        
        ColorPref(k)=plot(c,mean(MoveAngleArray(c,:,k)),'o','Color',ColorSet(k*4,:),'MarkerFaceColor',ColorSet(k*4,:));
    end
    plot(mean(MoveAngleArray(:,:,k),2),'Color',ColorSet(k*4,:),'MarkerFaceColor',ColorSet(k*4,:));
end

axis([0 6 .2 1.1]);
set(gca,'XTick',[0,1,2,3,4,5],'XtickLabel',[' ' conditions ' ']);
xlabel('Condition');ylabel('Move Angle STE');title('Movement Angle STE');
legend([ColorPref(:)],target_cells(:));
figure_count=figure_count+1;   
%%
figure(18);
hold on
plot(-0.070710537390700,0.070710818846400,'o','Color',ColorSet(15,:));%,'MarkerFaceColor',ColorSet(15,:));
plot(-0.070710537390700,-0.070710818846400,'o','Color',ColorSet(15,:));%,'MarkerFaceColor',ColorSet(15,:));
plot(0.070710537390700,0.070710818846400,'o','Color',ColorSet(15,:));%,'MarkerFaceColor',ColorSet(15,:));
plot(0.070710537390700,-0.070710818846400,'o','Color',ColorSet(15,:));%,'MarkerFaceColor',ColorSet(15,:));
t=linspace(0,2*pi);
plot(.1*cos(t),.1*sin(t));

for subj=1:nsubj 
    for c=2:nc
       for i=popts.totaltrials-nTrials_speed+1:popts.totaltrials
           i;
           Data{c,subj}.x(MT{c,subj}.idxtarget(i));
           Data{c,subj}.y(MT{c,subj}.idxtarget(i));
           textstr=sprintf('%d %d %d',c, subj, i);
           text(Data{c,subj}.x(MT{c,subj}.idxtarget(i),i),Data{c,subj}.y(MT{c,subj}.idxtarget(i),i),textstr);
           ColorPref(c)=plot(Data{c,subj}.x(MT{c,subj}.idxtarget(i),i),Data{c,subj}.y(MT{c,subj}.idxtarget(i),i),'x','Color',ColorSet(c*2-2,:)); 
       end       
   end
end
axis([-.13 .13 -.13 .13]);
xlabel('X Position');ylabel('Y Position');title('Position when crossing position threshold');

% filename=strcat('Data',trial_number);
% cd(expfolder);
% save(filename);
 
% end
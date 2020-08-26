%again plots commented out '%%%###'
function MT = get_mvttimes_aa(Data, V, Ev, vthres)

if nargin < 4
    vthres = []; 
end

vsign = sign(nanmean(V));

pthres = sqrt(Data.targetposition(1,1)^2+Data.targetposition(1,2)^2);
targ_dist = ((Data.targetposition_act(:,1)-Data.startposition_act(:,1)).^2 + ...
    (Data.targetposition_act(:,2)-Data.startposition_act(:,2)).^2).^0.5;
targ_loc = (Data.targetposition_act(:,1).^2 + Data.targetposition_act(:,2).^2).^0.5;


P = (Data.x.^2 + Data.y.^2).^0.5;

time_s = Data.time_ms*0.001;

for i = 1:length(V(1,:))
    [MT.peakvy(i), MT.idxpeakvy(i)] = nanmax(V(:,i),[],1);
    [MT.minvy(i), MT.idxminvy(i)] = nanmin(V(:,i),[],1);
    
    MT.timepeakvy(i) = time_s(MT.idxpeakvy(i),i);
    MT.timeminvy(i) = time_s(MT.idxminvy(i),i);

end

if isempty(vthres)
    for i = 1:length(V(1,:))
        MT.idxonset(i) = Ev{1,i+1}{1}(strcmp('home',Ev{1,i+1}{3}));
        MT.idxendpt(i) = Ev{1,i+1}{1}(strcmp('movingout',Ev{1,i+1}{3}))+1;
        MT.idxwait4mvt(i) = MT.idxonset(i) - 1;
        MT.idxtarget(i) = MT.idxendpt(i);
        
        MT.timewait4mvt(i) = time_s(MT.idxwait4mvt(i));
        MT.timetarget(i) = time_s(MT.idxtarget(i));

        MT.mvttime(i) = MT.timeendpt(i)-MT.timeonset(i);
        MT.rxntime(i) = MT.timeonset(i) - 0.005;
        
    end
else
    n_fail = 0;
    for i = 1:length(V(1,:))
        
        %Robot state starts
%       if ~isempty(find(Data.statenumber(:,i)==3,1,'first');
        a=find(Data.statenumber(:,i)==3,1,'first');
        if ~isempty(a);
            MT.robotstates.home(i)=find(Data.statenumber(:,i)==3,1,'first');
        end
        a=find(Data.statenumber(:,i)==4,1,'first');
        if ~isempty(a);
            MT.robotstates.wait4mvt(i)=find(Data.statenumber(:,i)==4,1,'first');
        end
        a=find(Data.statenumber(:,i)==5,1,'first');
        if ~isempty(a);
            MT.robotstates.movingout(i)=find(Data.statenumber(:,i)==5,1,'first');
        end
        a=find(Data.statenumber(:,i)==6,1,'first');
        if ~isempty(a);
            MT.robotstates.attarget(i)=find(Data.statenumber(:,i)==6,1,'first');
        end
        a=find(Data.statenumber(:,i)==7,1,'first');
        if ~isempty(a);
            MT.robotstates.finishmvt(i)=find(Data.statenumber(:,i)==7,1,'first');
        end  
        
        % Target: pos thres
        ind_targ = find(P(:,i) >= targ_loc(i), 1, 'first');
        if ~isempty(ind_targ)
            MT.targdist(i)=targ_dist(i);
            MT.idxtarget(i)=ind_targ;
        else
            [MT.targdist(i),MT.idxtarget(i)] = max(P(:,i));
        end
        MT.timetarget(i) = time_s(MT.idxtarget(i),i);
        
        % Start point: velocity thres
        a = find(V(MT.idxtarget(i):-1:1,i) <= vthres, 1, 'first');

        if ~isempty(a)
            MT.idxonset(i) = MT.idxtarget(i)-a+1;
        else
            MT.idxonset(i) = 1;
        end
        MT.timeonset(i)=time_s(MT.idxonset(i),i);
        
        % End point: first time they turn around (velocity = 0) or last
        % data point in trial
        b = find(V(MT.idxtarget(i):end,i) <= 0, 1, 'first');
%         b = find(V(MT.idxpeakvy(i):end,i) <= vthres, 1, 'first');
        if ~isempty(b)
            MT.idxendpt(i) = MT.idxtarget(i)+b-1;
        else
            n_fail = n_fail+1;
            MT.idxendpt(i) = find(~isnan(V(:,i)),1,'last');
        end
        MT.timeendpt(i) = time_s(MT.idxendpt(i),i);
        MT.idxtarget(i) = MT.idxendpt(i);
        
        if P(MT.idxendpt(i),i) < .09
            n_fail = n_fail +1;
        end
        
        % Move Back
        a = find(V(MT.idxendpt(i):end,i) <= -1*vthres, 1, 'first');
        if ~isempty(a)
            MT.idxmoveback(i) = a+MT.idxendpt(i);
        else
            MT.idxmoveback(i) = sum(~isnan(V(:,i)))-1;%length(V(:,i));
        end
        MT.timemoveback(i)=time_s(MT.idxmoveback(i),i);
        
        % wait4mvt
        MT.idxwait4mvt(i) = Ev{1,i+1}{1}(strcmp('home',Ev{1,i+1}{3}))+1;        
        MT.timewait4mvt(i) = time_s(MT.idxwait4mvt(i),i);

        % Movement time and rxn time
        MT.mvttime(i) = MT.timeendpt(i)-MT.timeonset(i);
        MT.rxntime(i) = MT.timeonset(i) - MT.timewait4mvt(i);
        
        if MT.idxonset(i)>MT.idxtarget(i)
            1;
        end
    end
end
perc_fail = n_fail/i;
fprintf('Percent fail = %0.3f\n',perc_fail);


% Intertrial time = between one trial end and next trial beginning
MT.intertrial(1) = 0;  % zero for first trial
for i=2:length(V(1,:))
    MT.intertrial(i) = MT.timewait4mvt(i)-MT.timeendpt(i-1);
end

MT.time_s = time_s;

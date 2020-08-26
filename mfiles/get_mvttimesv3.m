%again plots commented out '%%%###'
function MT = get_mvttimes(Data, V, P, Ev, vthres, endthres, tarthres,condition,subject);

if nargin < 3
    vthres = []; 
    endthres = 0.01;
    tarthres = .015;
end

vsign = sign(nanmean(V));

psign = sign(nanmean(P));

pthres = sqrt(Data.targetposition(1,1)^2+Data.targetposition(1,2)^2);
targ_dist = ((Data.targetposition_act(:,1)-Data.startposition_act(:,1)).^2 + ...
    (Data.targetposition_act(:,2)-Data.startposition_act(:,2)).^2).^0.5;
targ_loc = (Data.targetposition_act(:,1).^2 + Data.targetposition_act(:,2).^2).^0.5;

low_react = 0;
n_long = 0;
P = (Data.x.^2 + Data.y.^2).^0.5;
time_s = Data.time_ms*0.001;

for i = 1:length(V(1,:))
    [MT.peakvy(i) MT.idxpeakvy(i)] = nanmax(V(:,i)*vsign(i),[],1);
    [MT.minvy(i) MT.idxminvy(i)] = nanmin(V(:,i)*vsign(i),[],1);
end

if isempty(vthres)
    for i = 1:length(Y(1,:))
        MT.idxonset(i) = Ev{1,i+1}{1}(strcmp('home',Ev{1,i+1}{3}));
        MT.idxendpt(i) = Ev{1,i+1}{1}(strcmp('movingout',Ev{1,i+1}{3}))+1;
        MT.mvttime(i) = Data.time(MT.idxendpt(i),i)-Data.time(MT.idxonset(i),i);
    end
else
    n_fail = 0;
    n_long = 0;
    for i = 1:length(V(1,:))
        %%
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

        %Position threshold for target
        if max(P(:,i))>tarthres
            b(i) = find(P(:,i)*psign(i) >= tarthres,1,'first');
            if ~isempty(b(i))
                MT.idxtarget(i)=b(i);
            else
                [tarmax(i),MT.idxtarget(i)]=max(P(:,i));
            end
        else
            [tarmax(i),MT.idxtarget(i)]=max(P(:,i));
        end
       

        %%
        %Current Distance to target
        D_to_tar = sqrt((Data.x(:,i)-Data.targetposition(i,1)).^2+(Data.y(:,i)-Data.targetposition(i,2)).^2);
        MT.Dtotardiff(:,i) = diff(D_to_tar);
%         j=1;
%         
%         %Velocity Threshold calculation
%         if max(V(:,i))>.08
%             while V(j,i)<.08;
%                 j=j+1;
%             end
%         else
%             while V(j,i)<(.8*max(V(j,i)))
%                 j=j+1;
%             end
%         end
%         while isempty(find(MT.Dtotardiff(j:j+10,i)>(-.00005)))
%             %While there are no values in dtotardiff greater than -.00005
%             %Loop will stop when the first time the person stops moving
%             %towards target, because isemtpy will show theres a value of
%             %greater than -.00005 in the array.
%             j=j-1;
%             if j == 1
%                 break
%             end
%         end
%         MT.idxonset2(i)=j+1;
        
        %%
        %Reaction Threshold from Acceleration V 
        for k=2:length(V)
            V_diff(k,i)=V(k,i)-V(k-1,i);
        end
        j=MT.robotstates.wait4mvt(i);
        while ~isempty(find(V_diff(j:j+10,i)<(.0001),1)) 
            j=j+1;
        end
        MT.idxonset(i)=j;
        if MT.idxonset(i)>100
            fprintf('Subj %g, cond %g, trial %g, reaction is %g \n',subject,condition,i, MT.idxonset(i));
        end
        %Reaction time from tangential velocity
        clear V_diff j
        V_diff(:,i) = diff(Data.TanV(:,i));
        j = MT.robotstates.wait4mvt(i)+...
            find(Data.TanV(MT.robotstates.wait4mvt(i):end,i)>.5*max(Data.TanV(MT.robotstates.wait4mvt(i):end,i)),1,'first');
        j = MT.robotstates.wait4mvt(i)+...
            find(Data.TanV(MT.robotstates.wait4mvt(i):end,i)>.2*max(Data.TanV(MT.robotstates.wait4mvt(i):end,i)),1,'first');
        while sum(V_diff(j:j+8,i)<0)<1 && j>=MT.robotstates.wait4mvt(i)+1
            j=j-1;
            if std(V_diff(j:j+8,i))<2E-4
                break
            end
        end
        MT.idxonset3(i)=j;
        MT.idxonset(i)=j;
        
        if MT.idxonset(i)-MT.robotstates.wait4mvt(i)<20
%             figure(1);clf(1);subplot(2,1,1);hold on
%             plot(Data.TanV(1:MT.idxonset(i)+10,i));
%             plot(MT.idxonset(i),Data.TanV(MT.idxonset(i),i),'x');
%             plot(MT.idxonset3(i),Data.TanV(MT.idxonset3(i),i),'*');
%             plot(MT.robotstates.wait4mvt(i),Data.TanV(MT.robotstates.wait4mvt(i),i),'o');
%             subplot(2,1,2);hold on
%             plot(V(1:MT.idxonset(i)+10,i));
%             plot(MT.idxonset(i),V(MT.idxonset(i),i),'x');
%             plot(MT.idxonset3(i),V(MT.idxonset3(i),i),'*');
%             plot(MT.robotstates.wait4mvt(i),V(MT.robotstates.wait4mvt(i),i),'o');
            low_react = low_react+1;
            1;
        end
        
        %%
        % Threshold for target point (endpt in metabolics)
        
        tempV = Data.TanV(MT.robotstates.wait4mvt(i):end,i);
        tempP = Data.P(MT.robotstates.wait4mvt(i):end,i);
        for k=1:length(diff(D_to_tar))-50
            D_to_tar_var(k) = std(diff(D_to_tar(k:k+30)));
        end
        
%         
%         if max(P(:,i))>.095 && min(D_to_tar)<.04
%             a = find(tempP > .08 & D_to_tar(MT.robotstates.wait4mvt(i):end)<.04, 1, 'first')+MT.robotstates.wait4mvt(i);
%             if min(P(a:end,i))<.08
%                 endpt = length(P(:,i))-find(flip(P(:,i)>.098),1,'first');
% %                 [~,b] = min(Data.v(a+MT.robotstates.wait4mvt(i):endpt+a+MT.robotstates.wait4mvt(i),i));
%                 for k = a:endpt
%                     if sum(Data.v(k:k+10,i)<.015)>=4 & P(k,i)>.095
%                         break
%                     end
%                     %& D_to_tar(a)>2*min(D_to_tar) %& sum(abs(V_diff(a:a+10,i))<1E-3)==0
%                 end
%                 b = k+10;
%                 a=0;
% %                 b = find(Data.v(a+MT.robotstates.wait4mvt(i):endpt+a+MT.robotstates.wait4mvt(i),i)<.005,1,'first');
%                 
% %                 b = find(Data.v(a+MT.robotstates.wait4mvt(i):endpt+a,i)<.01,1,'first');
%                 if isempty(b)
%                     [~,b] = min(Data.v(a:endpt+a,i));
%                 end
%             else
%                 [~,b] = min(Data.v(a:end,i));
% %                 b = find(Data.v(a+MT.robotstates.wait4mvt(i):end,i)<.01,1,'first');
%             end
% %             b = find(Data.TanV(find(P(:,i)>.08,1,'first'):end,i) <= 0, 1, 'first')+find(P(:,i)>.08,1,'first');
%        
        if max(P(:,i))>.1
            a = find(P(:,i)>.1,1,'first');
            if length(P(:,i))-a>200
                endpt = a+200;
            elseif length(P(:,i))-a>100
                endpt = a+100;
            else
                endpt = a+50;
            end
            for k = a:endpt
                 if sum(Data.v(k:k+10,i)<.015)>=4 & P(k,i)>.095
                    break
                 end
            end
                
            b = k;
        else
            b = find(Data.TanV(MT.idxpeakvy(i):end,i) <= 0, 1, 'first');
        end
        if ~isempty(b)
%             MT.idxendpt(i) = MT.idxpeakvy(i)+b-1;
            MT.idxtarget(i) = MT.robotstates.wait4mvt(i)+b-1;
        else
            MT.idxtarget(i) = find(~isnan(V(:,i)),1,'last')-1;
        end
                
        %% Correction Index
        
        [~,j]=max(V(1:MT.idxtarget(i),i));
        j=j+10;
        while 1
            if V_diff(j,i)<0
                j=j+1;
            elseif V_diff(j,i)>0
                MT.idxcorrection(i)=j;
                break
            end
        end        
        
        %%
        %Position threshold for moving back
        k=MT.idxtarget(i);
        while P(k+1,i) > P(k,i)
            if k+1<length(P(:,i))
                k=k+1;
            else
                break
            end
        end
        MT.idxmoveback(i)=k;
        
        % position thres for end point at home
        c = find((P(:,i)*psign(i) <= endthres) & (Data.statenumber(:,i)==7 | Data.statenumber(:,i)==8) | isnan(V(:,i)), 1, 'first');
        if c == find(isnan(V(:,i)),1,'first')
            c=c-1;
        end
        if ~isempty(c)
            MT.idxendpt(i)=c;
            Pmax(i)=P(MT.idxendpt(i),i);
        else
            [Pmax(i),MT.idxendpt(i)] = max(P(:,i));
        end
        
        if MT.idxendpt(i)<MT.idxtarget(i)
            MT.idxendpt(i) = MT.idxtarget(i)+1;
        end
        
        MT.mvttime(i) = Data.time(MT.idxtarget(i),i)-Data.time(MT.idxonset3(i),i);

        
    miss_x = Data.x(MT.idxtarget(i),i)-Data.targetposition(i,1);
    miss_y = Data.y(MT.idxtarget(i),i)-Data.targetposition(i,2);
    missdist = sqrt(miss_x.^2+miss_y.^2);
    if MT.mvttime>2
        n_long = n_long+1;
    end
    
%     if rand(1)>.9%(missdist>.02 & P(MT.idxtarget(i),i)<.095) || missdist>.05 || MT.mvttime(i)>2 %|| MT.idxonset(i)-MT.robotstates.wait4mvt(i)<20
        1;            
        figure(1);clf(1);subplot(3,2,1);
        hold on
        plot(V(:,i));
        plot(MT.robotstates.wait4mvt(i),V(MT.robotstates.wait4mvt(i),i),'*')
        plot(MT.idxonset(i),V(MT.idxonset(i),i),'x');
        plot(MT.idxtarget(i),V(MT.idxtarget(i),i),'o');
        title('Velocity')
        subplot(3,2,2);
        hold on
        plot(P(:,i));
        plot(MT.robotstates.wait4mvt(i),P(MT.robotstates.wait4mvt(i),i),'*')
        plot(MT.idxonset(i),P(MT.idxonset(i),i),'x');
        plot(MT.idxtarget(i),P(MT.idxtarget(i),i),'o');
        title('Position')
        subplot(3,2,3);
        hold on
        plot(V_diff(:,i));
        plot(MT.robotstates.wait4mvt(i),V_diff(MT.robotstates.wait4mvt(i),i),'*')
        plot(MT.idxonset(i),V_diff(MT.idxonset(i),i),'x');
        plot(MT.idxtarget(i)-1,V_diff(MT.idxtarget(i)-1,i),'o');
        title('V_diff')
        subplot(3,2,4);
        hold on
        plot(Data.x(:,i),Data.y(:,i));
        plot(Data.x(MT.idxonset(i),i),Data.y(MT.idxonset(i),i),'x');
        plot(Data.x(MT.idxtarget(i),i),Data.y(MT.idxtarget(i),i),'o');
        title('X-Y')
        subplot(3,2,5);
        plot(Data.TanV(:,i));
        hold on
        title('Tan V');
        plot(MT.robotstates.wait4mvt(i),Data.TanV(MT.robotstates.wait4mvt(i),i),'*')
        plot(MT.idxonset(i),Data.TanV(MT.idxonset(i),i),'x');
        plot(MT.idxtarget(i),Data.TanV(MT.idxtarget(i),i),'o');
        drawnow
        subplot(3,2,6);
        plot(Data.v(:,i));
        1;
%        pause(2);
%     end
    
        
%         %% alaas stuff??????
% 
%         % Target: pos thres
%         ind_targ = find(P(:,i) >= targ_loc(i), 1, 'first');
%         if ~isempty(ind_targ)
%             MT.targdist(i)=targ_dist(i);
%             MT.idxtarget(i)=ind_targ;
%         else
%             [MT.targdist(i),MT.idxtarget(i)] = max(P(:,i));
%         end
%         MT.timetarget(i) = time_s(MT.idxtarget(i),i);
%         
%         % Start point: velocity thres
%         a = find(V(MT.idxtarget(i):-1:1,i) <= vthres, 1, 'first');
% 
%         if ~isempty(a)
%             MT.idxonset(i) = MT.idxtarget(i)-a+1;
%         else
%             MT.idxonset(i) = 1;
%         end
%         MT.timeonset(i)=time_s(MT.idxonset(i),i);
%         
%         % End point: first time they turn around (velocity = 0) or last
%         % data point in trial
%         b = find(V(MT.idxtarget(i):end,i) <= 0, 1, 'first');
% %         b = find(V(MT.idxpeakvy(i):end,i) <= vthres, 1, 'first');
%         if ~isempty(b)
%             MT.idxendpt(i) = MT.idxtarget(i)+b-1;
%         else
%             n_fail = n_fail+1;
%             MT.idxendpt(i) = find(~isnan(V(:,i)),1,'last');
%         end
%         MT.timeendpt(i) = time_s(MT.idxendpt(i),i);
%         MT.idxtarget(i) = MT.idxendpt(i);
%         
%         if P(MT.idxendpt(i),i) < .09
%             n_fail = n_fail +1;
%         end
%         
%         % Move Back
%         a = find(V(MT.idxendpt(i):end,i) <= -1*vthres, 1, 'first');
%         if ~isempty(a)
%             MT.idxmoveback(i) = a+MT.idxendpt(i);
%         else
%             MT.idxmoveback(i) = sum(~isnan(V(:,i)))-1;%length(V(:,i));
%         end
%         MT.timemoveback(i)=time_s(MT.idxmoveback(i),i);
%         
%         % wait4mvt
%         MT.idxwait4mvt(i) = Ev{1,i+1}{1}(strcmp('home',Ev{1,i+1}{3}))+1;        
%         MT.timewait4mvt(i) = time_s(MT.idxwait4mvt(i),i);
% 
%         % Movement time and rxn time
%         MT.mvttime(i) = MT.timeendpt(i)-MT.timeonset(i);
%         MT.rxntime(i) = MT.timeonset(i) - MT.timewait4mvt(i);
%         
%         if MT.idxonset(i)>MT.idxtarget(i)
%             1;
%         end
%         
%         if MT.mvttime(i) > 2
%             n_long = n_long+1;
%         end
    
    end
%     figure(29);
%     if c>4
%         1;
%     end

    
    fprintf('React<20 frames = %g\n',low_react);
%     fprintf('n_long = %g \n',n_long)
    end
end

% perc_fail = n_fail/i;
% perc_long = n_long/i
% 1;

% 
% for i=1:100
%     figure(1);
%     clf(1);
%     hold on
%     subplot(1,2,1);
%     hold on
%     plot(Data.v(1:150,i));
%     plot(MT.idxonset(i),Data.v(MT.idxonset(i),i),'x');
%     plot(MT.robotstates.wait4mvt(i),Data.v(MT.robotstates.wait4mvt(i),i),'o');
%     subplot(1,2,2);
%     plot(Data.x(1:150,i),Data.y(1:150,i));
% end

% Plot first ten trials
% for ii = 1:10 %sum(ismember([1 2 3 4 5 201 202],ii))
%      figure(100)
%     
%      subplot(131)
%      plot(Data.x(:,ii), Data.y(:,ii));
%     hold on
%      plot(Data.x(MT.idxonset(ii),ii), Data.y(MT.idxonset(ii),ii), 'o');
%      plot(Data.x(MT.idxendpt(ii),ii), Data.y(MT.idxendpt(ii),ii), '*');
%     circx_home = Data.startposition_act(ii,1) + 0.013*sin((0.01:0.01:1)'*2*pi);
%     circy_home = Data.startposition_act(ii,2) + 0.013*cos((0.01:0.01:1)'*2*pi);
%      plot(circx_home,circy_home, 'g');
%     circx_targ = Data.targetposition_act(ii,1) + 0.013*sin((0.01:0.01:1)'*2*pi);
%     circy_targ = Data.targetposition_act(ii,2) + 0.013*cos((0.01:0.01:1)'*2*pi);
%      plot(circx_targ,circy_targ, 'r');
%     axis square
%     axis equal
%      title('traj')
%     
%      subplot(132)
%      plot(Data.y(:,ii));
%     hold on
%      plot(MT.idxonset(ii), Data.y(MT.idxonset(ii),ii), 'o');
%      plot(MT.idxendpt(ii), Data.y(MT.idxendpt(ii),ii), '*');
%      title('Data.y')
%     
%      subplot(133)
%      plot(V(:,ii));
%     hold on
%      plot(MT.idxonset(ii), V(MT.idxonset(ii),ii), 'o');
%      plot(MT.idxendpt(ii), V(MT.idxendpt(ii),ii), '*');
%      title('vel')
%     %        lose(100)
% end
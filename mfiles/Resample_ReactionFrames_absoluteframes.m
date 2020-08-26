%Load ordered data no FML

clear ResampleDataReactVel ResampleDataReactVel2
clear SpmP_abs SpmV_abs SpmC_abs SpmS_abs SpmVabs_abs SpmVsign_abs

indexmax = 0;
tr_count2=1;
for c=1:nc  
    tr_count=1;
    for subj=1:nsubj
        for i=51:2:400
%             if mod(i,2)==1
                index = MT{c,subj}.idxonset(i);
%                 index = MT{c,subj}.robotstates.wait4mvt(i);
%                 indexmax = max([index,indexmax]);
                if index>20
    %                 ResampleDataReactVel(c,tr_count,counter)=0;
                    counter=1;

                    for k=-20:1:300
                        if (index+k)<length(Data{c,subj}.v(:,i)) && ~isnan(Data{c,subj}.v(index+k,i))
                            ResampleDataReactVel(c,tr_count,counter) = Data{c,subj}.TanV(index+k,i);
                            SpmP_abs(tr_count2,counter) = abs(Data{c,subj}.P_abs(index+k,i));
                            SpmV_abs(tr_count2,counter) = Data{c,subj}.TanV(index+k,i);
                            SpmVabs_abs(tr_count2,counter) = Data{c,subj}.v(index+k,i);
                            SpmVsign_abs(tr_count2,counter) = Data{c,subj}.v_sign(index+k,i);
                        else
                            ResampleDataReactVel(c,tr_count,counter) = 0;
                            SpmP_abs(tr_count2,counter) = 0;
                            SpmV_abs(tr_count2,counter) = 0;
                        end


%                         SpmP_abs(tr_count2,counter) = mean(abs(Data{c,subj}.P_abs(index-20:MT{c,subj}.idxonset(i),i)));
%                         SpmV_abs(tr_count2,counter) = mean(Data{c,subj}.TanV(index-20:MT{c,subj}.idxonset(i),i));
                        counter=counter+1;
                    end
                    SpmC1_abs(tr_count2) = str2double(condition{c,subj});
                    SpmC_abs(tr_count2) = str2double(condition{c,subj});
%                     SpmC_abs(tr_count2+1) = str2double(conditions{subj}{c});
                    SpmS_abs(tr_count2) = subj;
%                     SpmS_abs(tr_count2+1) = subj;
                    SpmM_abs(tr_count2) = 1;
%                     SpmM_abs(tr_count2+1) = 2;
                    SpmT_abs(tr_count2) = Data{c,subj}.targetnumber(i);
                    tr_count2=tr_count2+1;

                else
    %                 counter=(50-(index)+1);
    %                 ResampleDataReactVel(c,tr_count,[1:counter-1])=0;
    %                 for k=50-(index)+1:1:200
    %                     if ~isnan(Data{c,subj}.v(index+k,i))
    %                         ResampleDataReactVel(c,tr_count,counter) = Data{c,subj}.TanV(index+k,i);
    %                     elseif isnan(Data{c,subj}.v(index+k,i))
    %                         ResampleDataReactVel(c,tr_count,counter) = 0;
    %                     end
    %                     
    %                     SpmP_abs(tr_count2,counter) = abs(Data{c,subj}.P_abs(index+k,i));
    %                     SpmV_abs(tr_count2,counter) = Data{c,subj}.TanV(index+k,i);
    %                     SpmC_abs(tr_count2) = c;
    %                     SpmS_abs(tr_count2) = subj;
    %                     
    %                     counter=counter+1;
    %                 end
    %                 tr_count2=tr_count2+1;
                end
%             end
            MT{c,subj}.idxonset(i);
            ResampleReactionFrame(c,tr_count) = MT{c,subj}.idxonset(i)-MT{c,subj}.robotstates.wait4mvt(i);
            ResampleTargetFrame(c,tr_count) = MT{c,subj}.idxtarget(i)-MT{c,subj}.robotstates.wait4mvt(i);
            tr_count=tr_count+1;
        end
    end
end

clear a
for c=1:4
    for k = 1:300
        ResampleDataReactVel2(c,k)=nanmean(ResampleDataReactVel(c,:,k));
        a(c,k) = nanmean(ResampleDataReactVel(c,:,k));
    end
    ResampleDataReactFrame(c) = floor(nanmean(ResampleReactionFrame(c,:)));
    ResampleDataTargetFrame(c) = floor(nanmean(ResampleTargetFrame(c,:)));
end

figure(62);clf(62);
hold on;
for c=4:-1:1
    ColorPref(c)=plot(ResampleDataReactVel2(c,1:end),'Color',ColorSet(c,:),'LineWidth',3);%[-20:k-21],
%     plot(ResampleDataReactFrame(c),ResampleDataReactVel2(c,ResampleDataReactFrame(c)),'o','Color',ColorSet(c*3,:))
    [maxv,idx]=max(ResampleDataReactVel2(c,:));
    plot(idx,maxv,'o','Color',ColorSet(c,:))
end
legend([ColorPref(:)],condition{1:4});
% axis([-5 10 -.01 .01])
xlabel('Frames Around target show (Show = 0 Frames)');ylabel('Velocity (m/s)');
titlestr=sprintf('Velocity around target show');
title(titlestr);
%-mean(ResampleDataReactVel2(c,17:20))
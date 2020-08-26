for subj=5:nsubj
    for c=4:nc
        for i=1:200
            figure(1);
            clf(1);
            hold on;
            plot(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i));
            plot(MT{c,subj}.idxonset(i),Data{c,subj}.v(MT{c,subj}.idxonset(i),i),'x')
            titlestr=sprintf('subj: %g, c: %g, trial: %g, MaxSpeed: %g, Onset: %g',subj,c,i,max(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i)),MT{c,subj}.idxonset(i));
            title(titlestr);
            
            if (max(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i))<.2449) & MT{c,subj}.idxonset(i)>61
                1;
            end
            
               
        end
        
    end
    
end

figure(2);
clf(2);
hold on

subj=5;
c=1;
i=51;
ColorPref(1)=plot(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i),'Color',ColorSet(c*4-3,:),'LineWidth',2);
plot(MT{c,subj}.idxonset2(i),Data{c,subj}.v(MT{c,subj}.idxonset2(i),i),'o','Color',ColorSet(c*4-3,:),'LineWidth',3)

subj=5;
c=2;
i=15;
ColorPref(2)=plot(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i),'Color',ColorSet(c*4-3,:),'LineWidth',2);
plot(MT{c,subj}.idxonset2(i),Data{c,subj}.v(MT{c,subj}.idxonset2(i),i),'o','Color',ColorSet(c*4-3,:),'LineWidth',3)

subj=5;
c=3;
i=134;
ColorPref(3)=plot(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i),'Color',ColorSet(c*4-3,:),'LineWidth',2);
plot(MT{c,subj}.idxonset2(i),Data{c,subj}.v(MT{c,subj}.idxonset2(i),i),'o','Color',ColorSet(c*4-3,:),'LineWidth',3)

subj=5;
c=4;
i=35;
ColorPref(4)=plot(Data{c,subj}.v(1:MT{c,subj}.idxtarget(i),i),'Color',ColorSet(c*4-3,:),'LineWidth',2);
plot(MT{c,subj}.idxonset2(i),Data{c,subj}.v(MT{c,subj}.idxonset2(i),i),'o','Color',ColorSet(c*4-3,:),'LineWidth',3)

legend([ColorPref(:)],'0','3','5','8');
xlabel('Frame');ylabel('Velocity (m/s)');title('Individual Velocity Traces');




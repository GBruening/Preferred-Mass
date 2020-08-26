%% Creating Variables
q=0;

for subj=1:nsubj
    for c=2:nc
        for i=2:200
            
            q=q+1;
            
            % Calculate Rotoation
            if (Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==1 || Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==-3)
                Data{c,subj}.directionchange(i)=-90;
            elseif (Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==2 || Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==-2)
                Data{c,subj}.directionchange(i)=180;    
            elseif (Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==3 || Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==-1)    
                Data{c,subj}.directionchange(i)=90; 
            elseif (Data{c,subj}.targetnumber(i)-Data{c,subj}.targetnumber(i-1)==0)
                Data{c,subj}.directionchange(i)=0;
            end
            
            
        end       
    end    
end

condition=char(conditions{subj}(c));
tr_count = 1;

for subj=1:nsubj
    for c=2:nc

        ninety_count=1;
        oneeighty_count=1;
        negninety_count=1;
        zero_count=1;

        for i=2:200
                        
            switch Data{c,subj}.directionchange(i)
                
                case 90
                    DirectionalData{c,subj}.ninety(ninety_count)=Data{c,subj}.avevel.all(i)-Data{c,subj}.avevel.all(i-1);
                    ninety_count=ninety_count+1;
                case 180
                    DirectionalData{c,subj}.oneeighty(oneeighty_count)=Data{c,subj}.avevel.all(i)-Data{c,subj}.avevel.all(i-1);
                    oneeighty_count=oneeighty_count+1;
                case -90
                    DirectionalData{c,subj}.negninety(negninety_count)=Data{c,subj}.avevel.all(i)-Data{c,subj}.avevel.all(i-1);
                    negninety_count=negninety_count+1;
                case 0
                    DirectionalData{c,subj}.zero(zero_count)=Data{c,subj}.avevel.all(i)-Data{c,subj}.avevel.all(i-1);
                    zero_count=zero_count+1;
            end
            
        end
    end
end
%% Graphing Section

degree_cells={'ninety' 'oneeighty' 'negninety' 'zero'};
degrees=[90,180,-90,0];

for subj=1:nsubj
    figure(subj);
    hold on
    for c=2:nc        
        for k=1:4
%             
%             degree=degree_cells{k};
           DirectionalData{c,subj}.ste = std(DirectionalData{c,subj}.(degree_cells{k}),[],2)/sqrt(nsubj);
            
           ColorPref(c)=plot(degrees(k),mean(DirectionalData{c,subj}.(degree_cells{k})),'o','Color',ColorSet((c-1)*3,:),'MarkerFaceColor',ColorSet((c-1)*3,:));
           errorbar(degrees(k),mean(DirectionalData{c,subj}.(degree_cells{k})),DirectionalData{c,subj}.ste,'k-');
        
        end
        
    end
    legend([ColorPref(2:6)],conditions{1,subj}(2:6));
    xlabel('Degree Change from previous target');ylabel('Change in velocity from previous Target');
    str=sprintf('Subject %d',subj);
    title(str);
end

                    
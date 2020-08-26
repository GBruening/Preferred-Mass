fileID=fopen('Unordered_MissAngleTOSpeed.csv','w');

for subj=1:nsubj
    tr_count=0;
    for c=2:nc
        
        for i=1:200
        tr_count=tr_count+1;
        
        miss=Data{c,subj}.miss_angle(i);
        speed=Data{c,subj}.avevel.all(i);
        
        if strcmp('0f',conditions{subj}(c))
            condition=0;
        else
            condition=(conditions{subj}{c});
        end
        
        fprintf(fileID,'%f %s %f %f %f ',subj, condition, tr_count, speed, miss);
        fprintf(fileID,'\n');
        
        end
    end
end


%fclose(fileID);

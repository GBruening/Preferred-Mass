MaxEx.VarNormavg = mean(MaxEx.VarNorm,2);
MaxEx.VarNormste = std(MaxEx.VarNorm,[],2)/sqrt(nsubj);

subplot(1,2,1);
hold on
for subj=1:nsubj
    for c=1:nc
        ColorPref(subj)=plot(str2double(conditions(c)),MaxEx.VarNorm(c,subj),'o','Color',ColorSet(subj,:),'MarkerFaceColor',ColorSet(subj,:));
    end
    plot(str2double(conditions),MaxEx.VarNorm(:,subj),'k-')
end

xlabel('Condition'); ylabel('Max Excursion Variance');
title('Max Excursion Variance');
axis([min(str2double(conditions))-1 max(str2double(conditions))+1 min(min(MaxEx.VarNorm))*.8 max(max(MaxEx.VarNorm))*1.15]);
set(gca,'XTickLabel',[' ' conditions(1:4) ' '],'XTick',[min(str2double(conditions))-1 str2double(conditions) max(str2double(conditions))+1])%,'FontSize',14)

subplot(1,2,2);
hold on
plot(str2double(conditions),MaxEx.VarNormavg,'o','Color','k','MarkerFaceColor','k')
errorbar(str2double(conditions),MaxEx.VarNormavg,MaxEx.VarNormste,'k-')
plot(str2double(conditions),MaxEx.VarNormavg,'k-')
plot([min(str2double(conditions))-1 max(str2double(conditions))+1], [1 1],'k--')
xlabel('Condition'); ylabel('Max Excursion Variance');
title('Max Excursion Variance');
axis([min(str2double(conditions))-1 max(str2double(conditions))+1 .9 1.12]); 
% axiscells={'fml' '0' '3' '5' '8'};
set(gca,'XTickLabel',[' ' conditions(1:4) ' '],'XTick',[min(str2double(conditions))-1 str2double(conditions) max(str2double(conditions))+1])%,'FontSize',14)

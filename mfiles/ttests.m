function [p_speed] = ttests(Data1,Data2,test)

if strcmp(test,'paired')
    dbar=mean(Data1-Data2);
    d=Data1-Data2;
    sd=sqrt(sum(((d-dbar).^2)./(length(Data1)-1)));
    t=dbar/(sd/sqrt(length(Data1)));
    p_speed=tcdf(-abs(t),length(Data1)-1);
end

if strcmp(test,'unpaired');
    [h,p_speed]=ttest2(Data1,Data2);    
end


% 
% 
% if strcmp(test,'twosample')
%     n1=length(Data1);
%     n2=length(Data2);
%     x1bar=mean(Data1);
%     x2bar=mean(Data2);
%     sd1=std(Data1);
%     sd2=std(Data2);
%     sp2=((n1-1).*(sd1^2)+(n2-1).*(sd2^2))/(n1+n2-2);
%     t=(x1bar-x2bar)/sqrt((sp2).*((1/n1)+(1/n2)));
%     nu=
%     
%     
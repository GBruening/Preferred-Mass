function [ p ,x1, yline, yfit, rsq_adj ] = regression( x ,y , order )

%     p=polyfit(x,y,order);
%     p(2)=0;
    
    p=fminsearch(@(m) leastsqrs_lin(x,y,m),[1]);
    p(2)=1;
    
    if max(x)<0
        x1=min(x):(max(x)-min(x))/100:0;
    else
        x1=0:(max(x)-min(x))/100:max(x);
    end
%     x1=min(x):(max(x)-min(x))/100:max(x);
    
    yfit=polyval(p,x);
    yline=polyval(p,x1);
    
    yresid=y-yfit;
    SSresid=sum(yresid.^2);
    SStotal=(length(y)-1)*var(y);
%     SStotal=sum((y-mean(y)).^2);
    rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(p));

    function [res] = leastsqrs_lin(x,y,m)
        y_fit = m.*x+1;
        res = sum((y-y_fit).^2);
    end  
end
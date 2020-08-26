% plots commented out with '%%%###'
function Data = fix_discont(Data)

% Data structure includes fields for
% discont, from the function find_discont
% x, y, vx, vy, fx, and fy

for i = 1:length(Data.discont.trials)
    dt = Data.discont.trials(i);
    df = round(mean(Data.discont.frame(i,1:2)));
    Data.x(df,dt) = mean(Data.x(Data.discont.frame(i,:),dt));
    Data.y(df,dt) = mean(Data.y(Data.discont.frame(i,:),dt));
    
    xi = Data.discont.frame(i,1)-10:Data.discont.frame(i,2)+10;
    Data.vx(xi,dt) = interp1([xi(1) xi(end)], Data.vx([xi(1) xi(end)],dt), xi);
    Data.vy(xi,dt) = interp1([xi(1) xi(end)], Data.vy([xi(1) xi(end)],dt), xi);
    
    Data.fx(xi,dt) = interp1([xi(1) xi(end)], Data.fx([xi(1) xi(end)],dt), xi);
    Data.fy(xi,dt) = interp1([xi(1) xi(end)], Data.fy([xi(1) xi(end)],dt), xi);
end

%  figure('name','Fix discont')
%  subplot(2,3,[1 4]), plot(Data.x(:,Data.discont.trials),Data.y(:,Data.discont.trials)), xlabel('x'), ylabel('y')
%  subplot(2,3,2), plot(Data.vx(:,Data.discont.trials)), ylabel('Vx')
%  subplot(2,3,3), plot(Data.vy(:,Data.discont.trials)), ylabel('Vy')
%  subplot(2,3,5), plot(Data.fx(:,Data.discont.trials)), ylabel('Fx')
%  subplot(2,3,6), plot(Data.fy(:,Data.discont.trials)), ylabel('Fy')
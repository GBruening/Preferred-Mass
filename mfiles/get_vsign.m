  function [ Data ] = get_vsign( Data, num_trials )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

        Px = Data.x; Py = Data.y;
        Vx = diff(Px)/0.005; Vy = diff(Py)/0.005;
        
        P = sqrt((Px.^2 + Py.^2));
        for i=1:num_trials
            if mean(P(:,i))<0
                figure(1);clf(1);
                plot(P(:,i));
            end
        end
        Data.v = nan(size(P));
        time = Data.time;
        Data.v(1,:) = zeros(1,num_trials);
        for i=1:num_trials
            num_frames(i) = sum(~isnan(P(:,i)));
            Pdiff{i} = diff23f5( P(1:num_frames(i),i), 1/200, 10 ); %doesn't work very well
            Data.v_sign(1:num_frames(i),i) = Pdiff{i}(:,2);
        end
        % Filter robot velocity using Savitzky-Golay filter (smooths w/o greatly distorting signal)
        Data.vx_orig=Data.vx;
        Data.vy_orig=Data.vy;
        for i = 1:size(P,2)
            numnan = sum(~isnan(Data.x(:,i)));
            test = diff23f5(Data.x(1:numnan,i),1/200,10);
            Data.vx(1:numnan,i) = test(:,2);
            test = diff23f5(Data.y(1:numnan,i),1/200,10);
            Data.vy(1:numnan,i) = test(:,2);
        end
        Data.v = (Data.vx.^2+Data.vy.^2).^0.5;
        
        % Moved to Getmvttimes 9/15/2020 GB
%         % Tangential Velocity towards target
%         Data.TanV = NaN(size(Data.x));
%         Data.TanA = NaN(size(Data.x));
%         for i=1:size(P,2) %trial loop
%             D_to_tar = sqrt((Data.x(:,i)-Data.targetposition(i,1)).^2+(Data.y(:,i)-Data.targetposition(i,2)).^2);
%         %             Dtotardiff=diff(D_to_tar)/.005;
%             Ddiff = diff23f5(D_to_tar(~isnan(D_to_tar)),1/200,10);
%             Dtotardiff = Ddiff(:,2);
%             numnan = sum(~isnan(Dtotardiff));
%             Data.TanV(1:length(Dtotardiff),i) = [Dtotardiff*-1];
%             [~,max_tanv] = max(abs(Data.TanV(:,i)));
%         %     if mean(Data.TanV(1:max_tanv,i))<0
%         %         Data.TanV(:,i) = -1*Data.TanV(:,i);
%         %     end
%             Data.TanA(1:length(Dtotardiff),i) = Ddiff(:,3)*-1;
%         end


end
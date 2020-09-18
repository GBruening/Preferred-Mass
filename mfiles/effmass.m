time_step = .005;
tic

target_str = {'one','two','thr','fou'};
input_normforce = 31.84E4;
% masses = [0,5,10,20]/2.2;
d=2
s=3
clearvars -except time_step target_str input_normforce masses minparams L d s

nsubj = 12;
subj_mass = [147,70*2.2,165,135,165,160,216,105,125,180,170,65*2.2];
subj_heights = [63,69,69,64.75,69,72,76,61,67,70,72,180/2.54]*2.54/100;
thetaE_start = [1.6766,1.8303,1.8303,1.7263,1.8303,1.8919,1.9626,1.6141,1.7840,1.8518,1.8919,1.8696];
thetaS_start = [0.7196,0.6152,0.6152,0.6864,0.6152,0.5717,0.5207,0.7609,0.6471,0.6001,0.5717,0.5876];

% % Metabolics
% nsubj = 8;
% subj_mass = [125,156.199,194.7,129.8,173.8,159.7,136.4,127.6];
% subj_heights = [162.5,167.60,195.6,167.6,180,172.7,175,171.5]/100;
% thetaE_start = [1.7049,1.7588,1.9786,1.7588,1.8696,1.8075,1.8280,1.7965];
% thetaS_start = [0.7008,0.6644,0.5089,0.6644,0.5876,0.6309,0.6167,0.6386];

% http://www.ele.uri.edu/faculty/vetter/BME207/anthropometric-data.pdf
upperarm_mass = 0.028*subj_mass/2.2;
lowerarm_mass = 0.022*subj_mass/2.2;
upperarm_length = (.825-.632)*subj_heights;
lowerarm_length = (.632-0.370)*subj_heights;
upperarm_lcom = 0.436*upperarm_length;
lowerarm_lcom = 0.682*lowerarm_length;

thetaE = [];
thetaS = [];

for subj=1:nsubj
    for c=1:4
        for t = 1:4

    vars{c,t}.time_inc = time_step;
    vars{c,t}.masses = [0,3,5,8]/2.2;
%     vars{c,t}.masses = [0,5,10,20]/2.2;
%     vars{c,t}.masses = masses/2.2;
    % vars{c,t}.speeds = {'VS','S','M','F','VF','VVF'};
    vars{c,t}.speeds = [.45, .55, .70, .85, 1.00, 1.15];
    switch c
        case 1
        vars{c,t}.speeds = [0.4407, 0.492, 0.5908, 0.7733, 0.965, 1.1567];
        case 2
        vars{c,t}.speeds = [0.4703,	0.5089,	0.5956,	0.7807,	0.9694,	1.1657];
        case 3
        vars{c,t}.speeds = [0.5114,	0.6006,	0.7847,	0.9701,	1.1591,	1.3438];
        case 4
        vars{c,t}.speeds = [0.5301,	0.6049,	0.7849,	0.9756,	1.1634,	1.3371,];
    end
    vars{c,t}.distances = [.05,.1,.15,.2];
    vars{c,t}.targets.one = [.0707 .0707];
    vars{c,t}.targets.two = [-.0707 .0707];
    vars{c,t}.targets.thr = [-.0707 -.0707];
    vars{c,t}.targets.fou = [.0707 -.0707];
    vars{c,t}.norm_force = input_normforce;%200E4;%31.8E4;
%     vars{c,t}.minparam = minparams{L};
    
    upperarm{c,t}.length = upperarm_length(subj); % meters
    upperarm{c,t}.l_com = upperarm_lcom(subj);
    upperarm{c,t}.centl = upperarm_lcom(subj);
    upperarm{c,t}.mass = upperarm_mass(subj); %kg
    upperarm{c,t}.Ic = (1/12)*upperarm{c,t}.mass*upperarm{c,t}.length.^2;
%     upperarm{c,t}.Ic = .0141;
    
    forearm{c,t}.mass = lowerarm_mass(subj);
    forearm{c,t}.length = lowerarm_length(subj); % meters, taken from An iterative optimal control and estimation design for nonlinear stochastic system
    forearm{c,t}.l_com = lowerarm_lcom(subj);
    [forearm{c,t}] = calc_forearmI(forearm{c,t},vars{c,t}.masses(c));
    forearm{c,t};
%     forearm{c,t}.Ic = .01882;


    shoulder{c,t} = [];
    elbow{c,t} = [];
    theta{c,t} = [];
    
%     ro = [0,.4];
    ro = [upperarm{c,t}.length*cos(mean(thetaS_start))+forearm{c,t}.length*cos(mean(thetaS_start)+mean(thetaE_start)),...
        upperarm{c,t}.length*sin(mean(thetaS_start))+forearm{c,t}.length*sin(mean(thetaS_start)+mean(thetaE_start))];
%     ro = [-.0758,0.4878];
    rf = [vars{c,t}.targets.(target_str{t})(1)*vars{c,t}.distances(d)/.1+ro(1),...
        vars{c,t}.targets.(target_str{t})(2)*vars{c,t}.distances(d)/.1+ro(2)];
    
    [Data{c,t}.time,Data{c,t}.x,Data{c,t}.y,Data{c,t}.vx,...
        Data{c,t}.vy,Data{c,t}.ax,Data{c,t}.ayy] ...
        =minjerk(ro,rf,vars{c,t}.speeds(s),vars{c,t}.time_inc);
    
    Data{c,t}.targetposition(1)=vars{c,t}.targets.(target_str{t})(1)*vars{c,t}.distances(d)/.1+ro(1);
    Data{c,t}.targetposition(2)=vars{c,t}.targets.(target_str{t})(2)*vars{c,t}.distances(d)/.1+ro(2);
    
    Data{c,t}.startposition = ro;
    
    vars{c,t}.masses;
    
    [ shoulder{c,t} , elbow{c,t} , theta{c,t} , eff_mass{c,t}] = ...
        Calc_kine_test( Data{c,t}, forearm{c,t}, upperarm{c,t},vars{c,t}.time_inc,vars{c,t}.masses(c));
    
        end
    end
    1;
    thetaE = [thetaE;theta{c,t}.E(1)];
    thetaS = [thetaS;theta{c,t}.S(1)];
    for c= 1:4
        temp=[];
        for t=1:4
            temp = [temp;eff_mass{c,t}(1)];
        end
        mean_effmass(c,subj) = mean(temp);
    end
end
mean_effmass
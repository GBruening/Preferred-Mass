function [rxn_extrap, idxonset, P_idx] = get_rxnextrap(t, v, targ_onset, P1, P2)
% Calculates reaction time using the "extrapolation" method
% Based on the "extrapolation" method described in Veerman et al. (2008)
%
% INPUTS:
%   t = nx1 time vector
%   v = nx1 resultant velocity vector
%   targ_onset = index of state when a target appears (or some event occurs)
%   P1 = number 0 < P1 < 1 for first "extrapolation" percent of max velocity
%   P2 = number 0 < P2 < 1 for second "extrapolation" percent of max velocity
% OUTPUTS
%   rxn_extrap = the reaction time
%   coefs = coefficients of linear polyfit
%   P_idx = nx2 matrix of indices for the detected P1 and P2
%
% Created by: Robbie Courter (11/13/2019)
% Last edited: Robbie Courter (11/19/2019)
    
    % Check that P1 < P2, if not, swap 
    if P1 > P2
        temp = P1;
        P1 = P2;
        P2 = temp;
    end
    
    % Get max velocity and index, P1% and P2% of max v;   
    [vmax, vmax_idx] = max(v(targ_onset:end));  
    vmax_idx = vmax_idx + (targ_onset-1);
    vmaxP1 = P1*vmax; 
    vmaxP2 = P2*vmax; 
    
    %Search back from peak to find the P1 percent of vmax
    backP1 = v(vmax_idx:-1:targ_onset) - vmaxP1;
    P1_idx = find(backP1 < 0,1,'first');
    % Error check, if velocity is already high before target onset,
    % the difference will never change signs.
    % This indicates a predictive movement (if target location is known)
    if isempty(P1_idx)
        P1_idx = length(backP1);
    end
    vmaxP1_idx = (vmax_idx - P1_idx) + 1;
    P_idx(1,1) = vmaxP1_idx;
    
    %Search back from peak to find the P1 percent of vmax
    P2_idx = find( v(vmax_idx:-1:targ_onset) < vmaxP2 ,1,'first');
    vmaxP2_idx = (vmax_idx - P2_idx) + 1;
    P_idx(1,2) = vmaxP2_idx;
    
    % Fit a line between the points, get slope and y-intercept 
    tfit = [t(vmaxP1_idx), t(vmaxP2_idx)];
    vfit = [v(vmaxP1_idx), v(vmaxP2_idx)];
    coefs = polyfit(tfit,vfit,1);
    
    % Get the reaction time
    rxn_extrap = roots(coefs) - t(targ_onset);
    [~, idxonset] = min(abs(t - roots(coefs)));
    
end


function Pmet = brockway(VO2, VCO2)

% Calculate metabolic expenditure in W, based on Brockway 1987
%
% Pmet,gross = 16.58 [W*s/(mL O2)]*VO2dot + 4.51 [W*s/(mL CO2)]*VCO2dot
%
% VO2 & VCO2 needs to be in mLO2/s

Pmet = 16.58*VO2 + 4.51*VCO2;
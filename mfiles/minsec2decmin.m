function decmin = minsec2decmin(minsec)

% minsec2decmin takes a 2-element array of time in minutes and seconds 
% and coverts it to a time in just minutes, where the seconds become a
% decimal

decmin = (minsec(1)*60 + minsec(2))/60;
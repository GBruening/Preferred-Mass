function wmean = wgtave(data, wgtings)

N = nansum(data.*wgtings);
D = nansum(wgtings);

wmean = N/D;
function [res]=ame_delrange(x,col,beg,eend)
% function [res]=ame_delrange(x,col,beg,eend)
% Sets column col in matrix x to NaN using range
% between beg and eend.
%
% Time in ts_* format. See ts_range


bb = ts_dnum(beg);
ee = ts_dnum(eend);


xr = find(x(:,1) >= bb & x(:,1) <= ee);

x(xr,col) = x(xr,col) + NaN;

res = x;

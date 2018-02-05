#!/usr/local/bin/octave -q
% Load 60-min data

year = input('Give year: ');

eval(sprintf("load -force yearfiles/a_s%d",year));



for i=1:12
month = i;
rep = ts_range(a_s,sprintf('01/%d/%d 00:00:00',month,year),\
	sprintf('01/%d/%d 00:00:00',month+1,year));

mean(rep)
end

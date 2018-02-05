#!/usr/local/bin/octave -q
% Make the all files
ts_init;
ts_setd(-693902);
%!!!
% Edit this each time a file is added!
nrfiles = [13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32  33 34]; 

for i=1:columns(nrfiles)
fprintf(stderr,'Loading file nr %d\n',nrfiles(i));
eval(sprintf('load -force binfiles/ame10%02d_f',nrfiles(i)));
eval(sprintf('load -force binfiles/ame10%02d_t',nrfiles(i)));
eval(sprintf('load -force binfiles/ame10%02d_s',nrfiles(i)));
end


a_f = ame1013_f;
a_t = ame1013_t;
a_s = ame1013_s;

%!!!
% Edit this every time a new file is added!
% RH correction factor (offset to get 100% max)
rh1c = [-6.6 -6.8 -6.9 -6.5 -6.8 -6.3 -6.7 -5.6 -5.8 -5.7 -6.6 -4.3 -6.1 -5.8 -6.3 -6.9 -6.3 -4.5 -6.6 -5.8  -5.4 -7.5]; 

rh2c = [0.5 0.5 0.0 -2.5 -2.5 -2.3 -2.9 -1.3 -1.9 -1.7 -2.8 -0.6 -2.3 -1.9 -2.8 -3.6 -3.3 -1.5 -3.8 -2.6 -3.3 -4.7];

% Reflected radiation 'correction'
refrad = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 NaN NaN NaN NaN NaN NaN NaN NaN];



%-------------------------------------------------------
%a_f(:,[5 6 15 16]) = a_f(:,[5 6 15 16]) .* NaN;
%a_s(:,[5 6]) = a_s(:,[5 6]) .* NaN;



% Correct RH
a_f(:,5) = a_f(:,5) + rh1c(1);
a_f(:,6) =  a_f(:,6) + rh2c(1);
a_s(:,5) = a_s(:,5) + rh1c(1);
a_s(:,6) =  a_s(:,6) + rh2c(1);

%Correct refrad
a_s(:,12) = a_s(:,12) + refrad(1);
a_f(:,12) = a_f(:,12) + refrad(1);


a_s = a_s(:,1:14);
for i=2:columns(nrfiles)
	fprintf(stderr,'Correcting and adding file nr %d\n',nrfiles(i));
	eval (sprintf('d_f = [ame10%02d_f];',nrfiles(i)));
	eval (sprintf('d_s = [ame10%02d_s(:,1:14)];',nrfiles(i)));
	d_f(:,5) = d_f(:,5) + rh1c(i);
	d_f(:,6) =  d_f(:,6) + rh2c(i);
	d_s(:,5) = d_s(:,5) + rh1c(i);
	d_s(:,6) =  d_s(:,6) + rh2c(i);
	d_s(:,12) =  d_s(:,12) + refrad(i);
	d_f(:,12) =  d_f(:,12) + refrad(i);
	a_f = [a_f; d_f];
	a_s = [a_s; d_s];
	eval (sprintf('a_t = [a_t; ame10%02d_t];',nrfiles(i)));
end

% Now make the year
a_f = ts_range(a_f,'1/1/2000 00:00:00','1/1/2001 00:00:00');
a_s = ts_range(a_s,'1/1/2000 00:00:00','1/1/2001 00:00:00');
a_t = ts_range(a_t,'1/1/2000 00:00:00','1/1/2001 00:00:00');



% Set the following to NaN due to instrument problems

%Humicap 2 2/2/2000 ->
a_f = ame_delrange(a_f,6,'1/2/2000 00:00:00','29/2/2000 00:00:00');
a_s = ame_delrange(a_s,6,'1/2/2000 00:00:00','29/2/2000 00:00:00');

%Humicap 1 12/2/2000
a_f = ame_delrange(a_f,5,'12/1/2000 00:00:00','12/1/2000 23:56:00');
a_s = ame_delrange(a_s,5,'12/1/2000 00:00:00','12/1/2000 23:56:00');

% TC
a_t = ame_delrange(a_t,2,'1/1/2000 00:00:00','1/3/2000 00:00:00');
a_t = ame_delrange(a_t,2,'1/8/2000 00:00:00','31/12/2000 00:00:00');
a_t = ame_delrange(a_t,4,'1/1/2000 00:00:00','1/3/2000 00:00:00');
a_t = ame_delrange(a_t,4,'1/8/2000 00:00:00','31/12/2000 00:00:00');

fprintf(stderr,'Saving year files\n');
save -mat-binary yearfiles/a_f2000 a_f
save -mat-binary yearfiles/a_s2000 a_s
save -mat-binary yearfiles/a_t2000 a_t

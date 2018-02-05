#!/usr/local/bin/octave -q
% Make the all files

ts_init;
ts_setd(-693902);
%!!!
% Edit this each time a file is added!
nrfiles = [34 35]; 

for i=1:columns(nrfiles)
fprintf(stderr,'Loading file nr %d\n',nrfiles(i));
eval(sprintf('load -force binfiles/ame10%02d_f',nrfiles(i)));
eval(sprintf('load -force binfiles/ame10%02d_t',nrfiles(i)));
eval(sprintf('load -force binfiles/ame10%02d_s',nrfiles(i)));
end


a_f = ame1034_f;
a_t = ame1034_t;
a_s = ame1034_s;

%!!!
% Edit this every time a new file is added!
% RH correction factor (offset to get 100% max)
rh1c = [-5.4 NaN]; 

rh2c = [-3.3 -4.6];

% Reflected radiation 'correction'
refrad = [NaN NaN];



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
a_f = ts_range(a_f,'1/1/2001 00:00:00','1/1/2002 00:00:00');
a_s = ts_range(a_s,'1/1/2001 00:00:00','1/1/2002 00:00:00');
a_t = ts_range(a_t,'1/1/2001 00:00:00','1/1/2002 00:00:00');



% Set the following to NaN due to instrument problems
a_f = ame_delrange(a_f,5,'10/1/2001 00:00:00','1/1/2002 00:00:00');
a_s = ame_delrange(a_s,5,'10/1/2001 00:00:00','1/1/2002 00:00:00');

a_f = ame_delrange(a_f,8,'1/1/2001 00:00:00','1/1/2002 00:00:00');
a_s = ame_delrange(a_s,8,'1/1/2001 00:00:00','1/1/2002 00:00:00');

a_f = ame_delrange(a_f,4,'27/1/2001 00:00:00','1/1/2002 00:00:00');
a_s = ame_delrange(a_s,4,'27/1/2001 00:00:00','1/1/2002 00:00:00');

a_f = ame_delrange(a_f,12,'27/1/2001 00:00:00','1/1/2002 00:00:00');
a_s = ame_delrange(a_s,12,'27/1/2001 00:00:00','1/1/2002 00:00:00');

a_f = ame_delrange(a_f,14,'27/1/2001 00:00:00','1/1/2002 00:00:00');
a_s = ame_delrange(a_s,14,'27/1/2001 00:00:00','1/1/2002 00:00:00');

a_t = ame_delrange(a_t,2,'1/1/2001 00:00:00','1/1/2002 00:00:00');
a_t = ame_delrange(a_t,4,'1/1/2001 00:00:00','1/1/2002 00:00:00');

fprintf(stderr,'Saving year files\n');
save -mat-binary yearfiles/a_f2001 a_f
save -mat-binary yearfiles/a_s2001 a_s
save -mat-binary yearfiles/a_t2001 a_t

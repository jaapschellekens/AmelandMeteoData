#!/usr/local/bin/octave -q
% Make the all files

%!!!
% Edit this each time a file is added!
nrfiles = [1 2 3 4 5 6 7 8 9 10 11 12 13]; 

for i=1:columns(nrfiles)
fprintf(stderr,'Loading file nr %d\n',i);
eval(sprintf('load -force binfiles/ame10%02d_f',i));
eval(sprintf('load -force binfiles/ame10%02d_t',i));
eval(sprintf('load -force binfiles/ame10%02d_s',i));
end


a_f = ame1001_f(:,[1 2 3 4 1 1 5 6 7 8 9 10 11 12 1 1]);
a_t = ame1001_t;
a_s = ame1001_s(:,[1 2 3 4 1 1 5 6 7 8 9 10 11 12]);

%!!!
% Edit this every time a new file is added!
% RH correction factor (offset to get 100% max)
rh1c = [NaN -5.8 -5.8 -5.8 -4.5 -5.4 -5.7 -6.7 -6.1 -6.1\
 -6.4 -5.9 -6.6];

rh2c = [NaN 2.6 2.6 2.6  2.8  2.2 1.7 0.5 1.2 1.9\
 0.9 2.0 0.5];

# Reflected radiation 'correction'
refrad = [NaN NaN NaN NaN NaN NaN NaN NaN 0.0 0.0\
 0.0 0.0 0.0];




#-------------------------------------------------------
a_f(:,[5 6 15 16]) = a_f(:,[5 6 15 16]) .* NaN;
a_s(:,[5 6]) = a_s(:,[5 6]) .* NaN;



# Correct RH
a_f(:,5) = a_f(:,5) + rh1c(1);
a_f(:,6) =  a_f(:,6) + rh2c(1);
a_s(:,5) = a_s(:,5) + rh1c(1);
a_s(:,6) =  a_s(:,6) + rh2c(1);

#Correct refrad
a_s(:,12) = a_s(:,12) + refrad(1);
a_f(:,12) = a_f(:,12) + refrad(1);

for i=2:columns(nrfiles)
	fprintf(stderr,'Correcting and adding file nr %d\n',i);
	eval (sprintf('d_f = [ame10%02d_f];',i));
	eval (sprintf('d_s = [ame10%02d_s(:,1:14)];',i));
	d_f(:,5) = d_f(:,5) + rh1c(i);
	d_f(:,6) =  d_f(:,6) + rh2c(i);
	d_s(:,5) = d_s(:,5) + rh1c(i);
	d_s(:,6) =  d_s(:,6) + rh2c(i);

	d_s(:,12) =  d_s(:,12) + refrad(i);
	d_f(:,12) =  d_f(:,12) + refrad(i);
	a_f = [a_f; d_f];
	a_s = [a_s; d_s];
	eval (sprintf('a_t = [a_t; ame10%02d_t];',i));
end

% Last minute corrections:
% 2e Humicap deed het een tijdje raar

dd = ts_range (a_f,'27/9/1999 00:00:00','19/10/1999 00:00:00');
a = find(a_f(:,1) >= dd(1,1) & a_f(:,1) <= dd(rows(dd),1)); 
a_f(a,6) = NaN;

dd = ts_range (a_s,'27/9/1999 00:00:00','19/10/1999 00:00:00');
a = find(a_s(:,1) >= dd(1,1) & a_s(:,1) <= dd(rows(dd),1)); 
a_s(a,6) = NaN;

% Now make the year
a_f = ts_range(a_f,'1/1/1999 00:00:00','1/1/2000 00:00:00');
a_s = ts_range(a_s,'1/1/1999 00:00:00','1/1/2000 00:00:00');
a_t = ts_range(a_t,'1/1/1999 00:00:00','1/1/2000 00:00:00');

fprintf(stderr,'Saving year files\n');
save -mat-binary yearfiles/a_f1999 a_f
save -mat-binary yearfiles/a_s1999 a_s
save -mat-binary yearfiles/a_t1999 a_t

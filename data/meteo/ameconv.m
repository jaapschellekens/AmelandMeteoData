function [vijf dertig zestig] = ameconv(fname)

fprintf(stderr,"Dertig min data...\n");
dertig = ts_21x(fname,0,30,20000);
fprintf(stderr,"Zestig min data...\n");
zestig = ts_21x(fname,0,60,20000);
zestig = [zestig  zestig(:,2) zestig(:,2)];

if ~strcmp(fname,'raw/ame1001.dat')
fprintf(stderr,"Vijf min data...\n");
vijf = ts_21x(fname,0,5,20000);
else
vijf = [zestig  zestig(:,2) zestig(:,2) zestig(:,2) zestig(:,2)];
end
fprintf(stderr,"Dertig min data...\n");

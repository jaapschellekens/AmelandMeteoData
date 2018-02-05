#!/usr/local/bin/octave -q
% Load 5-min data

year = input('Give year: ');
inn = input('Give month number for report: ');

eval(sprintf("load -force yearfiles/a_f%d",year));



for i=1:columns(inn)

month = inn(i);


off = sprintf('%d_%d.tex',month,year);
of = fopen(off,'w');

fprintf(of,'\\documentclass{article}');
fprintf(of,'\\usepackage{epsfig}\\title{Ameland Report of %d %d}\\begin{document}\\maketitle\n',month,year);

rep = ts_range(a_f,sprintf('01/%d/%d 08:00:00',month,year),\
	sprintf('01/%d/%d 08:00:00',month+1,year));

rep = rep(1:rows(rep)-1,:);	

% test in 5 min or hour data....
dd = diff(rep(:,1));


fprintf(stderr,'Doing month %d.\n',month);
fprintf(stderr,'Making twelve hour values (8-20-8)...\r');
secs = [dd(1); dd] * 43200;
msecs = ts_reduce([rep(:,1) secs],1,1,0.5);
msecs = msecs(:,2);
	
% now make mean max min of T RH WINDSPEED WINDSPEED 2


% makkink 
lamb = ml_lambda(rep(:,7));
gamm = ml_gamma(rep(:,7),lamb);
[es del] = ml_esdelta(rep(:,7));
makk = ml_makkink(rep(:,11),del,gamm);
makk = makk .* secs ./lamb;


rep = [rep makk];


fprintf(of,'\\section{Twelve hourly values in month %d (%d)}\n\n',month,year);

fprintf(of,'\\footnotesize\\begin{verbatim}');

dd = ts_reduce(rep,1,1,0.5);
ddd = ts_reduce(rep,0,1,0.5);

dr = [ddd(:,1) ddd(:,4) dd(:,[11 7 5 9 14])]; 

dmax = ts_reduce(rep,2,1,0.5);
dmin = ts_reduce(rep,3,1,0.5);

dr = [ddd(:,1) - 0.5 ddd(:,4) dd(:,[7 5 9 14])]; 

fprintf(of,'Date/Time               P(sum)\tT(mean)\tRH(mean)\tU(mean)\tUvec(mean)\n\n');
ts_fmt(dr,of,'\t%8.2f');



fprintf(of,'\n\nDate/Time             T(max)\tT(min)\tU(max)\tIrad(J/cm3)\tMakkink(mm)\n\n');
dr = [ddd(:,1) - 0.5 dmax(:,7) dmin(:,7) dmax(:,9) ddd(:,11).*msecs./10000 ddd(:,17)];
ts_fmt(dr,of,'\t%8.2f');

fprintf(of,'\\end{verbatim}');
fprintf(of,'\\section{Monthly values of month %d (%d)}\n\n',month,year);
fprintf(of,'\\footnotesize\\begin{verbatim}');

lab = ["P";"Irad";"T(1)";"RH(1)";"U(1)";"Uvec";"Makkink"];

fprintf(stderr,'Making monthly values...\r');
ts_stats([rep(:,[1  4 11 7 5 9 14]) makk],'%14.2f',lab,of);


## Now make plots of T, RH, cumm P, Wind, Winddir, irad
## Use the hourly values for this.
gset term  postscript   eps 

fprintf(stderr,'Making graphs .........\r');
eval(sprintf('gset output \'%d1.eps\'',month)); 
ts_init;
gset key left
subplot(1,1,1);
subplot(3,1,1);
ts_plot(rep(:,[1 7 8]),'Temperature','lines',1);
subplot(3,1,2);
ts_plot(rep(:,[1 5 6]),'Humidity','lines',1);
subplot(3,1,3);
ts_plot(rep(:,[1 9 10]),'Windspeed','lines',1);
subplot(1,1,1);
gset output

eval(sprintf('gset output \'%d2.eps\'',month)); 
subplot(3,1,1)
ts_plot(rep(:,[1 11]),'Radiation','lines',1);
subplot(3,1,2);
ts_plot(rep(:,[1 14]),'Winddirection','lines',1);
subplot(3,1,3);
ts_plot([rep(:,1) cumsum(rep(:,4))],'Precipitation','lines',1);
subplot(1,1,1);
gset output
gset output
gset output
closeplot

fprintf(of,'\\end{verbatim}\\clearpage\\centerline{\\epsfig{figure=%d1.eps}}\n',month);
fprintf(of,'\\centerline{\\epsfig{figure=%d2.eps}}\n',month);
fprintf(of,'\\end{document}');

fclose(of);

fprintf(stderr,'Running LaTeX .........\r');
system(sprintf('latex %s > /dev/null',off));
fprintf(stderr,'Running dvips .........\r');
system(sprintf('dvips -o %s.ps %d_%d.dvi >& /dev/null ',off,month,year));
system(sprintf('rm -f %d2.eps  %d1.eps %s %d_%d.???',month,month,off,month,year));
fprintf(stderr,'Done.                                 \n');

end

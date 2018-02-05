
fprintf(2,'Reading files...\n');
load -force distfiles/five.mat
load -force distfiles/sixt.mat 
load -force distfiles/tc.mat 
load -force distfiles/sixall.mat 

save -ascii distfiles/five.asc af
save -ascii distfiles/sixt.asc as
save -ascii distfiles/tc.asc at
save -ascii distfiles/sixall.asc  all

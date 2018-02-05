% Buis data
% 
clear
ts_init;

load binfiles/r_b5b.mat
load binfiles/r_ingr.mat
load binfiles/r_abs.mat
load binfiles/meteo.mat

% period selecting
% alle drukopnemers
% 15/11/1999 10/4/2000
% 10/5/1999 7/9/2000
a1 = ts_range(c_b5b,'15-Nov-1999 00:00:00','10-Apr-2000 00:00:00');
b1 = ts_range(c_ingr,'15-Nov-1999 00:00:00','10-Apr-2000 00:00:00');
c1 = ts_range(c_abs,'15-Nov-1999 00:00:00','10-Apr-2000 00:00:00');
a2 = ts_range(c_b5b,'10-May-2000 00:00:00','7-Sep-2000 00:00:00');
b2 = ts_range(c_ingr,'10-May-2000 00:00:00','7-Sep-2000 00:00:00');
c2 = ts_range(c_abs,'10-May-2000 00:00:00','7-Sep-2000 00:00:00');
met1 = ts_range(meteo,'15-Nov-1999 00:00:00','10-Apr-2000 00:00:00');
met2 = ts_range(meteo,'10-May-2000 00:00:00','7-Sep-2000 00:00:00');

save -ascii  ascii/b5b_1.txt a1
save -ascii  ascii/b5b_2.txt a2
save -ascii  ascii/ingr_1.txt b1
save -ascii  ascii/ingr_2.txt b2
save -ascii  ascii/abs_1.txt c1
save -ascii  ascii/met1.txt met1
save -ascii  ascii/met2.txt met2
save -ascii  ascii/abs_2.txt c2

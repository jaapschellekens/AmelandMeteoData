% First the wll data
% bsb is de buis b5b van Staatsbosbeheer
% Buis dataL
% 
ts_init;
fprintf(2,'Reading b5b files...\n');
b5b_0 = wlltots('raw/b5b-0.txt');
b5b_1 = [wlltots('raw/b5b-1.txt')];
b5b_2 = [wlltots('raw/b5b-2.txt')];
b5b_3 = [wlltots('raw/b5b-3.txt')];
b5b_4 = [wlltots('raw/b5b-4.txt')];


b5b = [b5b_0;b5b_1;b5b_2;b5b_3;b5b_4];

fprintf(2,'Reading ingraaf files...\n');
ingr_0 = wlltots('raw/ingra-0.txt');
ingr_1 = wlltots('raw/ingra-1.txt');
ingr_2 = wlltots('raw/ingra-2.txt');
ingr_3 = wlltots('raw/ingra-3.txt');
ingr_4 = wlltots('raw/ingra-4.txt');

ingr = [ingr_0;ingr_1;ingr_2;ingr_3;ingr_4];




fprintf(2,'reading 21x files...\n');
abs_0 = ts_21x('raw/bosw21x-1.dat',0,111);
abs_1 = ts_21x('raw/bosw21x-2.dat',0,111);
abs_2 = ts_21x('raw/bosw21x-3.dat',0,111);
abs_3 = ts_21x('raw/bosw21x-4.dat',0,110);
abs_3(:,[2 3 4 5]) = NaN;
abs_3 = abs_3(:,[1 2 3 6 7]);
abs = [abs_0;abs_1;abs_2; abs_3];


save -binary binfiles/b5b_0 b5b_0
save -binary binfiles/b5b_1 b5b_1
save -binary binfiles/b5b_2 b5b_2
save -binary binfiles/b5b_3 b5b_3
save -binary binfiles/b5b_4 b5b_4
save -binary binfiles/b5b b5b


save -binary binfiles/ingr_0 ingr_0
save -binary binfiles/ingr_1 ingr_1
save -binary binfiles/ingr_2 ingr_2
save -binary binfiles/ingr_3 ingr_3
save -binary binfiles/ingr_4 ingr_4
save -binary binfiles/ingr ingr


save -binary binfiles/abs_0 abs_0
save -binary binfiles/abs_1 abs_1
save -binary binfiles/abs_2 abs_2
save -binary binfiles/abs_3 abs_3
save -binary binfiles/abs abs

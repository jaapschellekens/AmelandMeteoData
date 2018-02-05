% First the wll data
% bsb is de buis b5b van Staatsbosbeheer
% Buis dataL
% 
ts_init;
fprintf(2,'loading files...\n');
load binfiles/b5b_0 b5b_0
load binfiles/b5b_1 b5b_1
load binfiles/b5b_2 b5b_2
load binfiles/b5b_3 b5b_3
load binfiles/b5b_4 b5b_4


load binfiles/ingr_0 ingr_0
load binfiles/ingr_1 ingr_1
load binfiles/ingr_2 ingr_2
load binfiles/ingr_3 ingr_3
load binfiles/ingr_4 ingr_4

load binfiles/abs_0 abs_0
load binfiles/abs_1 abs_1
load binfiles/abs_2 abs_2
load binfiles/abs_3 abs_3

% Now for the corrections to fieldlevel

% 0.1 mm per unit convert to meter
# Metingen in cm onder maaiveld in buis b5b
# Top buis is 65cm boven maaiveld
# Datum             nivo onder top
# 09/05/1998 18:00:00    70.1
# 03/11/1999 12:00:00    110.5
# 28/02/2000 12:00:00    52
# 06/05/2000 12:00:00    85

fprintf(2,'correcting files...\n');
b5b_0(:,2) = (b5b_0(:,2) - b5b_0(1,2)) *0.01 - 5.1;
b5b_1(:,2) = (b5b_1(:,2) - b5b_1(1,2)) * 0.01 + b5b_0(rows(b5b_0),2); 
% hier zit gat
b5b_2(:,2) = (b5b_2(:,2) - b5b_2(1,2)) *0.01 -45.0 ;% + b5b_1(rows(b5b_1),2); 
b5b_3(:,2) = (b5b_3(:,2) - b5b_3(1,2)) * 0.01+ b5b_2(rows(b5b_2),2); 
b5b_4(:,2) = (b5b_4(:,2) - b5b_4(1,2)) *0.01 + b5b_3(rows(b5b_3),2); 


c_b5b = [b5b_0;b5b_1;b5b_2;b5b_3;b5b_4];
save -binary binfiles/c_b5b c_b5b

%a = find (b5b(:,2) > 30000);

%b5b(a,2) = NaN;


% Now for the corrections to fieldlevel
% Data of the dug-in transducer....


ingr_0(:,2) = (ingr_0(:,2) - ingr_0(1,2)) *0.01 - 5.1;

ingr_1(:,2) = (ingr_1(:,2) - ingr_1(1,2)) * 0.01 + ingr_0(rows(ingr_0),2) -38; 
ingr_2(:,2) = (ingr_2(:,2) - ingr_2(1,2)) * 0.01 + ingr_1(rows(ingr_1),2); 
% correcttion:
ingr_2(rows(ingr_2)-3:rows(ingr_2),2) = 45.11 -38;
ingr_3(:,2) = (ingr_3(:,2) - ingr_3(1,2)) * 0.01 + ingr_2(rows(ingr_2),2); 
ingr_4(:,2) = (ingr_4(:,2) - ingr_4(1,2)) * 0.01 + ingr_3(rows(ingr_3)-445,2); 
ingr_4 = ingr_4(1:12926-445,:);

c_ingr = [ingr_0;ingr_1;ingr_2;ingr_3;ingr_4];
save -binary binfiles/c_ingr c_ingr



% The 21x data
% 21x file with:
% time/date, raw sm, sm%, air-press, ingraaf

 
% first generate water level data
abs_0(:,6) = (abs_0(:,5) - abs_0(:,4)) * 1000 - 75 - 81;
abs_1(:,6) = (abs_1(:,5) - abs_1(:,4)) * 1000 - 75 - 81;
abs_2(:,6) = (abs_2(:,5) - abs_2(:,4)) * 1000 - 75 - 81;
abs_3(:,6) = abs_3(:,5) - abs_3(:,4);
abs_3(rows(abs_3)-950:rows(abs_3),6) = NaN; 

#abs_0(:,2) = (abs_0(:,2) - abs_0(1,2)) *10.0;

#abs_1(:,2) = (abs_1(:,2) - abs_1(1,2)) * 10.0 + abs_0(rows(abs_0),2); 
#abs_2(:,2) = (abs_2(:,2) - abs_2(1,2)) * 10.0 + abs_1(rows(abs_1),2); 
#abs_3(:,2) = (abs_3(:,2) - abs_3(1,2)) * 10.0 + abs_2(rows(abs_2),2); 

# maken regressie met b5b!
# regressie abs_cor.m
abs_3(:,6) = abs_3(:,6) * 20.466 -162.593;
c_abs = [abs_0;abs_1;abs_2;abs_3];

save -binary binfiles/c_abs c_abs


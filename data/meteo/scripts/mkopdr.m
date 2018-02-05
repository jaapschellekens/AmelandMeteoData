% uurwaarden 1 april 1999 - 1April 2000
% uurwaarden 1 april 2000 - 1April 2001

% 4 maanden in 2000
% Mei, Juni, Juli, Aug (TVAR + MAK)

ts_init;
ts_setd(-693902);

load -force distfiles/sixall.mat


mei = ts_range(all,'1/5/2000 00:00:00','1/6/2000 00:00:00');
jun = ts_range(all,'1/6/2000 00:00:00','1/7/2000 00:00:00');
jul = ts_range(all,'1/7/2000 00:00:00','1/8/2000 00:00:00');
aug = ts_range(all,'1/8/2000 00:00:00','1/9/2000 00:00:00');

yr99 = ts_range(all,'1/4/1999 00:00:00','1/4/2000 00:00:00');
yr00 = ts_range(all,'1/4/2000 00:00:00','1/4/2001 00:00:00');

% seconds in each interval
secs = 3600; % fixed hourly intervals
% now calculate makkink for the whole period...
lamb = ml_lambda(all(:,7));
gamm = ml_gamma(all(:,7),lamb);
[es del] = ml_esdelta(all(:,7));
makk = ml_makkink(all(:,11),del,gamm);
makk = makk .* secs ./lamb;

% now for the TVAR results
rho = 1.2; % kg/m^3
cp = 1012.0;
H = ml_tvardry(rho,cp,all(:,18),3.0,all(:,7));
H = H .* secs ./lamb;

% estimate net radiation
Rn = -20.17 + 0.72 * all(:,11);
% conv to mm
Rn =  Rn .* secs ./lamb;
% remove all neg values
x = find(Rn < 0.0);
Rn(x) = 0.0;

% by diff we can calculate E
E = Rn .- H;


% calculate average days...
 
% now make daily totals of H, E, Rn  and makk
dtot = ts_reduce([all(:,1) H E Rn makk],0,1,1);

all = [all H E Rn makk];

mmei = ts_range(all,'1/5/2000 00:00:00','1/6/2000 00:00:00');
jjun = ts_range(all,'1/6/2000 00:00:00','1/7/2000 00:00:00');
jjul = ts_range(all,'1/7/2000 00:00:00','1/8/2000 00:00:00');
aaug = ts_range(all,'1/8/2000 00:00:00','1/9/2000 00:00:00');

yyr99 = ts_range(all,'1/4/1999 00:00:00','1/4/2000 00:00:00');
yyr00 = ts_range(all,'1/4/2000 00:00:00','1/4/2001 00:00:00');

% Now save opdracht en antwoord files.....

save -mat-binary Opdracht/all.mat all
save -mat-binary Opdracht/mmei.mat mmei
save -mat-binary Opdracht/jjun.mat jjun
save -mat-binary Opdracht/jjul.mat jjul
save -mat-binary Opdracht/aaug.mat aaug
save -mat-binary Opdracht/yyr99.mat yyr99
save -mat-binary Opdracht/yyr00.mat yyr00

save -ascii Opdracht/mei.asc mei
save -ascii Opdracht/jun.asc jun
save -ascii Opdracht/jul.asc jul
save -ascii Opdracht/aug.asc aug
save -ascii Opdracht/yr99.asc yr99
save -ascii Opdracht/yr00.asc yr00

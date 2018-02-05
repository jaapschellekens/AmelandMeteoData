#ws; % load workspace

metmean = ts_reduce(metfive,1,1,15/(24 * 60));
metsum = ts_reduce(metfive,0,1,15/(24 * 60));

save -mat-binary binfiles/metmean.mat metmean
save -mat-binary binfiles/metsum.mat metsum

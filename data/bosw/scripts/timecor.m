% nog maken
ws;
c_b5b = ts_reduce(c_b5b,1,1,15/(24 * 60));
save -mat-binary cc_b5b.mat c_b5b
c_ingr = ts_reduce(c_ingr,1,1,15/(24 * 60));
save -mat-binary cc_ingr.mat c_ingr
c_abs = ts_reduce(c_abs,1,1,15/(24 * 60));
save -mat-binary cc_abs.mat c_abs


c_b5b_d = ts_reduce(c_b5b,1,1,1);
save -mat-binary cc_b5b_d.mat c_b5b_d
c_ingr_d = ts_reduce(c_ingr,1,1,1);
save -mat-binary cc_ingr_d.mat c_ingr_d
c_abs_d = ts_reduce(c_abs,1,1,1);
save -mat-binary cc_abs_d.mat c_abs_d

#!/usr/local/bin/octave -q
ls raw/
fname = input('Give input filename: ','S');
ls binfiles/
dd = input('Give outfile prefix: ','S');
[a b c] = ameconv(sprintf('raw/%s',fname));
eval(sprintf('%s_f = a;',dd));
eval(sprintf('save -mat-binary binfiles/%s_f %s_f',dd,dd));
eval(sprintf('%s_t = b;',dd));
eval(sprintf('save -mat-binary binfiles/%s_t %s_t',dd,dd));
eval(sprintf('%s_s = c;',dd));
eval(sprintf('save -mat-binary binfiles/%s_s %s_s',dd,dd));

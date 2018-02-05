#!/usr/local/bin/octave -q
% Load 30-min data

year = input('Give year: ');

eval(sprintf("load -force yearfiles/a_t%d",year));

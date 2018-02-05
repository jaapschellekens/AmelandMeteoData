clear
load binfiles/reg.mat
% b = abs col6 a = b5b
[cof serr x rsq] = lregress (a(:,2),b(:,6));
bb = b(:,6) * cof(2) + cof(1);
hold off
plot(bb,b(:,6))

hold
plot(bb,b(:,6))
hold off

figure(1)
ts_prange(1);
hold off
aa2 = ts_range(a2,'5-Aug-2000 00:00:00','13-Aug-2000 00:00:00');
aa1 = ts_range(a1,'5-Apr-2000 00:00:00','9-Apr-2000 00:00:00');
bb2 = ts_range(b2,'5-Aug-2000 00:00:00','13-Aug-2000 00:00:00');
bb1 = ts_range(b1,'5-Apr-2000 00:00:00','9-Apr-2000 00:00:00');
cc2 = ts_range(c2,'5-Aug-2000 00:00:00','13-Aug-2000 00:00:00');
cc1 = ts_range(c1,'5-Apr-2000 00:00:00','9-Apr-2000 00:00:00');
%bb
%cc
ts_plot(aa2,'B5B peilbuis');
hold on
ts_plot(bb2,'Ingraaf','g');
ts_plot(cc2(:,[1 6]),'Absoluut','b');
%ts_prange('5/8/2000 00:00:00','13/8/2000 00:00:00',1);

figure(2)
hold off
ts_plot(aa1,'B5B peilbuis');
hold on
ts_plot(bb1,'Ingraaf','g');
ts_plot(cc1(:,[1 6]),'Absoluut','b');
%ts_prange('4/4/2000 00:00:00','9/4/2000 00:00:00',1);

DESCRIPTION OF THE AMELAND METEO DATA FILES
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Author: Jaap Schellekens (schj@xs4all.nl)
Date:   April 2001

All (more or less) cleaned data is located in the distfiles/
directory:

five.mat	The 'raw' five minute record
sixall.mat	All variables in 60 min format (including TC data)
sixt.mat	The 'raw' sixty minute data
tc.mat		The raw TC data (30 min)

The .mat files are in matlab 4 format. The .asc files contain the
same data but are in ascii format.

Column description:
All files...
1:	The first column in each files contains a date/time number. To
get excell compatibillity subtract 2 from the number and format your data
in date/time. To get matlab 5 date/time compatibillty add 693842.

five.mat
2:	battery voltage [V]
3: 	datalogger temperature [oC]
4:	precipitation	[mm]
5:	RH probe 1	[%]
6:	RH probe 2	[%]
7:	T probe 1	[oC]
8:	T probe 2	[oC]
9:	windspeed 1	[m/s] top
10:	windspeed 2	[m/s] bottom
11:	incoming radiation [Wm^2]
12:	reflected radiation [Wm^2]
13:	windvector. speed [m/s]
14:	windvector, direction [degree]
15:	windspeed 30 sec max [m/s] top
16:	windspeed 30 sec max [m/s] bottom

sixt.mat
2:	battery voltage [V]
3: 	datalogger temperature [oC]
4:	precipitation	[mm]
5:	RH probe 1	[%]
6:	RH probe 2	[%]
7:	T probe 1	[oC]
8:	T probe 2	[oC]
9:	windspeed 1	[m/s] top
10:	windspeed 2	[m/s] bottom
11:	incoming radiation [Wm^2]
12:	reflected radiation [Wm^2]
13:	windvector. speed [m/s]
14:	windvector, direction [degree]


sixall.mat
2:	battery voltage [V]
3: 	datalogger temperature [oC]
4:	precipitation	[mm]
5:	RH probe 1	[%]
6:	RH probe 2	[%]
7:	T probe 1	[oC]
8:	T probe 2	[oC]
9:	windspeed 1	[m/s] top
10:	windspeed 2	[m/s] bottom
11:	incoming radiation [Wm^2]
12:	reflected radiation [Wm^2]
13:	windvector. speed [m/s]
14:	windvector, direction [degree]
15:	Temp TC1	[oC]
16:	Temp TC2        [oC]
17:	Std TC1		[oC]
18:	Std TC1         [oC]


tc.mat
2:	Temp TC1	[oC]
3:	Temp TC2        [oC]
4:	Std TC1		[oC]
5:	Std TC1         [oC]

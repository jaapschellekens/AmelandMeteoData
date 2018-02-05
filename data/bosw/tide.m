function ret= tide(t)

#define c1 62.3
#define c2 13.3
#define c3 9.2
#define c4 9.9
#define c5 7.6
#define pi 3.14159265


for (i = 1; i <= hours; ++i)
    {
      toprint = sum + mul * (tidecal (i));
      fprintf (outputfile, "%lf %lf\n", (double) ttime, (double) toprint);
      ttime += 3600;
    }

double
tidecal (t)
     int t;
{
  return c1 * cos (((2 * pi * t) / 12.42) - ((352.1 / 360) * 2 * pi)) + c2 * cos (((2 * pi * t) / 12.66)
						 - ((341.1 / 360) * 2 * pi))
    + c3 * cos (((2 * pi * t) / 12.0) - ((23.8 / 360) * 2 * pi))
    + c4 * cos (((2 * pi * t) / 23.9) - ((199.4 / 360) * 2 * pi))
    + c5 * cos (((2 * pi * t) / 25.82) - ((188.7 / 360) * 2 * pi));
}

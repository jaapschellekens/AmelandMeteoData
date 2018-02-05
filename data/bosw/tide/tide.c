/*Small program to produce a series of point representing the solar
and lunar tides.
Jaap Schellekens
Feb 2 1994

The following formula was extracted from \cite{CHILDERS1993108}:
   \begin{equation}
   n_t = 66.3 cos \left[ \frac{2 \pi t}{12.42} - 352.1^o \right]
   + 13.3 cos \left[ \frac{2 \pi t}{12.66} - 341.1^o \right]
   + 9.2 cos \left[ \frac{2 \pi t}{12.00} - 28.8^o \right]
   + 9.9 cos \left[ \frac{2 \pi t}{23.9} - 199.4^o \right]
   + 7.6 cos \left[ \frac{2 \pi t}{25.82} - 188.7^o \right]
   \end{equation}
   This formula predicts tidel height using lunar and solar components.
 */

#ifdef MSDOS
#include "getopt.c"
#endif

#include <time.h>
#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#define OPTIONS "t:b:o:m:s:h:"
#ifdef MSDOS
#define SYNTAX  "[/b bottom][/t starttime][/h hours][/o filename][/m multiplication][/s sum]" 
#else
#define SYNTAX  "[-b bottom][-t starttime][-h hours][-o filename][-m multiplication][-s sum]" 
#endif
#define ME "J. Schellekens"
#define DATE "2 Feb 1994"

FILE *outputfile;
char outputfilename[80];

#ifndef MSDOS
extern char *optarg;
extern int optint, opterr;
#endif

time_t ttime;
struct tm thetime;
char starttime[80] = "NOTHING";

main (argc, argv)
     int argc;
     char *argv[];
{
  double tidecal ();
  int i, thisopt;
  double sum = 0;
  double mul = 1;
  int hours = 500;
  double toprint, bottomval = 0;

  strcpy (outputfilename, "NOTHING");
  /* First we parse the comand line */
  if (argc == 1)
    {
      showinfo (argc, argv);
    }

  /*First process command line */
  thisopt = getopt (argc, argv, OPTIONS);
  do
    {
      switch (thisopt)
	{
	case 'h':
	  hours = atoi (optarg);
	  break;
	case 'o':
	  strcpy (outputfilename, optarg);
	  break;
	case 't':
	  strcpy (starttime, optarg);
	  break;
	case 'b':
	  bottomval = atof (optarg);
	  break;
	case 'm':
	  mul = atof (optarg);
	  break;
	case 's':
	  sum = atof (optarg);
	  break;
	default:
	  break;
	}
    }
  while ((thisopt = getopt (argc, argv, OPTIONS)) != EOF);


  if (strcmp (outputfilename, "-") == 0 || strcmp (outputfilename, "NOTHING") == 0)
    outputfile = stdout;
  else if ((outputfile = fopen (outputfilename, "w")) == NULL)
    {
      fprintf (stderr, "%s: error opening: %s\n", argv[0], outputfilename);
      exit (1);
    }

  if (strcmp (starttime, "NOTHING") == 0)
    time (&ttime);   /*set local time in sec since 1970 */

  for (i = 1; i <= hours; ++i)
    {
      toprint = sum + mul * (tidecal (i));
      if (toprint < bottomval && bottomval != 0)
	toprint = bottomval;
      fprintf (outputfile, "%lf %lf\n", (double) ttime, (double) toprint);
      ttime += 3600;
    }
}




#define c1 62.3
#define c2 13.3
#define c3 9.2
#define c4 9.9
#define c5 7.6
#define pi 3.14159265

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

showinfo (argc, argv)
     int argc;
     char *argv[];
{
  fprintf (stderr, "%s %s\n", ME, DATE);
  fprintf (stderr, "%s: a program to calculate tides using lunar and solar components.\n", argv[0]);
  fprintf (stderr, "Syntax: %s %s\n", argv[0], SYNTAX);
  exit (1);
}

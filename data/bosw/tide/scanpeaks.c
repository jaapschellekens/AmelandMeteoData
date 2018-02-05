/*
 * setup for a simple program to scan for peaks (semidiurnal tides)
 * in an ascii file consisting of columns
 *
 * The first column must contain the time in one of the folowing formats:
 *
 * -Sec since 1970
 *
 */
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <errno.h>

#define ME "J. Schellekens"
#define DATE "24 Jan 1994"
#define	SYNTAX "[-h][-t min_gap][-c timecol][-f filtersize][-u scancol][-a above][-b below]"
FILE *outputfile;

#ifdef MSDOS
#include "getopt.c"
#endif

#ifndef MSDOS
extern char *optarg;
extern int optint, opterr;

#endif
double onlyabove = -1E20, onlybelow = 1E20;
double mingap = -99999.0;  /*minimun timegap between peaks*/
double	thistime,oldtime;
int peaks, regpeaks, filtersize = 5;
int commentchar = '#';
int timecol=0;

#define	OPTIONS "t:u:b:a:f:hc:"

main (argc, argv)
     int argc;
     char *argv[];
{
  char oneline[500];
  double cols[40], cols1[40], cols2[40], cols3[40], cols4[40];
  int i = 1, nrcols = 0;
  int lines = 0;
  int tt, usethis = 1;
  int thisopt;


  thisopt = getopt (argc, argv, OPTIONS);
  do
    {
      switch (thisopt)
	{
	case 'u':
	  usethis = atoi (optarg);
	  break;
	case 'c':
	  timecol = atoi (optarg);
	  break;
	case 'b':
	  onlybelow = atof (optarg);
	  break;
	case 'a':
	  onlyabove = atof (optarg);
	  break;
	case 'h':
	  showinfo (argc, argv);
	  break;
	case 'f':
	  filtersize = atoi (optarg);
	  break;
	case 't':
	  mingap = atof (optarg);
	  break;
	}
    }
  while ((thisopt = getopt (argc, argv, OPTIONS)) != EOF);

  while (feof (stdin) == 0)
    {
      lines++;
      /*
       * * * read one line of data file
       */
      getline (oneline);
      /*
       * * * set the number of columns
       */
      nrcols = lines == 1 ? detcols (oneline) : nrcols;
      /*
       * * * read the columns from the string
       */
      convline (oneline, cols);

      if (ispeak (cols, cols1, cols2, cols3, cols4, usethis) != 0)
	{
	  oldtime=thistime;
	  thistime=cols2[timecol];
	  if ((thistime-oldtime) >= mingap){
	  for (i = 0; i <= nrcols; i++)
	    fprintf (stdout, "%lf ", cols2[i]);
	  fprintf (stdout, "\n");
	  }
	}

      for (i = 0; i <= nrcols; i++)
	{
	  cols4[i] = cols3[i];
	  cols3[i] = cols2[i];
	  cols2[i] = cols1[i];
	  cols1[i] = cols[i];
	}
    }
}

int 
getline (getthis)
     char getthis[];
{
  fgets (getthis, 500, stdin);
  if (getthis[0] == commentchar)
    while (getthis[0] == commentchar)
      fgets (getthis, 500, stdin);
}


convline (theline, thecols)
     char theline[];
     double thecols[];

{
  sscanf (theline, "%lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf", &thecols[0], &thecols[1], &thecols[2], &thecols[3], &thecols[4], &thecols[5], &thecols[6], &thecols[7], &thecols[8], &thecols[9], &thecols[10], &thecols[11], &thecols[12], &thecols[13], &thecols[14], &thecols[15], &thecols[16], &thecols[17], &thecols[18], &thecols[19], &thecols[20]);
}

int
detcols (theline)
     char theline[];

{
  int tt;
  double dumm;

  tt = sscanf (theline, "%lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf %lf ", &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm, &dumm);

  return (tt - 1);
}

int
ispeak (a, b, c, d, e, i)
     double a[], b[], c[], d[], e[];
     int i;
{
  switch (filtersize)
    {
    case 1:
      if ((c[i] > a[i] && c[i] > e[i]
	  && c[i] > onlyabove && c[i] < onlybelow)) 
	return (1);
      else
	return (0);
    case 5:
      if (c[i] >= b[i] && b[i] > a[i] && c[i] >= d[i] && d[i] > e[i]
	  && c[i] > onlyabove && c[i] < onlybelow) 
	return (1);
      else
	return (0);
    case 3:
      if ((c[i] > b[i] && c[i] > d[i]
	  && c[i] > onlyabove && c[i] < onlybelow))
	return (1);
      else
	return (0);
    }
}

showinfo (argc, argv)
     int argc;
     char *argv[];
{
  fprintf (stderr, "%s %s\n", ME, DATE);
  fprintf (stderr, "%s: A program to scan a file for (tidel) peaks\n", argv[0]);
  fprintf (stderr, "Syntax: %s %s\n", argv[0], SYNTAX);
  exit (1);
}

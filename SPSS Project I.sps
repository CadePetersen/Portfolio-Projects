﻿* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
COMPUTE MPH=(Length) / (Time).
EXECUTE.

COMPUTE Elevation_GPR=(Ascent)/(Length).
EXECUTE.



FREQUENCIES VARIABLES=Elevation Difficulty Ascent Length Time MPH Elevation_GPR
  /FORMAT=NOTABLE
  /STATISTICS=STDDEV RANGE MEAN MEDIAN
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Elevation
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.



FREQUENCIES VARIABLES=Difficulty
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=Ascent
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.



FREQUENCIES VARIABLES=Length
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.



FREQUENCIES VARIABLES=Time
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

FREQUENCIES VARIABLES=MPH
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.



FREQUENCIES VARIABLES=Elevation_GPR
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

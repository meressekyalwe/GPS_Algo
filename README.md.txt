##GPS Ephemeris Project
#Overview
This project aims to calculate the GPS coordinates of a receiver using ephemeris data from GPS satellites. The project includes an Excel database with the ephemeris information and MATLAB scripts to process this data and compute satellite positions.

#Files
database.xlsx: This file contains ephemeris data for various GPS satellites.
satelittes_pos.m: This MATLAB script reads the ephemeris data from database.xlsx and computes the satellite positions.
gps_coordinates.m: This MATLAB script calculates the GPS coordinates using the satellite positions computed in satelittes_pos.m.

Data Description (database.xlsx)
The Excel file contains the following columns:

SAT: Satellite identifier
toe: Time of ephemeris
toc: Time of clock
A(m): Semi-major axis
e: Eccentricity
io(deg): Inclination angle
OMEGA0(deg): Longitude of the ascending node
omega(deg): Argument of perigee
M0(deg): Mean anomaly
deltan(deg): Mean motion difference
OMEGADOT(deg): Rate of right ascension
IDOT(deg): Rate of inclination angle
Cuc(rad): Amplitude of the cosine harmonic correction term to the argument of latitude
Cus(rad): Amplitude of the sine harmonic correction term to the argument of latitude
Crc(m): Amplitude of the cosine harmonic correction term to the orbit radius
Crs(m): Amplitude of the sine harmonic correction term to the orbit radius
Cic(rad): Amplitude of the cosine harmonic correction term to the angle of inclination
Cis(rad): Amplitude of the sine harmonic correction term to the angle of inclination
rho(m): Distance parameter

#How to Use
Place database.xlsx, satelittes_pos.m, and gps_coordinates.m in the same directory.
Open MATLAB and navigate to this directory.
First, run satelittes_pos to compute satellite positions.
Then, run gps_coordinates to calculate the GPS coordinates.


# ARBGEOM-ADCP: A toolbox for the design and operation of monostatic ultrasonic profiling systems of arbitrary geometry with applications to the use of standard Acoustic Doppler Current Profilers (ADCPs) and novel distributed systems including convergent-beam ADCPs

A MATLAB toolbox enabling:  1) Acquisition of 3D velocity from Acoustic Doppler Current Profilers (ADCPs), 2) Acoustic beam and bin mapping, 3) Acoustic beam orientations definition as function of a target focal point. This toolbox applies to monostatic ultrasonic profiling systems of arbitrary geometry (any number of transducer and orientation, convergeant or divergeant configuration). This toolbox aims to facilitate the development and operation of actuated Converging-beam ADCPs and distributed ADCPs. 

### Requirements 
This toolbox is developed in MATLAB R2022b, thus its system requirements are identical to those of MATLAB. Make sure that the toolbox folders and subfolders are in the Matlab path.

### Toolbox description 
The toolbox includes two folders: "Functions" and "Examples". 

#### Functions

- **ConversionBeam2Cartesian.m**: Function that transforms beam velocities into Cartesian components of velocity for every measurement cell along the profile and for every timestamp. 

_U = ConversionBeam2Cartesian(B,T,b)_
   
- **BeamCellMappingCartesian.m**: Function that calculates the centroid of each measurement cells in Cartesian coordinates, in the same reference frame as the beam origins.

_G = BeamCellMappingCartesian(BO,T,NC,CS,BD)_

- **BeamOrientationAnglesDefinition.m:** Function that defines beam orientation angles as function of beam origin and target focal point coordinates in common reference frame and outputs the associated transformation matrix.

_[theta,phi,T] = BeamOrientationAnglesDefinition(BO,FP)_

- **CellBlankingDefinition.m:** Function that defines blanking distances and cell sizes for each acoustic beam, so that at the focal point, the same measurement cell number of each beam intersect at its centroid. Outside the focal point, measurements cells centres are equals on a given plan.

_[CS,BD] = CellBlankingDefinition(BO,FP,CS_in,plan,T)_


   
**Inputs and outputs:**
- B: matrix of shape timestamp x beam x measurement cell that      contains the measured along beam velocities.            
- T:  Transformation matrix. b x 3 matrix, that enables derivation of       Cartesian components of velocity and Acoustic beam and        measurement cell mapping in Cartesian coordinates.
- b: vector containing the beam numbers chosen for the transformation.
- U: matrix of size time x cell x component of velocity which contains  Cartesian components of velocity along the profile.
- BO: Beam origin coordinates. _b_ x 3 matrix containing x y z Cartesian coordinates of each beam origin in meter, where _b_ is the number of beam.
- NC: Integer. Number of measurement cells.     
- CS:     Vector of length b, where b is the number of beam. Contains the calculated cell sizes for each acoustic beam
- BD:     Vector of length b, where b is the number of beam. Contains the calculated blanking distances for each acoustic beam.
- G:  Structure of length b, where b is the number of beam, that contains matrices of size NC x 3, with NC the number of measurement cells,        filled with the Cartesian coordinates of each measurement cell centroid. 
- FP: Focal point coordinates. Vector [x y z] containing the Cartesian
      coordinates of the focal point in meter, in the same reference   frame as beam origin.
- theta:  Azimuth angle. Vector of length _b_ containing the azimuth angle           for each acoustic beam, in radian.
- phi: Polar angle. Vector of length _b_ containing the polar angle for each acoustic beam, in radian.
- CS_in:  Single value. Approximate desired cell size in meter.
- plan:   Plan on which the measurements cells centres are equals for each  Acoustic beam along the profile (1 = zy, 2 = zx, 3 = xy).


#### Examples 

- **Example1\_Define\_CADP.m:** Define beam orientation angles, cell sizes and blanking distances for a fixed 9 beam C-ADP in a circular configuration. 
    
- **Example2\_Define\_Distributed\_ADP.m:** Compute measurement cell centroids in Cartesian coordinates for a set-up of two 4-beam D-ADPs, 5m apart.

- **Example3\_Define\_Actuated\_CADP.m:** Define beam orientation angles, cell sizes and blanking  distances for an _actuated_ 9 beam C-ADP in a circular configuration.

- **Example4\_Cartesian\_Vel\_from\_horizontal\_CADP.m:** Convert velocity acquired with a horizontal C-ADP from along beam velocities to Cartesian component of velocity from example acquired data: "Example\_Beam\_data\_sync.mat".

### Further detail and cite this work 
Further details regarding the mathemaical derivations can be found in: Jourdain de Thieulloy M (2023), Performance assessment of a prototype laboratory-scale Converging Acoustic Doppler Profiler velocimeter under varying geometrical configurations, PhD Dissertation, The University of Edinburgh. <a href="https://google.com">  link TBD </a> 

<a href="https://google.com"> DOI link TBD </a> 

### Licence 
The code is lisenced under GNU General Public License v3.0





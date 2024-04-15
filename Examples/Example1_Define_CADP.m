% created: mjdt 29/07/22
% marilou.jourdain@ed.ac.uk

% Example 1: Define beam orientation angles, cell sizes and blanking 
% distances for a 9 beam C-ADP in a circular configuration

clear 
close all
% ----------------- Fill inputs below -------------------------------------

% Definition of beam origins
BO = [  1.,  0 , 0; ...  % x, y, z beam 1 
        0.7071, 0.7071, 0; ... % x, y, z beam 2 
        0, 1. , 0; ... % x, y, z beam 3 
        -0.7071,    0.7071 , 0; ... 
        -1.,0 ,0;-0.7071, ... 
        -0.7071 , 0 ; ... 
        0 ,  -1.0000, 0; ... 
        0.7071 ,-0.7071, 0;
        0,0,0.5];

% Defintion of focal point position, in the same reference frame as the
% beam origins
FP = [0,1,10]; % x, y, z focal point
% Defition of desired approximate cell size for all beams
CS_in = 1;
% Definition of plane on which the measurements cells centres are equals for 
% each Acoustic beam along the profile (1 = zy, 2 = zx, 3 = xy)
plane = 3; 
% Definition of number of meaurement cells (until max range)
NC = 11; 

% -------------------- Run functions -------------------------------------

% Function that defines beam orientation angles as function of beam origin
% and target focal point coordinates in common reference frame and outputs 
% the associated transformation matrix.
[theta,phi,T] = BeamOrientationAnglesDefinition(BO,FP);

% Function that defines blanking distances and cell sizes for each acoustic
% beam, so that at the focal point, the same measurement cell number of
% each beam interesect at its centroid.
[CS,BD] = CellBlankingDefinition(BO,FP,CS_in,plane,T);

% Function that calculates the centroid of each measurement cells in 
% Cartesian corrdinates, in the same reference frame as the beam origins.
G = BeamCellMappingCartesian(BO,T,NC,CS,BD);


% --------------------- Plot Figure ---------------------------------------

figure
plot3 (BO(:,1),BO(:,2),BO(:,3),'o') % plot each beam origin
hold on
plot3(FP(1),FP(2), FP(3),'o') % plot focal point
for i = 1:length(BO) % for each beam
    % plot measurement cells
    plot3(G(i).xyz(:,1),G(i).xyz(:,2),G(i).xyz(:,3),'+') 
end
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
grid on
axis equal

% created: mjdt 29/07/22
% marilou.jourdain@ed.ac.uk

% Example 4: Convert velocity acquired with a horizontal C-ADP from along 
% beam velocities to Cartesian component of velocity from example acquired
% data "Example_Beam_data_sync.mat". 

clear 
close all

% ----------------- Fill inputs below -------------------------------------
% Definition of beam origins
BO = [  0.01, 0.96, 0.988; ... % x, y, z beam 1 
        0., 0., 0.988; ... % x, y, z beam 2 
        0., -0.96 , 0.988; ... 
        0.,0., 0.248];

% Defintion of focal point position, in the same reference frame as the
% beam origins
FP = [4.421 0.012  0.988]; % x,y,z
% Defition of desired approximate cell size for all beams
CS_in = 0.4;
% Definition of plan on which the measurements cells centres are equals for 
% each Acoustic beam along the profile (1 = zy, 2 = zx, 3 = xy)
plan = 1; 
% Definition of number of meaurement cells (until max range)
NC = 20; 
% Load measured example of measured along-beam velocities
Beam_data = load("Example_Beam_data_sync.mat")
% Acoustic beams to use for the conversion to Cartesian 
b = [1,2,3,4]; 
N = 11; % Measurement cell number for velocity plot

% -------------------- Run functions -------------------------------------
% Function that defines beam orientation angles as function of beam origin
% and target focal point coordinates in common reference frame and outputs 
% the associated transformation matrix.
[theta,phi,T] = BeamOrientationAnglesDefinition(BO,FP);
% Function that defines blanking distances and cell sizes for each acoustic
% beam, so that at the focal point, the same measurement cell number of
% each beam interesect at its centroid.
[CS,BD] = CellBlankingDefinition(BO,FP,CS_in,plan,T);

G = BeamCellMappingCartesian(BO,T,NC,CS,BD);

U = ConversionBeam2Cartesian(Beam_data.vel_beam,T,b);


% ------------------------ plot figures -----------------------------------
% plot measurement cells centres
figure
plot3 (BO(:,1),BO(:,2),BO(:,3),'o')  % plot each beam origin
hold on
plot3(FP(1),FP(2), FP(3),'o') % plot focal point
for i = 1:length(BO)% for each beam
    % plot measurement cells
    plot3(G(i).xyz(:,1),G(i).xyz(:,2),G(i).xyz(:,3),'+')
end
grid on
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
axis equal

% Plot time series of Cartesian components of velocity at cell number N

figure
t = tiledlayout(3,1);
ax_h(1,1) = nexttile;
plot(Beam_data.Tx,U(:,N,1))
ylabel('u (ms\textsuperscript{-1})','interpreter','latex')
grid on 

ax_h(1,2) = nexttile;
plot(Beam_data.Tx,U(:,N,2))
ylabel('v (ms\textsuperscript{-1})','interpreter','latex')
grid on 

ax_h(1,3) = nexttile;
plot(Beam_data.Tx,U(:,N,3))
ylabel('w (ms\textsuperscript{-1})','interpreter','latex')
grid on 

% created: mjdt 22/07/2022
% marilou.jourdain@ed.ac.uk

% Example 2: Compute measurement cell centroids in Cartesian coordinates 
% for a ste-up of two 4-beam D-ADPs, 5m apart.

clear 
close all
% ----------------- Fill inputs below -------------------------------------

% Definition of beam origins
BO =  [ 0.1, 0, 0; ... % x, y, z beam 1, ADP 1 
         0. , 0.1, 0.1; ...  % x, y, z beam 2, ADP 1 
        -0.1, 0,-0.1;...
         0. ,-0.1, 0;...
        5.1 ,0, -0.1; ... % x, y, z beam 1, ADP 2
        5. , 0.1, 0; ... % x, y, z beam 2, ADP 2 
        4.9 , 0., 0.1; ...
        5. , -0.1, -0.1];


theta = [0 pi/2 pi 3*pi/2 0 pi/2 pi 3*pi/2]; % (rad) Azimuth angles
phi = [20 20 20 20 20 20 20 20] *pi/180; % (rad) Polar angles

% Definition of cell sizes and blanking distances
BD = 1*ones(size(BO,1),1); % i.e 1m blanking for all beams
CS = 0.5*ones(size(BO,1),1); % i.e 0.5m cell sizefor all beams
NC = 20; % number of measurement cells
% ------------------ Functions --------------------------------------------

% Initialise transformation matrix
T = zeros(size(BO,1),3);

for i = 1:size(BO,1) % for each beam 
    % Fill transformation matrix
    T(i,:) = [sin(phi(i))*cos(theta(i)) sin(phi(i))*sin(theta(i)) cos(phi(i))];
end

% Function that calculates the centroid of each measurement cells in 
% Cartesian corrdinates, in the same reference frame as the beam origins.
G = BeamCellMappingCartesian(BO,T,NC,CS,BD);

% --------------------- Plot Figure ---------------------------------------

figure
plot3 (BO(:,1),BO(:,2),BO(:,3),'o') % plot each beam origin
hold on
for i = 1:length(BO) % for each beam
    % plot measurement cells
    plot3(G(i).xyz(:,1),G(i).xyz(:,2),G(i).xyz(:,3),'+') 
end
xlabel('x (m)')
ylabel('y (m)')
zlabel('z (m)')
grid on
axis equal
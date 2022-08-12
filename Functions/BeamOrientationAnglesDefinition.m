% created: mjdt 19/01/2020
% modified: mjdt 22/07/2022
% marilou.jourdain@ed.ac.uk

% Function: ------- BeamOrientationAnglesDefinition ----------------------

function [theta,phi,T] = BeamOrientationAnglesDefinition(BO,FP) 

% Function that defines beam orientation angles as function of beam origin
% and target focal point coordinates in common reference frame and outputs 
% the associated transformation matrix.

% inputs: 
% - BO: Beam origin coordinates. b x 3 matrix containg x y z Cartesian 
%       coordinates of each beam origin in meter, where b is the number of 
%       beam.
% - FP: Focal point coordinates. Vector [x y z] containing the Cartesian
%       coordinates of the focal point in meter, in the same reference 
%       frame as beam origin.

% ouputs:  
% - theta:  Azimuth angle. Vector of length b containg the azimuth angle 
%           for each acoustic beam, in radian.
% - phi:    Polar angle. Vector of length b containg the polar angle for
%           each acoustic beam, in radian.
% - T:      Transformation matrix. b x 3 matrix, that enables derivation of 
%           Cartesian components of velocityand Acoustic beam and 
%           measurement cell mapping in Cartesian coordinates.
% -------------------------------------------------------------------------


% Initialise matrix and vectors
T = zeros(length(BO),3); % Matrix of size b x 3
r = zeros(1,length(BO)); % Vector of length b
theta = zeros(1,length(BO)); % Vector of length b
phi = zeros(1,length(BO)); % Vector of length b

dx = FP(1) - BO(:,1); % distance in x 
dy = FP(2) - BO(:,2); % distance in y 
dz = FP(3) - BO(:,3); % distance in z  

for i = 1:length(BO) % for each acoustic beam 
    r(i) = sqrt(dx(i)^2 + dy(i)^2 + dz(i)^2); % range between beam origin 
    % and focal point
    phi(i) = acos(dz(i)/r(i)); % Polar angle phi
    if dx(i)>0
        theta(i) = atan(dy(i)/dx(i)); % Azimuth angle theta
    elseif dx(i)<0
        theta(i) = atan(dy(i)/dx(i)) + pi;
    elseif dx(i) == 0 && dy(i) >=0 
        theta(i) = pi/2;
    else 
        theta(i) = -pi/2;
    end
    % Fill transformation matrix
    T(i,:) = [sin(phi(i))*cos(theta(i)) sin(phi(i))*sin(theta(i)) cos(phi(i))];
end
end 

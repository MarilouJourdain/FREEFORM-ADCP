% created: mjdt 19/01/2020
% modified: mjdt 22/07/2022
% marilou.jourdain@ed.ac.uk

% Function: ------- CellBlankingDefintion ---------------------------------

function [CS,BD] = CellBlankingDefinition(BO,FP,CS_in,plane,T) 
% Function that defines blanking distances and cell sizes for each acoustic
% beam, so that at the focal point, the same measurement cell number of
% each beam intersect at its centroid. Outside the focal point,
% measurements cells centres are equals on a given plane. 

% inputs: 
% - BO:     Beam origin coordinates. b x 3 matrix containg x y z Cartesian 
%           coordinates of each beam origin in meter, where b is the number
%           of beam.
% - FP:     Focal point coordinates. Vector [x y z] containing the Cartesian
%           coordinates of the focal point in meter, in the same reference 
%           frame as beam origin.
% - CS_in:  Single value. Approx. desired cell size in meter (m).
% - plane:   Plane on which the measurements cells centres are equals for each
%           Acoustic beam along the profile (1 = zy, 2 = zx, 3 = xy)
% - T :     Transformation matrix

% Outputs:
% - CS:     Vector of length b, where b is the number of beam. Contains the 
%           calculated cell sizes for each acoustic beam
% - BD:     Vector of length b, where b is the number of beam. Contains the 
%           calculated blanking distances for each acoustic beam


% Initialise matrix and vectors
r = zeros(1,length(BO)); % Vector of length b
BD = zeros(1,length(BO));
d = zeros(3,length(BO));

for j = 1:3 % for each 3 dimension
    d(j,:) = FP(j) - BO(:,j); % distance in x, y and z  
end 

for i = 1:length(BO) % for each acoustic beam
    % Calculate range between beam origin and focal point coordinates
    r(i) = sqrt(d(1,i)^2 + d(2,i)^2 + d(3,i)^2); 
    % Adjust blanking distance BD, so that all cells are at the same plane
    plane_diff(i) = max(BO(:,plane)) - BO(i,plane);
    BD(i) = plane_diff(i)*T(i,plane);
end
% Number of measurement cells from origin to focal point 
NS = floor(min(d(plane,:))/CS_in); 
CS = (r-BD)/NS; % Calculate cell size for each acoustic beam
% Blanking distance = adjusted blanking distance + 1 measurement cells
BD = BD + CS; 
end

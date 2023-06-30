% created: mjdt 19/01/2020
% modified: mjdt 22/07/2022
% marilou.jourdain@ed.ac.uk

% Function: ------- BeamCellMAppingCartesian------------------------------
% 
function G = BeamCellMappingCartesian(BO,T,NC,CS,BD)

% Function that calculates the centroid of each measurement cells in 
% Cartesian coordinates, in the same reference frame as the beam origins.

% Inputs: 
% - BO: Beam origin coordinates. b x 3 matrix containg x y z Cartesian 
%       coordinates of each beam origin in meter, where b is the number of 
%       beam.
% - T:  Transformation matrix. b x 3 matrix, that enables derivation of 
%       Cartesian components of velocityand Acoustic beam and 
%       measurement cell mapping in Cartesian coordinates.
% - NC: Number of measurement cells. NC is an integer.
% - CS: Vector of length b, where b is the number of beam. Contains the 
%       calculated cell sizes for each acoustic beam
% - BD: Vector of length b, where b is the number of beam. Contains the 
%       calculated blanking distances for each acoustic beam

% Output: 
% - G:  Structure of length b, where b is the number of beam, that contains
%       matrices of size NC x 3, with NC the number of measurement cells, 
%       filled with the Cartesian coordinates of each measurement cell
%       centroid. 

% Initilisation 
Gr = zeros(length(BO),NC); % relative distance between centroid of 
% measurement cell and beam origin
G(length(BO),1) = struct; % Structure of length number of acoustic beams 
% containing measurement cell centroid in Cartesian frame

nC = 1:NC; % create a vector 1 to number of cells

for i = 1:length(BO) % for each acoustic beam 
    % relative distance between centroid of measurement cell and beam
    % origin
    Gr(i,:) = BD(i) + CS(i)*nC; 
    % Structure of length number of beams that contains the Cartesian 
    % coordinates of the centroid of each measurement cell 
    G(i).xyz = Gr(i,:)'.*T(i,:)+BO(i,:);
end
end 

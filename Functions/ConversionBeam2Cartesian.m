% created: mjdt 19/01/2020
% modified: mjdt 22/07/2022
% marilou.jourdain@ed.ac.uk

% Function: ------- ConversionBeam2Cartesian------------------------------
% 
% Function that transforms beam velocities into Cartesian components of
% velocity for every measurement cell along the profile and for every
% timestamp

% inputs: 
% - B : matrix of shape timestamp x beam x measurement cell that
%       contains the measured along beam velocities
% - T:  Transformation matrix. b x 3 matrix, that enables derivation of 
%       Cartesian components of velocityand Acoustic beam and 
%       measurement cell mapping in Cartesian coordinates.
% - b : vector containing the beam numbers chosen for the transformation

% output:
% - U : matrix of size time x cell x component of velocity wich contains 
%       Cartesian components of velocity along the profile


function U = ConversionBeam2Cartesian(B,T,b)

% intialisation of matrices
% matrix of size time x cell x component of velocity
U = zeros(size(B,1),size(B,3),3);

for t = 1 : size(B,1) % for every timestamp
    for c = 1:size(B,3) % for each measurement cell
        % Conversion from along beam velocities to Cartesian
        % Assume flow homogeneity when mesurement cells are not colocated
        U(t,c,:) =  pinv(T(b,:))*B(t,:,c)';
    end
end
end

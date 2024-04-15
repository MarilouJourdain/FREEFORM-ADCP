% created: mjdt 29/07/22
% marilou.jourdain@ed.ac.uk

% Example 3: Define beam orientation angles, cell sizes and blanking 
% distances for an actuated 9 beam C-ADP in a circular configuration

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
        0,0,0];
% Defintion of focal point positions, in the same reference frame as the
% beam origins. Possibility to add as many focal points as possible in the
% shape [x1, y1, z1; x2, y2, z2, ...]
FP = [0 0 10; 0 0 5; 2 -1 6; -1 -1 10; 4 4 10; 0 0 10; 0 0 5; 1 1 12; 3 -1 13]; % (m) % x, y, z focal point
% Defition of desired approximate cell size for all beams
CS_in = 1;
% Definition of plane on which the measurements cells centres are equals for 
% each Acoustic beam along the profile (1 = zy, 2 = zx, 3 = xy)
plane = 3; 
% Definition of number of meaurement cells (until max range)
NC = 20; 

% -------------------- Run functions -------------------------------------

for i = 1:length(FP) % for each focal points
% Function that defines beam orientation angles as function of beam origin
% and target focal point coordinates in common reference frame and outputs 
% the associated transformation matrix.
[FPb(i).theta,FPb(i).phi,FPb(i).T] = BeamOrientationAnglesDefinition(BO,FP(i,:));

% Function that defines blanking distances and cell sizes for each acoustic
% beam, so that at the focal point, the same measurement cell number of
% each beam interesect at its centroid.
[FPb(i).CS,FPb(i).BD] = CellBlankingDefinition(BO,FP(i,:),CS_in,plane,FPb(i).T);

% Function that calculates the centroid of each measurement cells in 
% Cartesian corrdinates, in the same reference frame as the beam origins.
FPb(i).G = BeamCellMappingCartesian(BO,FPb(i).T,NC,FPb(i).CS,FPb(i).BD);
end

% ------------------------ Figures ----------------------------------------

figure  % C-ADP scanning video 
for i = 1:length(FP) % for each focal point
    plot3 (BO(:,1),BO(:,2),BO(:,3),'o')% plot each beam origin
    hold on
    plot3(FP(i,1),FP(i,2), FP(i,3),'o') % plot focal point 
    for ii = 1:length(BO)% for each beam
    % plot measurement cells
        plot3(FPb(i).G(ii).xyz(:,1),FPb(i).G(ii).xyz(:,2),FPb(i).G(ii).xyz(:,3),'+') 
    end
    hold off
    xlabel('x (m)')
    ylabel('y (m)')
    zlabel('z (m)')
    grid on 
    axis([-5 5 -10 10 0 20]);
    FF(i) = getframe(gcf) ;
    drawnow
    pause(1);
end
writerObj = VideoWriter('Actuated_CADP.avi');  
writerObj.FrameRate = 1;   
% open the video writer
open(writerObj);
% write the frames to the video
for i=1:length(FF)
    % convert the image to a frame
    frame = FF(i).cdata ;    
    writeVideo(writerObj, frame);
end
% close the writer object
close(writerObj);

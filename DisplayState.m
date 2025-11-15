function DisplayState (fireGrid, drones, step)
%DisplayState: visualizes the fire grid and drone positions

%Inputs: 
% fireGrid : 2D matrix of fire intensities 
% drones: matrix of drone positions 
% step: current simulation step
% 
% Outputs: 
% - a drawing od heatmap of fire intensity, drones as red markers, and labels for drone 


imagesc(fireGrid);
hold on; 
for i = 1:length (drones)
    pos = drones(i).DronePosition;
    plot(pos(2), pos(1), 'bo','MarkerFaceColor', 'b');
end
hold off;
title(sprintf('Step%d | Fires Left. %d', step, sum(fireGrid(:)>0)));

colormap ([ 1 1 1; 1 0 0]); % white = safe, red = fire
axis equal tight;
drawnow;
end 
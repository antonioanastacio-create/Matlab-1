function [fire] = init_fire(params)
%init_fire: creates the initial 2D matrix of fire intensities

%Inputs: 
%   params: structure with the following fields
%   InitFireCells: list of ignition points 
%   InitIntensity: initial fire strength 
% 
% Outputs:
%     fire: 2D matrix of the initial fire intensities 

% Create grid size and fire grid
[rows, cols] = deal(params.GridSize(1), params.GridSize(2));

fire = zeros(rows, cols);

%Set the initial fire intensities 
if isfield(params, 'InitIntensity')
        initIntensity = params.InitIntensity;
    else
        initIntensity = 1; % full strength fire
    end



end
% 
   if isfield(params, 'InitFireCells') && ~isempty(params.InitFireCells)
        ignitions = params.InitFireCells;
    else
        % Default: single ignition in the center
        ignitions = round([rows/2, cols/2]);
   end

   % === Set ignition points ===
    for k = 1:size(ignitions, 1)
        r = ignitions(k,1);
        c = ignitions(k,2);

        % Make sure the point is inside the grid
        if r >= 1 && r <= rows && c >= 1 && c <= cols
            fire(r,c) = initIntensity;
        end
    end
    end


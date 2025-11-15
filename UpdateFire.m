function Fire = FireIntensity (fire, params)
%FireIntensity: Update fire intensity grid using the decay and spread of
%the fires 

% Inputs:

% fire : 2D grid of fire intensity values, including size and duration

% Params: structure that contains the following:
% TimeStep: time step for each update
% MaxSteps: iterations to simulate 
% DecayRate: rate at which fire intensity decays
% SpreadRate: rate at which fire spreads to neighboring cells
% GridSize: size of grid [rows, cols]
% NumDrones: number of drones 

% Outputs: 
% Fire: updated fire grid 


% Extract parameters
    dt = params.TimeStep;
    decay = params.DecayRate;
    spread = params.SpreadRate;
    [rows, cols] = deal(params.GridSize(1), params.GridSize(2));


    
% Copy fire grid to avoid overwriting 
Fire = fire;

% Define extnguishing threshold
threshold = 1e-3;


    newFire = fire; % new grid for updates

    for i = 1:rows
            for j = 1:cols
                oldIntensity = fire(i,j);

                 newIntensity = oldIntensity * exp(-decay * dt);

                  if newIntensity < threshold
                    newIntensity = 0;
                  end
             newFire(i,j) = newIntensity;
            end
    end

    for i = 1:rows
       for j = 1:cols
        if fire(i,j) > threshold  % Only spread from active fire cells
                    spreadAmount = fire(i,j) * spread * dt;

% Define the N, S, E, W bounds th fires will spread to
        if i > 1, newFire(i-1,j) = newFire(i-1,j) + spreadAmount; end
        if i < rows, newFire(i+1,j) = newFire(i+1,j) + spreadAmount; end
        if j > 1, newFire(i,j-1) = newFire(i,j-1) + spreadAmount; end
        if j < cols, newFire(i,j+1) = newFire(i,j+1) + spreadAmount; end
        end
    end

    end 

% Clamping intensities between [0,1] in order to ensure stability
newFire = max(0, min(1, newFire));


fire = newFire;
    
end



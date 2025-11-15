function [params] = make_params()
%make_params: build parameter structure for the fire simulation

%  Returns a struct with all simulation settings needed for other functions
%  to run. This will allow easy re-use of these settings an ensured
%  consistency throughout the simulation 

% Outputs:
% params: structure containing all key simulation parameters 


% --- Time and simulation control ---
    params.TimeStep   = 0.1;   % time step for each iteration
    params.MaxSteps   = 1;     % number of time steps to simulate

     % --- Fire dynamics ---
    params.DecayRate  = 0.05;  % rate at which fire intensity decays
    params.SpreadRate = 0.01;  % rate of spread to neighboring cells

    % --- Grid setup ---
    params.GridSize   = [20, 30];  % [rows, cols]

    % --- Drones (for future expansion) ---
    params.NumDrones  = 5;     % number of drones (not used yet)

    % --- Fire initialization options ---
    params.InitFireCells = [10, 15];  % ignition point(s)
    params.InitIntensity = 1;         % starting intensity (0–1)

       % --- Visualization options (optional) ---
    params.ShowPlots = true;  % whether to visualize during simulation
end 


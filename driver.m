function driver()

% This script initializes all simulation parameters, creates the fire grid,
% places the drones, and runs the simulation loop. 


params.TimeStep   = 0.1;        % seconds per step
    params.MaxSteps   = 1;          % number of simulation steps
    params.DecayRate  = 0.05;       % rate at which fire intensity decays
    params.SpreadRate = 0.01;       % rate of fire spreading to neighbors
    params.GridSize   = [20, 30];   % [rows, cols]
    params.NumDrones  = 5;          % number of drones
    params.PlotEvery  = 1;          % plot every N steps
   %% --- Initialization ---
    % Fire intensity map (0 = no fire, higher = stronger fire)
    FireIntensity = zeros(params.GridSize);

    % Start one initial fire near the center
    center = round(params.GridSize / 2);
    FireIntensity (center(1), center(2)) = 1.0;

    % Initialize drone positions randomly
    dronePositions = [randi(params.GridSize(2), params.NumDrones, 1), ...
                      randi(params.GridSize(1), params.NumDrones, 1)];

    % Create drone labels
    droneLabels = arrayfun(@(i) sprintf('Drone %d', i), ...
                           1:params.NumDrones, 'UniformOutput', false);

    %% --- Simulation Loop ---
    figure('Name', 'Fire-Drone Simulation', 'NumberTitle', 'off');
    for step = 1:params.MaxSteps
        fprintf('Step %d / %d\n', step, params.MaxSteps);

        % --- Update fire state ---
        FireIntensity  = UpdateFire(FireIntensity , params);

        % --- Update drone positions ---
        dronePositions = UpdateDrones(dronePositions, FireIntensity , params);

        % --- Visualization ---
        if mod(step, params.PlotEvery) == 0
            clf;
            plot_state(FireIntensity , dronePositions, droneLabels);
            title(sprintf('Step %d', step));
            drawnow;
        end

        pause(params.TimeStep);
    end

    disp('Simulation complete.');
end

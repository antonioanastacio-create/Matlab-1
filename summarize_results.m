function summarize_results(firegrid, drones, params, filename)
%summarize_results creates a summary of the final simulation, exports a
%result table to CSV, and saves key variables to a MAT file

%Inputs: 
%fireGrid: final fire intensity matrix
% drones:finaldrone positions
% params: struct of simulation parameters
% filename: base name for saving results 

%outputs: 
% creates a filename.csv (summary table)
% filename.mat (raw data)


 if nargin < 4
        filename = 'results';
 end

 % Create summary table 

 numDrones = size (drones, 1);

 %summary metrics
 totalFire = sum(fireGrid(:));
 maxFire = max (fireGrid(:));
 avgFire = mean(fireGrid(:));

 %drone table

 droneTable = table(...
     (1:numDrones)', drones(:,1), drones(:,2),...
     'VariableNames', {'DroneID', 'X_position', 'Y_position'});

 fireStats = table (...
     totalFire, MaxFire, avgFire,...
      'VariableNames', {'TotalFire', 'MaxFire', 'AverageFire'});

    paramNames  = fieldnames(params); 
    paramValues = struct2cell(params);
    paramTable  = table(paramNames, paramValues, ...
                        'VariableNames', {'Parameter', 'Value'})
 
 % Write CSV File 
   % Save drone data

writetable(droneTable, [filename '_drones.csv']);
% Save fire stats
writetable(fireStats, [filename '_fire.csv']);
% Save parameters
writetable(paramTable, [filename '_params.csv']);

    %Save MAT File
    save([filename '.mat'], 'fireGrid', 'drones', 'params');

   fprintf('Summary results saved to:\n');
   fprintf('  %s_drones.csv\n', filename);
   fprintf('  %s_fire.csv\n', filename);
   fprintf('  %s_params.csv\n', filename);
   fprintf('  %s.mat\n', filename);
end 
%drone function with structure of initial drone params
%
%
%Input: Paramss- structure which contain 
%               .Numdrones - number of drones 
%               .GridSize - [rows, cols] of the simulation grid
%Output: drones - array of drones structure containing 
%                DroneId  [1-5]
%                DronePostition [rows,cols] starting position
%                DroneTarget  [rows, cols] initial target - at random
%                DroneState  searching, moving, extingushing
%                DroneWater - initial water amount pof 30 gallons
function drones = InitDrones(params)
    NumDrones = params.NumDrones;
    drones = struct('DroneId',{},'DronePostion',{},'DroneTarget',{},'DroneState',{},'DroneWater',{});

for i = 1:NumDrones
    drones(i).DroneId = i;
    drones(i).DronePosition = [randi(params.GridSize(1)), randi(params.GridSize(2))];
    drones(i).DroneTarget = [randi(params.GridSize(1)), randi(params.GridSize(2))];
    drones(i).DroneState = 'searching'; 
    drones(i).DroneWater = 30; 
end

end


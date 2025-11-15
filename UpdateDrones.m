%Updated drones postion, state, target and action of drones in simulation
%
%
% Inputs-
% drones-  array of drones structure
%          .DronePostition [rows,cols] 1x2
%          .DroneTarget  [rows, cols] 1x2 taget location or empty
%          .DroneState  searching, moving, extingushing
%          .DroneWater - remaining water
%
%fireGrid - the fire intensity in (x,y) > 0
%
% Outputs -
% drones - updated drone structure after moving/extinguishing
% fireGrid - updated fire grid with extinguished cell set to 0
function [drones, fireGrid] = UpdateDrones(drones, fireGrid, ~)
 for i = 1:length(drones)
        drone = drones(i);
 switch drones.DroneState

     case 'searching'
     % find coordinates of all fires
   [fx, fy] = find(fireGrid > 0);
   if ~isempty(fx)
       %find nearest fire for drone
   [~,idx] = min(vencnorm([fx,fy]- drone.DronePostion,2,2));
    drone.DroneTarget = [fx(idx), fy(idx)];
    drone.State = 'moving';
   end
     
   %Move on step towards target
     case 'moving' 
         direction = sign(drone.DroneTarget - drone.DronePostion);
        proposedPos = drone.DronePostion + direction;

        %Proposed move (collision test later)
        drone.NextPostion = drone.proposedPos;

         % if arrived, switch to extinguishing 
         if isequal(drone.Position, drone.Target)
             drone.DroneStte = 'extinguishing';
         end     
     case 'extinguishing'
        drone.NextPosistion = drone.DronePosistion;
 end
 drones(i) = drone;
 end
end

%collision avoidance (if blocked stay)
for i = 1:length(drones)
    drone = drones(1);
    proposed = drone.NextPosition;
    oringinal = drone.DronePostion;
    blocked = false;

    for j = 1:length(drones)
        if i == j, continue; 
        end
        other = drones(j).DronePosition;
        otherNext = drone(j).NextPosition;
        
        %rule one
        if isequal(other, proposed)
            blocked = true;
            break;
        end

        %rule two
        if isequal(otherNext, proposed)
            blocked = true;
            break;
        end
    end

    %resolve collision: drone stays
    if blocked
        drone.DronesPosition = original;
    else
        drone.DronePosistion = proposed;
    end
    drones(i) = drone;
end

% action after movement (extinguished fires)
for i = 1:length(drones)
    drone = drones(i);

    switch drone.DroneState
        case 'moving'
            if isequal(drone.DronePosition, drone.DroneTarget)
                drone.DroneState = 'extinguished';
            end
        case 'extinguished'
            x = drone.DronePosition(1);
            y = drone.DronePosistion(2);

            if fireGrid(x,y) > 0 && drone.DroneWater > 0
                fireGrid(x,y) = 0;
                drone.DroneWater = droneDronewater - 5;
            end

            %after extinguishing
            drone.DroneState = 'searching';
    end
    drones(i) = drone;
end 





function[newstate, reward] = SimulateRobot(state,action)
    rew = zeros(16,4);
    %Assign reward to forward movements only
    rew(3,1) = 1;
    rew(9,3) = 1;
    rew(1,2)  = 1;
    rew(13,4) = 1;
    %Penalize impossible actions

    rew(2,3) = -1;
    rew(2,1) = -1;
    rew(3,3) = -1;
    rew(5,1) = -1;
    rew(5,3) = -1;
    rew(8,1) = -1;
    rew(8,3) = -1;
    %rew(8,2) = -1;
    rew(9,1) = -1;
    rew(12,1) = -1;
    %rew(12,2) = -1;
    rew(12,3) = -1;
    rew(14,1) = -1;
    %rew(14,4) = -1;
    rew(14,3) = -1;
    rew(15,1) = -1;
    %rew(15,4) = -1;
    rew(15,2) = -1;
    rew(4,2) = -1;
    rew(4,1) = -1;
    rew(4,4) = -1;
    rew(13,4) = -1;
    rew(13,3) = -1;
    rew(13,2) = -1;

    %2)Initialize state transition
    del = [2, 4, 5, 13;1, 3, 6, 14;4, 2, 7, 15;3, 1, 8, 16;6, 8, 1, 9;5, 7, 2, 10;8, 6, 3, 11;7, 5, 4, 12;10, 12, 13, 5;9, 11, 14, 6;12, 10, 15, 7;11, 9, 16, 8;14, 6, 9, 1;13, 15, 10, 2;16, 14, 11, 3;15, 13, 12, 4];

    newstate = del(state,action);
    reward = rew(state,action);
end

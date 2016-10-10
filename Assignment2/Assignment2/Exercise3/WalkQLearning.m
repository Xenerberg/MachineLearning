function [] = WalkQLearning(state,rew,del)
    %Implement epsilon greedy
    initState = state;
    epsilon = 0.5;
    Q = zeros(16,4);
    alpha = 0.8;
    gamma = 0.5;
    itCounter = 0;
    while(1)
        itCounter = itCounter + 1;
        temp = rand(1);
        action = 0;
        if epsilon <= temp
           %Invoke random action (exploration)
           action = abs(randi(4));

        else
           %Invoke optimal action (exploitation)
           [~,action] = max(Q(state,:));

        end
        [newState,reward] = SimulateRobot(state,action);
        est_newRew = max(Q(newState,:));
        Q(state,action) = Q(state,action) + alpha*(reward + gamma*est_newRew - Q(state,action));
        state = newState;
        if itCounter == 400
            break;            
        end
    end
    stateSeq = zeros(16,1);
    stateSeq(1) = initState;
    for iCount = 2:16
        [~,action] = max(Q(stateSeq(iCount-1),:));
        [stateSeq(iCount), ~] = SimulateRobot(stateSeq(iCount-1), action);
    end
    walkshow(stateSeq');
end
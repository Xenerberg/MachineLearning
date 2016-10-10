%Script_03 for Reinforcement learning
clc;close all;
%Initialize parameters
gamma = 0.1;
%1) Define reinforcement matrix
%16 states
%4 actions possible for each state
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
rew(8,2) = -1;
rew(9,1) = -1;
rew(12,1) = -1;
%rew(12,2) = -1;
rew(12,3) = -1;
rew(14,3) = -1;
rew(14,4) = -1;
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


%3) Initialize policy randomly 
policy = ceil(rand(16,1)*4);
Value = zeros(16,1);
itCounter = 0;
%4) Policy iteration to converge
while (1)
   A = eye(16,16);
   reward = zeros(16,1);
   delta_v = 0;
   temp = Value;
   itCounter = itCounter + 1;
   valueTh = 1e-5;
   value_vec = [];
   %Policy evaluation
   for stateCount = 1:16
      
      policyAction = policy(stateCount);
      reward(stateCount) = rew(stateCount,policyAction);
      next_State = del(stateCount,policy(stateCount));
      A(stateCount,next_State) = -gamma;
   end
   Value = A\reward;
   value_vec(itCounter) = norm(Value);
   delta_v = max(delta_v,norm(temp - Value));
   
   if delta_v < valueTh
      %break; 
   end
   %Policy improvement
   temp = policy;
   for stateCount = 1:16      
      possibleStates = del(stateCount,:);
      [maxV,idx] = max(rew(stateCount,:) + gamma*Value(possibleStates)');
      policy(stateCount) = idx;
   end
   if isequal(temp,policy)
       break;
   end
end

fprintf('Policy stable after %d iterations.\n', itCounter);
initState = 10;
stateSeq = zeros(16,1);
stateSeq(1) = initState;
for iCount = 2:16
   stateSeq(iCount) = del(stateSeq(iCount-1),policy(stateSeq(iCount-1)));
end

walkshow(stateSeq');

%Forward algorithm
%Computes: the likelihood of an Observation Sequence (o_1, o_2,...o_t)
%Given: Transition Probabilities (A), Emission Probabilities (B), Initial
%Probabilities of State (pi) and the Observation Sequence 

function [prob] = fn_ForwardAlgorithm(A,B,pi,ObsSeq)
    %initialize the forward parameter (alpha)
    %Forward parameter (alpha) will be a vector of size N (number of
    %states)
    O_1 = ObsSeq(1);
    nSeq = length(ObsSeq);%Length of observation sequence
    n_q = size(A,1);%number of labeled states
    n_o = size(B,1);%number of labeled observations
    b = B(O_1,:);
    alpha = zeros(n_q,nSeq);
    alpha =   (pi.*b)';
    %Run the recursion from 2 till end
    for iCount = 2:nSeq
       for iCount_1 =  1:n_q
           temp = 0;
           for iCount_2 = 1:n_q
               temp = temp + alpha(iCount_2,iCount-1)'.*A(iCount_2,iCount_1)';
           end
           alpha(iCount_1,iCount) = temp*B(ObsSeq(iCount),iCount_1);
       end
    end
    %termination
    prob = sum(alpha(:,end));
    
end
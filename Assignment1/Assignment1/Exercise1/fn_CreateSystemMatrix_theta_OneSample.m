function [ A_theta ] = fn_CreateSystemMatrix_theta_OneSample( input_data,p2 )
%fn_CreateSystemMatrix - Create the system matrix
%input: input vector of v and omega
%p2: maximum exponent of angular position
%A: returned Matrix
    A_theta = zeros(1,1+3*p2);
    A_theta(:,1) = 1;
    for iCount = 1:3:length(A_theta)-1       
        exp_system = (iCount+2)/3;
        A_theta(:,iCount+1) = input_data(1,:)^exp_system;
        A_theta(:,iCount+2) = input_data(2,:)^exp_system;
        A_theta(:,iCount+3) = (input_data(1,:)^exp_system)*(input_data(2,:)^exp_system);
    end

end


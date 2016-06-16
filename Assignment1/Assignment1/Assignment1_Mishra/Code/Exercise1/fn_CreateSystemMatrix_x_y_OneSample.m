function [ A_x_y ] = fn_CreateSystemMatrix_x_y_OneSample( input_data,p1 )
%fn_CreateSystemMatrix - Create the system matrix
%input: input vector of v and omega
%p1: maximum exponent of position
%A_x_y: returned Matrix
    A_x_y = zeros(1,1+3*p1);
    A_x_y(:,1) = 1;
    for iCount = 1:3:length(A_x_y)-1       
        exp_system = (iCount+2)/3;
        A_x_y(:,iCount+1) = input_data(1,:)^exp_system;
        A_x_y(:,iCount+2) = input_data(2,:)^exp_system;
        A_x_y(:,iCount+3) = (input_data(1,:)^exp_system)*(input_data(2,:)^exp_system);
    end

end


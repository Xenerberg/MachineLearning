function [A_theta] = fn_CreateSystemMatrix_theta(input,p2,range)
    A_theta = zeros(length(input),1+3*p2);
    for iCount = range(1):range(2)
       A_theta_OneSample = fn_CreateSystemMatrix_x_y_OneSample(input(:,iCount),p2);
       A_theta(iCount,:) = A_theta_OneSample;
    end
end

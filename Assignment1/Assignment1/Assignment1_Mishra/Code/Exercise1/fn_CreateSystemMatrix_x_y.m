function [A_x_y] = fn_CreateSystemMatrix_x_y(input,p1,range)
    A_x_y = zeros(length(input),1+3*p1);
    for iCount = range(1):range(2)
       A_x_y_OneSample = fn_CreateSystemMatrix_x_y_OneSample(input(:,iCount),p1);
       A_x_y(iCount,:) = A_x_y_OneSample;
    end
end

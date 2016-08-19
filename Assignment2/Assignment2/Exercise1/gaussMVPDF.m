%For 1 data point, the function returns the Likelihood
%For multiple data points (i.i.d), the function returns the total likelihood
function [prob] = gaussMVPDF(Data, Mu, Sigma)
    [nDim,nObs] = size(Data);
    Dev = Data - repmat(Mu',[1,size(Data,2)]);
    SumMh = 0;
    for iCount = 1:nObs
        MhDistSq(iCount) = Dev(:,iCount)'*inv(Sigma)*Dev(:,iCount);
    end
    prob = (1/sqrt((2*pi)^nDim * (abs(det(Sigma)) + realmin)))*exp(-MhDistSq/2);
    

end


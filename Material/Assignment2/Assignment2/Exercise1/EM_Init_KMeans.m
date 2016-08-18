function [Priors,Mu,Sigma,idx] = EM_Init_KMeans(Data,numberOfGaussians)
    %nDim:No of dimensions in data
    %nObs:No of Observation points in data
    [nDim,nObs] = size(Data);
    opts = statset('Display','final');
    [idx, C] = kmeans(Data', numberOfGaussians,'Replicates',5,'Options',opts);
    Mu = C;
    for iCount = 1:numberOfGaussians
       index_i = find(idx==iCount);
       Priors(iCount) = length(index_i);
       Sigma(:,:,iCount) = cov(Data(:,index_i)');
       %Add tiny variance for numeric stability
       Sigma(:,:,iCount) = Sigma(:,:,iCount) + 1e-6.*eye(nDim);
    end
    Priors = Priors./sum(Priors);
end
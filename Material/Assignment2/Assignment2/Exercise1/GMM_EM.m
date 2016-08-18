function [ Priors, Mu, Sigma ] = GMM_EM(Data, Mu_0,Sigma_0,Priors_0, numberOfGaussians)
    [nDim,nObs] = size(Data);
    count = 0;
    l_threshold = 1e-10;
    l_old = realmin;
    Mu = Mu_0;
    Sigma = Sigma_0;
    Priors = Priors_0;
    while 1
        %E-step, evaluate the responsibilities   
        
        for iCount = 1:numberOfGaussians
           p_x_i(:,iCount) = gaussMVPDF(Data,Mu(iCount,:),Sigma(:,:,iCount));              
        end    
        for iCount = 1:nObs
           p_i_x(:,iCount) = p_x_i(iCount,:).*Priors./sum(p_x_i(iCount,:).*Priors); 
        end

        %M-step, re-estimate the parameters
        sumSqD = 0;
        for iCount = 1:numberOfGaussians
           %Update the priors
           Priors(iCount) =  sum(p_i_x(iCount,:))/nObs;
           %Update the centers (mean)
           Mu(iCount,:) = (1/sum(p_i_x(iCount,:))).*p_i_x(iCount,:)*Data';
           %Update the Variances (Sigma)
           sumSqD = zeros(2,2);
%            for iCount_1 = 1:nObs
%                 mean_dev = Data(:,iCount) - Mu(iCount,:)';
%                 var = p_i_x(iCount,iCount_1).*mean_dev*mean_dev';
%                 sumSqD = sumSqD + var;
%            end
%            Sigma(:,:,iCount) = sumSqD./sum(p_i_x(iCount,:));
%            Sigma(:,:,iCount) = Sigma(:,:,iCount) + 1e-6*eye(2,2);\
           Data_tmp1 = Data - repmat(Mu(iCount,:)',1,nObs);
           Sigma(:,:,iCount) = (repmat(p_i_x(iCount,:),nDim, 1) .* Data_tmp1*Data_tmp1') / sum(p_i_x(iCount,:));
        end
        %Check for convergence
        p_i_x = [];
        for iCount = 1:numberOfGaussians
           p_i_x(iCount,:) = gaussMVPDF(Data,Mu(iCount,:),Sigma(:,:,iCount));
        end
        %Compute log-likelihood
        L = p_i_x' * Priors';
        L(find(L<realmin)) = realmin;
        l = mean(log(L));
        if abs((l/l_old) - 1) < l_threshold
            break;
        end
        l_old = l;
        count = count + 1;
    end
    fprintf('EM ended with %d iterations\n',count);

end


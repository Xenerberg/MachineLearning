%Script to learn the GMM parameters for GMR (Gaussian Mixture Regression)
%of available 2-D data which represents the PCA of 3-D gestures without
%temporal component
close all;clear all; clc;
%Declare constants
const_numberOfGaussians = 4;
%Open the data
figure;
subplot(2,2,1);
GMMData = load('dataGMM.mat');
scatter(GMMData.Data(1,1:100),GMMData.Data(2,1:100));hold all;
scatter(GMMData.Data(1,101:200),GMMData.Data(2,101:200));
scatter(GMMData.Data(1,201:300),GMMData.Data(2,201:300));
xlabel('x-direction');
ylabel('y-direction');
title('Data for GMR');
legend('trial-1','trial-2','trial-3');

%Initialize using K-means the GMM-model
[Priors_0, Mu_0, Sigma_0, idx] = EM_Init_KMeans(GMMData.Data,const_numberOfGaussians);
subplot(2,2,2);
for iCount=1:const_numberOfGaussians
    scatter(GMMData.Data(1,idx==iCount),GMMData.Data(2,idx==iCount));hold all;    
end
ax = gca;
ax.ColorOrderIndex = 1; 
for iCount=1:const_numberOfGaussians
    scatter(Mu_0(iCount,1),Mu_0(iCount,2),50,'filled','marker','d'); 
end
xlabel('x-direction');
ylabel('y-direction');
title('Initialized (k-means) for GMM');


legend('Cluster-1','Cluster-2','Cluster-3','Cluster-4');

%Plot the GMM with initial k-means results
subplot(2,2,3);
for iCount = 1:const_numberOfGaussians
    plotGMM(Mu_0(iCount,:),Sigma_0(:,:,iCount),1);
end
title('Initialized Hyperparameters');
xlabel('x-direction');
ylabel('y-direction');
subplot(2,2,4);
stem(Priors_0,'color',[1 0 0]);
xlabel('Cluster-number');
ylabel('Prior value');
title('Prior distribution of Gaussians');
%Run EM algorithm to maximize the likelihood function
%[Priors, Mu, Sigma] = EM(GMMData.Data,Priors_0,Mu_0',Sigma_0);
[Priors, Mu, Sigma] = GMM_EM(GMMData.Data,Mu_0,Sigma_0,Priors_0,const_numberOfGaussians);
%plot the new Gaussians
figure;
subplot(2,2,1);
scatter(Mu(:,1),Mu(:,2));hold all

for iCount = 1:const_numberOfGaussians
   plotGMM(Mu(iCount,:),Sigma(:,:,iCount),1);
end
scatter(Mu_0(:,1),Mu_0(:,2),'k','marker','d')
title('GMM-parameters after EM');
xlabel('x-direction');
ylabel('y-direction');

    
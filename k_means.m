close all;
rng(1);
mu = [80,20;60,40];
var = [5;5];
points = [randn(100,2)*var(1) + repmat(mu(1,:),100,1);randn(100,2)*var(2) + repmat(mu(2,:),100,1)];
figure;
subplot(2,2,1);
plot(points(:,1),points(:,2),'.');
xlabel('feature-1');
ylabel('feature-2');
title('Sampled-data for k-means');
axis square;

%unsupervised k-means
[idx, C] = fn_K_Means(points,2,[50,50;52,52]);
[idx, C] = fn_NUBF_Cluster(points,2, [0.08,0.05]);

%[idx,C, sumdist] = kmeans(points,2,'Display','iter','Replicates',2);
subplot(2,2,2);
plot(points(idx==1,1),points(idx==1,2),'r.');
hold all;
plot(points(idx==2,1),points(idx==2,2),'b.');
plot(C(:,1),C(:,2),'k+','markersize',10);
xlabel('feature-1');ylabel('feature-2');
axis square;
subplot(2,2,3);
[silh3, h] = silhouette(points,idx);
h = gca;
h.Children.EdgeColor = [0.8 0.8 1];
xlabel('Silhouette value');
ylabel('Cluster');
subplot(2,2,4);
stem(sumdist);
xlabel('class');
ylabel('Distortion (value)');

%Agglomerative clustering 
Y = pdist(points);
Z = linkage(Y,'centroid');
figure
subplot(2,2,1);

[H,T,outperm] = dendrogram(Z);
%Verify the clustering
%1) Verify the dissimilarity
c = cophenet(Z,Y);
%2) Verify the consistency
I = inconsistent(Z);
T = cluster(Z,'maxclust',2);
subplot(2,2,2);
plot(points(T==1,1),points(T==1,2),'r.');
hold all;
plot(points(T==2,1),points(T==2,2),'b.');
axis square;
subplot(2,2,3);
silhouette(points,T);
axis square;


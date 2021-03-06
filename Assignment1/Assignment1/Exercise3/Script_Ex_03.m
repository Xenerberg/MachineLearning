gesture_dataset = load('gesture_dataset.mat');
init_cluster_l = gesture_dataset.init_cluster_l;
init_cluster_o = gesture_dataset.init_cluster_o;
init_cluster_x = gesture_dataset.init_cluster_x;
gesture_x = gesture_dataset.gesture_x;
gesture_l = gesture_dataset.gesture_l;
gesture_o = gesture_dataset.gesture_o;

figure;
subplot(2,2,1);
for iCount = 1:10
   plot3(gesture_l(:,iCount,1),gesture_l(:,iCount,2),gesture_l(:,iCount,3));hold all;
end
axis square;

subplot(2,2,2);
for iCount = 1:10
   plot3(gesture_o(:,iCount,1),gesture_o(:,iCount,2),gesture_o(:,iCount,3));hold all;
end
axis square;

subplot(2,2,3);
for iCount = 1:10
   plot3(gesture_x(:,iCount,1),gesture_x(:,iCount,2),gesture_x(:,iCount,3));hold all;
end
axis square;
points_x = reshape(gesture_x,600,3);
points_l = reshape(gesture_l,600,3);
points_o = reshape(gesture_o,600,3);
[idx_x, C_x, sumdist_x] = fn_K_Means(points_x,7,init_cluster_x);
[idx_l, C_l, sumdist_l] = fn_K_Means(points_l,7,init_cluster_l);
[idx_o, C_o, sumdist_o] = fn_K_Means(points_o,7,init_cluster_o);

figure;
colororder = [0 0 1;0 0 0;1 0 0;0 1 0;1 0 1;1 1 0;0 1 1];
%set(gca,'colororder',colororder);
set(groot,'defaultAxesColorOrder',colororder); %2014b
for iCount_1 =1:3
    for iCount_2 = 1:7
       subplot(2,2,iCount_1);
       switch(iCount_1)
           case 1
               points = points_l;
               idx = idx_l;
           case 2
               points = points_o;
               idx = idx_o;
           case 3
               points  = points_x;
               idx = idx_x;
       end
       plot3(points((idx==iCount_2),1),points((idx==iCount_2),2),points((idx==iCount_2),3),'LineStyle','none','Marker','*');hold all;
       axis square;
    end
end

points_x = reshape(gesture_x,600,3);
points_l = reshape(gesture_l,600,3);
points_o = reshape(gesture_o,600,3);
[idx_x, C_x] = fn_NUBF_Cluster(points_x,7,[0.08,0.05,0.02]);
[idx_l, C_l] = fn_NUBF_Cluster(points_l,7,[0.08,0.05,0.02]);
[idx_o, C_o] = fn_NUBF_Cluster(points_o,7,[0.08,0.05,0.02]);
figure;
colororder = [0 0 1;0 0 0;1 0 0;0 1 0;1 0 1;1 1 0;0 1 1];
%set(gca,'colororder',colororder); 2014a
set(groot,'defaultAxesColorOrder',colororder); %2014b
for iCount_1 =1:3
    for iCount_2 = 1:7
       subplot(2,2,iCount_1);
       switch(iCount_1)
           case 1
               points = points_l;
               idx = idx_l;
           case 2
               points = points_o;
               idx = idx_o;
           case 3
               points  = points_x;
               idx = idx_x;
       end
       plot3(points((idx==iCount_2),1),points((idx==iCount_2),2),points((idx==iCount_2),3),'LineStyle','none','Marker','*');hold all;
       axis square;
    end
end

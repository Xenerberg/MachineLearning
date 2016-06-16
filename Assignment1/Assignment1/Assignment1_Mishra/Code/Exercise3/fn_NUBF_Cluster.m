%Function fn_NUBF_Cluster
%Inputs:points: points of p-dimensions
%       k: number of clusters
%Outputs: idx: indexes of the points in order they are passed
%         C: k-centroids 
%Author: Hrishik Mishra
function [idx,C] = fn_NUBF_Cluster(points,k,v)
    C = mean(points,1);
    %v = [0.08,0.05,0.02];
    idx = ones(size(points,1),1);
    flag = false;
    num_classes = 1;
    while flag == false
        for iCount = 1:num_classes
            points_k = points(idx==iCount,:);
            sum_dist(iCount) = fn_Distortion(points,C(iCount,:));
        end
        [~,ind_min_sum_dist] = max(sum_dist);
        points_k = points(idx==ind_min_sum_dist,:);        
        C_this = C(ind_min_sum_dist,:);
        X_a = C_this + v;
        X_b = C_this - v;        
        idx_this = idx(idx==ind_min_sum_dist);
        for iCount_1 = 1:size(points_k,1)
           eq_dist_a = norm(points_k(iCount_1,:) - X_a(:,:));
           eq_dist_b = norm(points_k(iCount_1,:) - X_b(:,:));
           if eq_dist_a >= eq_dist_b
               idx_this(iCount_1) = ind_min_sum_dist;
           elseif eq_dist_a < eq_dist_b
               idx_this(iCount_1) = num_classes+1;
           end       
        end
        idx(idx==ind_min_sum_dist) = idx_this;
        num_classes = num_classes + 1;
        for iCount = 1:num_classes
            C(iCount,:) = mean(points(idx==iCount,:),1);
        end
        if num_classes == k
            flag = true;
        end
    end
    
    
end
function [sum_dist] = fn_Distortion(points,centroid)
    sum_dist = 0;
    for iCount = 1:size(points,1)
       sum_dist = sum_dist + norm(points(iCount,:) - centroid);  
    end
end
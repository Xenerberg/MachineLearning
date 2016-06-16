%Function fn_K_Means
%Inputs:points: points of p-dimensions
%       k: number of clusters
%Outputs: idx: indexes of the points in order they are passed
%         C: k-centroids 
%Author: Hrishik Mishra
function [idx,C,J] = fn_K_Means(points,k,init_k)
    C = init_k;
    idx = zeros(size(points,1),1);     
    sums_clust = zeros(size(init_k));
    nums_clust = zeros(size(init_k,1),1);
    J_prev = 0; J = 0;
    flag = false;
    iter_counter=0;
    while flag == false
        sum_eq_dist = 0;
        iter_counter = iter_counter+1;
        for iCount_1 = 1:size(points,1)
            eq_norm = zeros(k,1);        
            for iCount_2 = 1:k
               eq_norm(iCount_2) = norm(C(iCount_2,:)-points(iCount_1,:));
            end       
            
            [min_dist, ind_dis] = min(eq_norm);
            idx(iCount_1) = ind_dis;
            sums_clust(ind_dis,:) = sums_clust(ind_dis,:) + points(iCount_1,:);
            nums_clust(ind_dis) = nums_clust(ind_dis)+1;
            C(ind_dis,:) = sums_clust(ind_dis,:)./nums_clust(ind_dis);
            
            
        end
        for iCount_2 = 1:k
            points_k = points(idx==iCount_2,:);
            for iCount_1 = 1:size(points_k)
               sum_eq_dist = sum_eq_dist + norm(points_k(iCount_1,:) - C(iCount_2,:)); 
            end
        end
        J(iter_counter) = sum_eq_dist;
        decrement = abs(J(iter_counter) - J_prev);
        if (decrement < 1e+4)
            flag = true;
        end
        J_prev = J;
        
    end
end
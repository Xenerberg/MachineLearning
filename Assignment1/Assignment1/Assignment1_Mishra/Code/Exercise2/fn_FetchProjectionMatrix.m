function [eig_vectors,eig_values] = fn_FetchProjectionMatrix(eigvecMatrix,eig_values, d)
    
    eig_values = flipud(eig_values(end-d+1:end,:));
    eig_vectors = fliplr(eigvecMatrix(:,end-d+1:end))';
    
end
function plotGMM(Mu, Sigma, mode)
    nDim = size(Mu,1);
    colorOrder = get(gca,'colororder');
    ax = gca;
    currentColorIndex = ax.ColorOrderIndex;
    currentColor = [0.4 0.4 0.4] + colorOrder(currentColorIndex,:);
    currentColor(currentColor>1) = 1;
    if mode == 1
       numberOfSegments = 50;
       t = linspace(-pi,pi,numberOfSegments)';
       for iCount = 1:nDim
          std_dev = sqrtm(3.0.*Sigma(:,:,iCount));
          X = [cos(t) sin(t)]*real(std_dev) + repmat(Mu(iCount,:), numberOfSegments,1);
          patch(X(:,1),X(:,2),currentColor,'linewidth',2,'EdgeColor',colorOrder(currentColorIndex,:));hold all;
          plot(Mu(iCount,1),Mu(iCount,2),'x','linewidth',2,'color',colorOrder(currentColorIndex,:));
       end
    end

end
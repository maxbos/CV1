function inspect_height_map(hm, title_text)
    [hgt, wid] = size(hm);
    H = rot90(fliplr(hm), 2);
    [X,Y] = meshgrid(1:12:wid, 1:12:hgt);
    H(H < 5) = NaN;
    Z = H(1:12:end, 1:12:end);
%         Z = Y.^2 - X.^2; 
%         H = rot90(fliplr(hm), 2);
    [U,V,W] = surfnorm(X,Y,Z);
    figure;
    quiver3(X,Y,Z,U,V,W,1.2)
%         quiver3(Z,U,V,W)
%         surfnorm(X, Y, H)
    axis equal;
    xlabel('Y')
    ylabel('X')
    zlabel('Z')
    title(title_text)
    view(-50,40)
    set(gca, 'XDir', 'reverse')
%         set(gca, 'XTick', []);
%         set(gca, 'YTick', []);
%         set(gca, 'ZTick', []);
    saveas(gcf,strcat(title_text,'integrationshape.png'))
end
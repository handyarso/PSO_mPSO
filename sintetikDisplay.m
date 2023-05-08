figure;
[X Y] = meshgrid(x,y);
contourf(X,Y,data_model.',50,'edgecolor','none'); 
str = sprintf('Fungsi %s',judul);
title(str, 'FontSize', 16);
set(gca,'FontSize',16,'fontWeight','bold');
cb = colorbar;
colormap jet
set(cb, 'FontSize', 16);
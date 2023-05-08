cla
contourf(X,Y,data_model',50, 'edgecolor','none'); %colorbar('location','southoutside');
hold on
plot(x(par(:,1)),y(par(:,2)),'k.','MarkerSize',20); 
str = sprintf('Fungsi %s',judul);
title(str, 'FontSize', 16);
set(gca,'FontSize',16,'fontWeight','bold');
cb = colorbar;
colormap jet
set(cb, 'FontSize', 16);
drawnow;
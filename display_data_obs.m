figure(1);
subplot(2,1,1);
loglog(freq,rho_obs,'.r','markers',10);
set(gca,'FontSize',11,'LineWidth',1);
set(gca, 'XDir', 'Reverse');
xlabel('Frequency (Hz)','fontweight','bold','fontsize',12);
ylabel('App. Resistivity (Ohm.m)','fontweight','bold','fontsize',12);
title('Forward Modeling MT 1-D (dobs)','fontweight','bold','fontsize',12);
axis([min(freq) max(freq) 1e0 1e5]);
%%
%%
subplot(2,1,2);
semilogx(freq,pha_obs,'.r','markers',10);
set(gca,'FontSize',11,'LineWidth',1);
set(gca, 'XDir', 'Reverse');
xlabel('Frequency (Hz)','fontweight','bold','fontsize',12);
ylabel('Phase (deg.)','fontweight','bold','fontsize',12);
axis([min(freq) max(freq) 0 90]);

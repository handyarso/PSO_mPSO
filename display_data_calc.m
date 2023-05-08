a = 1:popsize;
figure(2);
subplot(2,1,1);
loglog(freq,rho_cal(:,a));
set(gca,'FontSize',11,'LineWidth',1);
set(gca, 'XDir', 'Reverse');
xlabel('Frequency (Hz)','fontweight','bold','fontsize',12);
ylabel('App. Resistivity (Ohm.m)','fontweight','bold','fontsize',12);
title('Forward Modeling MT 1-D (dcalc)','fontweight','bold','fontsize',12);
axis([min(freq) max(freq)]);
%%
%%
subplot(2,1,2);
semilogx(freq,pha_cal(:,a));
set(gca,'FontSize',11,'LineWidth',1);
set(gca, 'XDir', 'Reverse');
xlabel('Frequency (Hz)','fontweight','bold','fontsize',12);
ylabel('Phase (deg.)','fontweight','bold','fontsize',12);
axis([min(freq) max(freq) 0 90]);

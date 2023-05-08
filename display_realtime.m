aa = 1:popsize;
figure(3)
set(gcf,'color','w');

%%
subplot(2,2,1);
loglog(freq,rho_obs,'.r','markers',10);
hold on
loglog(freq,rho_cal(:,aa), 'Color', [0.5 0.5 0.5], 'LineWidth', .1); %,'b','LineWidth', 1);
set(gca,'FontSize',11,'LineWidth',1);
set(gca, 'XDir', 'Reverse');
xlabel('Frequency (Hz)','fontweight','bold','fontsize',12);
ylabel('App. Resistivity (Ohm.m)','fontweight','bold','fontsize',12);
title('Forward Modeling MT 1-D','fontweight','bold','fontsize',12);
axis([min(freq) max(freq) 1e0 1e4]);
hold off

%%
subplot(2,2,3);
semilogx(freq,pha_obs,'.r','markers',10);
hold on
semilogx(freq,pha_cal(:,aa),'Color', [0.5 0.5 0.5],'LineWidth', .1);
set(gca,'FontSize',11,'LineWidth',1);
set(gca, 'XDir', 'Reverse');
xlabel('Frequency (Hz)','fontweight','bold','fontsize',12);
ylabel('Phase (deg.)','fontweight','bold','fontsize',12) ;
axis([min(freq) max(freq) 0 90]);
hold off

%%
subplot(2,2,[2,4]);
rmin = resist_model(1);
rrr = [rmin; resist_model];
ttt = [dmin; cumsum(thick_model); dmax];
stairs(rrr,ttt,'r-');
hold on

resist_est = resValue(par_pmodel_est(aa,1:nlay));
thick_est = thickValue(par_pmodel_est(aa,nlay+1:end));
rmin_est = resist_est(aa,1);
rr_est = [rmin_est resist_est];

temp = 0;
for ii=1:nlay-1
    temp = temp + thick_est(aa,ii);
    cumsumout(:,ii) = temp;
end

%cumsum_tt = [thick_est(aa,1) thick_est(aa,1)+thick_est(aa,2)];

tt_est = [dmin.*ones(size(thick_est(:,1))) cumsumout dmax.*ones(size(thick_est(:,1)))];

for ii=1:popsize
    stairs(rr_est(ii,:),tt_est(ii,:),'Color',[0.5 0.5 0.5],'LineWidth', .1);
end

set(gca,'Ydir','reverse','Yscale','log');
set(gca,'Xscale','log');
axis([1e0 1e5 dmin dmax]);
set(gca,'FontSize',11,'LineWidth',1);
title('Model Magnetotelluric 1-D','fontweight','bold','fontsize',12);
xlabel('Resistivity (Ohm.m)','fontweight','bold','fontsize',12);
ylabel('Depth (m)','fontweight','bold','fontsize',12);
hold off
drawnow

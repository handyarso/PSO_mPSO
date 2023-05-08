%%
%% Tugas Mata Kuliah Pemodelan Inversi Geofisika - TG7023
%% Accep Handyarso - 32322002
%% 
%% Teknik Geofisika
%% Fakultas Teknik Pertambangan dan Perminyakan (FTTM)
%% Institut Teknologi Bandung (ITB)
%% 2023
%%
%% Deskripsi:
%% Script ini melakukan pencarian solusi untuk problem inversi Magnetotelluric 1-D
%% Problem memiliki nlay layering resistivity dan nlay-1 thickness yang akan diestimasi
%% berdasarkan Particle Swarm Optimization (PSO) Algorithm dan modified PSO.
%%

clear all; close all; clc;

% Mendesain model sintetik
resist_model = [500 40 2000].'; thick_model = [1500 4000].';
% resist_model = [100 4000 10].'; thick_model = [2500 4000].';

%% Inisialisasi Parameter
resMin = -2; resMax = 5;
resValue = logspace(resMin, resMax, 200).';

thickMin = 0; thickMax = 4000; % in meters
thickValue = linspace(thickMin, thickMax, 200).';

fmin = -4; fmax = 2.5; ndat = 50;
freq = logspace(fmin, fmax, ndat);

%%
pmodel = [resist_model; thick_model];
nlay_obs = (length(pmodel)+1)/2;
rad2deg = 180.0/pi;

%% Perhitungan Pemodelan Kedepan
for i = 1:length(freq)
    ff = freq(i);
    [appRes phase] = modelMT(pmodel(1:nlay_obs,1), pmodel(nlay_obs+1:length(pmodel),1), ff);
    rho_obs(i,1) = appRes;
    pha_obs(i,1) = phase*rad2deg;
end

%% Menampilkan kurva resistivity dan phase (dobs)
% display_data_obs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inisialisasi Inversi
dmin = 1e3; dmax = 1e5; maxit = 50; 
nlay = 4; % jumlah layer pada inversi
popsize = 200; % Banyaknya swarm (partikel)
T = 1; % bernilai 1, tidak digunakan di sini

c1 = .3;      % bobot pembelajaran individu
c2 = 1-c1;    % bobot pembelajaran sosial
C = 1;        % bernilai 1, tidak digunakan
velRate = .1; % damping
wmin = 0.01;  % nilai minimum bobot inersia
wmax = 1.0;   % nilai maksimum bobot inersia


initFM_INV;

%% Menampilkan kurva resistivity dan phase
%display_data_calc;

%% Menghitung misfit
for i = 1:popsize
    misfit(i,1) = sqrt(sum(([rho_obs; pha_obs] - [rho_cal(:,i); pha_cal(:,i)]).^2)./(2*ndat));
end

localpar  = par_pmodel_est; % minimum local tiap partikel
localcost = misfit;         % minimum cost tiap partikel
[globalcost,indx] = min(misfit);    % globalbest - gbest
globalpar = par_pmodel_est(indx,:); % lokasi globalbest - gbest index

iter = 0; % counter
while iter < maxit
iter = (iter + 1);

%% Menjalankan PSO, harus aktif
basic_PSO;

pmodel_est_result = [resValue(globalpar(1:nlay)); thickValue(globalpar(nlay+1:length(globalpar)))]; % pmodel_est
[iter; globalcost; pmodel_est_result]

%% Modifikasi disini, opsional
modify_PSO;
end

% %% Pemodelan kedepan gbest
% for j = 1:ndat
%     ff = freq(j);
%     [appRes phase] = modelMT(resValue(globalpar(1,1:nlay)), thickValue(globalpar(1,nlay+1:length(globalpar))), ff);
%     rho_cal_hasil(j,1) = appRes;
%     pha_cal_hasil(j,1) = phase*rad2deg;
% end

[rho_cal_hasil pha_cal_hasil] = FMT1DCalc(freq, globalpar, resValue, thickValue, nlay);

%% Menampilkan kurva RMS
display_rms

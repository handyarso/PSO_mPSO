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
%% Script ini melakukan pencarian solusi untuk beberapa problem optimasi (fungsi uji)
%% fungsi uji tersebut terdiri dari: Peaks, Sphere, Rastrigin, Griewank, dan Schaffer
%% metode optimalisasi yang digunakan adalah Particle Swarm Optimization (PSO)
%%

clear all; close all; clc;

%{
Pilih mode kasus: 
1. fpeaks
2. fsphere
3. rastrigin
4. griewank
5. schaffer
%}
kasus = 5; % pilih 1 - 5
resolution = 200;

sintetikData;

%% Inisialisasi dan Perhitungan Optimalisasi dengan PSO
%% Inisialisasi PSO
popsize = 100; % Banyaknya swarm (partikel)
maxit = 100; % jumlah iterasi maksimum
npar = 2; % 2 dimensi (x dan y)

c1 = .3; % pembelajaran individu
c2 = 1-c1; % pembelajaran sosial
C = 1; % bernilai 1, tidak digunakan
wmin = 0.01; % nilai minimum bobot inersia
wmax = 1.0; % nilai maksimum bobot inersia

%% Perhitungan optimasi dengan PSO
par = ceil(rand(popsize,npar).*length(x)); % partikel random
vel = ceil(rand(popsize,npar).*length(x)/10); % kecepatan random

[est_solution] = FCalc(par, popsize, x, y, kasus); % Perhitungan pemodelan kedepan setiap partikel

minc(1) = min(est_solution(:,3)); % min cost
meanc(1) = mean(est_solution(:,3)); % mean cost
globalmin = minc(1); % global minimum

localpar = par; % minimum local tiap partikel
localcost = est_solution(:,3); % cost minimum tiap partikel

[globalcost,indx] = min(est_solution(:,3)); % gbest
globalpar = par(indx,:); % lokasi gbest

iter = 0; % counter
while iter < maxit
iter = iter + 1;

realtimeDisplay; % Menampilkan posisi partikel pada setiap iterasi

% update kecepatan = vel
w = (maxit-iter)/maxit*(wmax-wmin)+wmin; % bobot inertia, fungsi dari iterasi
r1 = rand(popsize,npar); % angka random untuk partikel best / local best (LBest)
r2 = rand(popsize,npar); % angka random untuk swarm best / global best (GBest)

       % bobot*vel + belajar individu + belajar sosial
vel = C*(w*vel + c1 *r1.*(localpar-par) + c2*r2.*(ones(popsize,1)*globalpar-par)); % hitung kecepatan
par = ceil(par + vel); % update posisi partikel

% mekanisme batas area dari indeks yang digunakan
for i=1:length(par(:,1))
    if (par(i,1)>=length(x))
        par(i,1) = length(x);
    elseif (par(i,1)<=1)
        par(i,1) = 1;
    end

    if (par(i,2)>=length(y))
        par(i,2) = length(y);
    elseif (par(i,2)<=1)
        par(i,2) = 1;
    end
end

[est_solution] = FCalc(par, popsize, x, y, kasus); % Perhitungan pemodelan kedepan setiap partikel

bettercost = est_solution(:,3) < localcost; % partikel mana yang lebih baik
localcost = localcost.*not(bettercost) + est_solution(:,3).*bettercost; % update nilai minimum partikel yang lebih baik
localpar(find(bettercost),:) = par(find(bettercost),:); % update local par (berdasarkan penandaan bettercost)

% mencari solusi yang lebih baik dari GBest lalu disimpan
[temp, t] = min(localcost);
if temp < globalcost
    globalpar = par(t,:);
    indx = t;
    globalcost = temp;
end

[iter globalpar globalcost] % hasil pada setiap iterasi

minc(iter+1) = min(est_solution(:,3)); % nilai minimum semua particle disimpan pada setiap iterasi
globalmin(iter+1) = globalcost; % nilai global minimum disimpan pada setiap iterasi
meanc(iter+1) = mean(est_solution(:,3)); % menyimpan nilai rata-rata misfit pada setiap iterasi
end

solutionDisplay;
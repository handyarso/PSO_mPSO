hold on
plot(x(globalpar(1,1)),y(globalpar(1,2)),'m*','LineWidth',5); % menampilkan partikel terbaik (solusi)

figure;
plot(globalmin, 'LineWidth', 2);
title('Nilai Misfit pada setiap Iterasi');
xlabel('Iterasi');
ylabel('RMS');
%% Inisialisasi dan Perhitungan data sintetik sesuai kasus yang dipilih
%% Inisialisasi Parameter model
switch kasus
    case 1
        minV = -3; maxV = 3;
        judul = 'Peaks';
    case 2
        minV = -30; maxV = 30;
        judul = 'Sphere';
    case 3
        minV = -30; maxV = 30;
        judul = 'Rastrigin';
    case 4
        minV = -30; maxV = 30;
        judul = 'Griewank';
    case 5
        minV = -30; maxV = 30;
        judul = 'Schaffer';
    otherwise
end

x = linspace(minV,maxV,resolution);
y = linspace(minV,maxV,resolution);

%% Perhitungan data sintetik
for j = 1:length(y)
    for i = 1:length(x)
        switch kasus
            case 1
                z(i,j) = fpeaks(x(i),y(j));
            case 2
                z(i,j) = fsphere(x(i),y(j));
            case 3
                z(i,j) = frastrigin(x(i),y(j), 15, .25);
            case 4
                z(i,j) = fgriewank(x(i),y(j));
            case 5
                z(i,j) = fschaffer(x(i), y(j), .25);
            otherwise
        end
    end
end

data_model = z;

sintetikDisplay; % Menampilkan data sintetik
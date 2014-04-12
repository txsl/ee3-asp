close all; clear; clc;

%% 3.0.1 and 3.1.1

subplot(2,3,1);
x = randn(1, 128);
p = pgm(x);
stem(p, 'Marker', 'none')
    xlim([0 128]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('PSD of WGN, N=128');

% For the filtered 128 sample process
pf = filtfilt(0.2*[1 1 1 1 1], 1, p);
subplot(2,3,4)
stem(pf, 'Marker', 'none');
    xlim ([0 128]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('Filtered PSD of WGN, N=128');

    
% For N=256 long samples
subplot(2,3,2);
x = randn(1, 256);
p = pgm(x);
stem(p, 'Marker', 'none')
    xlim([0 256]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('PSD of WGN, N=256');

% For the filtered 256sample process
pf = filtfilt(0.2*[1 1 1 1 1], 1, p);
subplot(2,3,5);
stem(pf, 'Marker', 'none');
    xlim ([0 256]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('Filtered PSD of WGN, N=256');

% For N=512 samples
subplot(2,3,3);
x = randn(1, 512);
p = pgm(x);
stem(p, 'Marker', 'none')
    xlim ([0 512]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('PSD of WGN, N=512');

% For the filtered 512 sample process
pf = filtfilt(0.2*[1 1 1 1 1], 1, p);
subplot(2,3,6);
stem(pf, 'Marker', 'none');
    xlim ([0 512]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('Filtered PSD of WGN, N=512');
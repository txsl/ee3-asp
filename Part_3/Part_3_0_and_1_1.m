close all; clear; clc;

subplot(2,3,1);

x = randn(1, 128);
p = pgm(x);
stem(p)
xlim([0 128]);
xlabel('Frequency Bin');
ylabel('Magnitude');
title('PSD of WGN, N=128');

pf = filtfilt(0.2*[1 1 1 1 1], 1, p);
subplot(2,3,4)
stem(pf);
xlim ([0 128]);
xlabel('Frequency Bin');
ylabel('Magnitude');
title('Filtered PSD of WGN, N=128');


subplot(2,3,2);
x = randn(1, 256);
p = pgm(x);
stem(p)
xlim([0 256]);
xlabel('Frequency Bin');
ylabel('Magnitude');
title('PSD of WGN, N=256');

pf = filtfilt(0.2*[1 1 1 1 1], 1, p);
subplot(2,3,5)
stem(pf);
xlim ([0 256]);
xlabel('Frequency Bin');
ylabel('Magnitude');
title('Filtered PSD of WGN, N=256');


subplot(2,3,3);
x = randn(1, 512);
p = pgm(x);
stem(p)
xlim ([0 512]);
xlabel('Frequency Bin');
ylabel('Magnitude');
title('PSD of WGN, N=512');

pf = filtfilt(0.2*[1 1 1 1 1], 1, p);
subplot(2,3,6)
stem(pf);
xlim ([0 512]);
xlabel('Frequency Bin');
ylabel('Magnitude');
title('Filtered PSD of WGN, N=512');
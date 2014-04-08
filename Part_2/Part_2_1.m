%% 2.1.1

clear all; close all;

x = randn(1, 1000);
R = xcorr(x, 'unbiased');
plot(-999:999, R)

%% 2.1.2

figure;
plot(-999:999, R)
zoom xon
zoom(20)

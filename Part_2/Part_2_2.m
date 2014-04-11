clear all; close all; clc;

%% 2.2.1

% Generate our WGN
x = randn(1, 1000);

% Filter with an order 9 MA filter
y = filter(ones(9,1),1,x);

% ACF
ycorr = xcorr(y, 'unbiased');

% Plot the results
stem(-20:20, ycorr(980:1020));
    xlabel('Sample lag \tau');
    ylabel('Correlation');
    title('ACF of 1000 order 9 MA filtered WGN process');
    grid on;

clear all; close all; clc;

%% 2.1.1

% Generate our 1000 long vector of Guassian Noise
x = randn(1, 1000);

% Run it through the xcorr function to have an unbiased estimate the autocorrelation 
R = xcorr(x, 'unbiased');

% Plot th  results
plot(-999:999, R)
    xlabel('Sample lag \tau');
    ylabel('Correlation');
    title('ACF of 1000 long white guassian noise sample');
    grid on;

%% 2.1.2

figure;
plot(-999:999, R)
    xlabel('Sample lag \tau');
    ylabel('Correlation');
    title('ACF of 1000 long white guassian noise sample (zoomed in)');
    grid on;

    % Use the zoom command to get at what we need to see.
    zoom xon
    zoom(20)

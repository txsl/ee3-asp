clear all; close all; clc;

load('sunspot.dat')
sunspotdata = sunspot(:, 2);

%% 2.4.2 Sunspot Models

% Let's take a look at the raw signal
figure;
plot(sunspot(:,1), sunspotdata);
    xlabel('Year');
    ylabel('No. of observed sunspots');
    title('Sunspot Series');
    grid on;

figure;

% The first set of data, for N = 5
[N5,lag] = xcorr(sunspotdata(1:6), 'unbiased');
subplot(3, 1, 1);
stem(lag, N5);
    title('Sunspots Autocorrelation, N=5');
    xlabel('Correlation Lag');
    ylabel('Correlation');
    grid on;

% Now for N = 20
[N20,lag] = xcorr(sunspotdata(1:20), 'unbiased');
subplot(3, 1, 2);
stem(lag, N20);
    title('Sunspots Autocorrelation, N=20');
    xlabel('Correlation Lag');
    ylabel('Correlation');
    grid on;
    
% And for N = 250. 
[N250, lag] = xcorr(sunspotdata(1:251), 'unbiased');
subplot(3, 1, 3);
stem(lag, N250)
    title('Sunspots Autocorrelation, N=250');
    xlabel('Correlation Lag');
    ylabel('Correlation');
    grid on;
    
% Now we take the zero mean version. We substract the mean of the samples
% being autocorrelated
figure;

subplot(3, 1, 1)
[y, lag] = xcorr(sunspotdata(1:6) - mean(sunspotdata(1:6)), 'unbiased');
stem(lag, y)
    title('Zero Mean Sunspots Autocorrelation, N=5');
    xlabel('Correlation Lag');
    ylabel('Correlation');
    grid on;
    
subplot(3, 1, 2)
[y, lag] = xcorr(sunspotdata(1:21) - mean(sunspotdata(1:21)), 'unbiased');
stem(lag, y)
    title('Zero Mean Sunspots Autocorrelation, N=20');
    xlabel('Correlation Lag');
    ylabel('Correlation');
    grid on;
    
subplot(3, 1, 3)
[y, lag] = xcorr(sunspotdata(1:251) - mean(sunspotdata(1:251)), 'unbiased');
stem(lag, y, 'Marker', 'none')
    title('Zero Mean Sunspots Autocorrelation, N=250');
    xlabel('Correlation Lag');
    ylabel('Correlation');
    grid on;

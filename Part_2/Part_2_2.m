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

    
%% 2.3.1

% Now let's cross correlate x and y
xycorr = xcorr(x, y, 'unbiased');

% Let's flip the processes around to see if it changes anything
yxcorr = xcorr(y, x, 'unbiased');

figure;
subplot(1,2,1);

% plot them
stem(-20:20, xycorr(980:1020))
    xlabel('Sample lag \tau');
    ylabel('Correlation');
    title('Cross correlation of filtered and unfiltered xy process');
    grid on;
    
    
subplot(1,2,2);
stem(-20:20, yxcorr(980:1020))
    xlabel('Sample lag \tau');
    ylabel('Correlation');
    title('Cross correlation of filtered and unfiltered yx process');
    grid on;
    
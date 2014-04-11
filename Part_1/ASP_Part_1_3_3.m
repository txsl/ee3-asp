close all; clear all; clc;

%% 1.3.3

% Generate 1000 samples
data = rp1(1, 1000);

% Run our pdf function
pdf(data);

% Title..
title('pdf of 1000 sample ps1 process');

figure;
subplot(1,2,1);
pdf(data(1:500));
title('pdf of first half of samples');

subplot(1,2,2);
pdf(data(501:1000));
title('pdf of last half of samples');
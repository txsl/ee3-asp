clear all; close all; clc;

%% 4.4.2

a = [1, 0.9, 0.2];
n = randn(1,1000);
x = filter(1, a, n);

us = [0.01 0.025 0.05 0.1];
[y_est, a_est, e] = ar_est(x, 0.01, 2);

for i = 1:4
    [y_est, a_est, e] = ar_est(x, us(i), 2);

    subplot(2,2,i);
    L = length(a_est);
    plot(1:L, a_est.')
        grid on;
        xlim([1 L]);
        xlabel('Iteration');
        ylabel('Parameter Estimate');
        legend('a_1', 'a_2');
        title(sprintf('Estimated parameters for AR(2) process, \\mu=%1.2f', us(i))); 
end
    
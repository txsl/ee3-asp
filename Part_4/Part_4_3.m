clear all; close all; clc;

%% 4.3

mus = [0.002, 0.1, 0.2, 0.5];

% Initialise coefficients and signals
Nw = 4;
x = randn(1,1000);
y = filter([1, 2, 3, 2, 1], 1, x);
n = 0.1*randn(1,1000);
z = y + n;

% Use out lms function to estimate coefficients
[~, e_lms, w_lms] = lms(x, z, 0.005, Nw);
[~, e_lms_gs, w_lms_gs] = lms_gs(x, z, 0.005, 0.1, Nw);
[~, e_lms_lin, w_lms_lin] = lms_gs_linear(x, z, 0.005, 0.1, Nw);


% Plot the results
colours = ['b', 'r', 'g', 'c', 'm'];

% Plot the different algorithms
subplot(2,1,1);
L = 1:length(w_lms);
plot(L, w_lms(2,:), L, w_lms_gs(2,:), 'r', L, w_lms_lin(2,:), 'g');
    legend('No gear shifting', 'Notched Gear Shifting', 'Linear Shifting', 'Location', 'SouthEast');
    grid on;
    xlim([1 1000]);
    xlabel('Iteration');
    ylabel('Estimated value');
    title('b_1 estimated value with different gear shifting techniques');

subplot(2,1,2);
L = 1:length(e_lms);
plot(L, e_lms.^2, L, e_lms_gs.^2, 'r', L, e_lms_lin.^2, 'g');
    legend('No gear shifting', 'Notched Gear Shifting', 'Linear Shifting', 'Location', 'NorthEast');
    grid on;
    xlim([1 1000]);
    xlabel('Iteration');
    ylabel('Error^2');
    title('Error^2 with different gear shifting techniques');
    
    
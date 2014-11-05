clear all; close all; clc;

%% 4.6

% Generate random numbers and process
a = [1, 0.9, 0.2];
n = randn(1,1000);
x = filter(1, a, n);

% Run function and return the different 
[ w, w_sign_error, w_sign_reg, w_sign_sign ] = ar_est_signs(x, 0.01, 2 );

L = length(w);
g = 1:L;

% Plot the results
hold on;
hr = plot(g, w(1,:), 'b'); plot(g, w(2,:), 'b');
hse = plot(g, w_sign_error(1,:), 'g'); plot(g, w_sign_error(2,:), 'g');
hsr = plot(g, w_sign_reg(1,:), 'r'); plot(g, w_sign_reg(2,:), 'r');
hss = plot(g, w_sign_sign(1,:), 'c'); plot(g, w_sign_sign(2,:), 'c');
    
    xlim([ 1 L ]);
    grid on;
    xlabel('Iteration');
    ylabel('Parameter Estimate');
    title('LMS Sign Algorithms tested on known AR coefficients');
    legend([hr hse hsr hss], 'Regular LMS', 'Signed Error', 'Signed Regressor', 'Signed Signed', 'Location', 'SouthWest');

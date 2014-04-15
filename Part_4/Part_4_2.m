clear all; close all; clc;

%% 4.2.2

mus = [0.002, 0.1, 0.25, 0.5];

for k = 1:length(mus)
    % Initialise coefficients and signals
    Nw = 4;
    x = randn(1,1000);
    y = filter([1, 2, 3, 2, 1], 1, x);
    n = 0.1*randn(1,1000);
    z = y + n;

    % Use out lms function to estimate coefficients
    [y_lms, e_lms, w_lms] = lms(x, z, mus(k), Nw);

    % Plot the results
    N =  length(w_lms(:,1));
    colours = ['b', 'r', 'g', 'c', 'm'];

    % Plot the different coefficients
    figure;
    subplot(2,1,1 );
    hold on;
    for i = 1:N
        plot(1:length(w_lms), w_lms(i,:), colours(i))
    end
    hold off;

        legend('b_0', 'b_1', 'b_2', 'b_3', 'b_4', 'Location', 'North');
        grid on;
        xlim([1 length(w_lms)]);
        xlabel('Iteration');
        ylabel('Estimated value');
        title(sprintf('Estimated coefficient values, \\mu=%1.3f', mus(k)));
        
    subplot(2,1,2);
    
    plot(1:length(e_lms), e_lms.^2);
        grid on;
        ylabel('Error^2');
        xlabel('Iteration');
        title(sprintf('Error^2, \\mu=%1.3f', mus(k)));
end


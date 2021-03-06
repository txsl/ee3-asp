clear all; close all; clc;

load('sunspot.dat')
sunspotdata = sunspot(:, 2);
sunspotdata = zscore(sunspotdata);

%% 2.4.4

N = length(sunspotdata);

MDL = [];
AIC = [];
Error = [];

MDL = zeros(1,50);

for i = 1:50
    % We can use E as the error. We append the last value to each vector
   
   [a, E] = aryule(sunspotdata, i);
    sprintf('%d', E)
   MDL(i) = log(sum(E)) + (i*log(N)/N);
   AIC = [AIC (log(E) + 2*i/N)];
   Error = [Error log(E)];
end

figure;
plot(MDL);
hold on;
plot(AIC, 'r');
plot(Error, 'g')
    xlim([1 50]);
    legend('MDL', 'AIC', 'Cumulative Squared Error');
    xlabel('Model Order');
    ylabel('Model Error');
    title('MDL, AIC and Cumulative Squared Error');
    grid on;



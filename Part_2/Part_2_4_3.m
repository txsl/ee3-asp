clear all; close all; clc;

load('sunspot.dat')
sunspotdata = sunspot(:, 2);

%% 2.4.3 

A = 1;

for i = 1:10
    out = aryule(sunspotdata, i);
    A = [A out(i+1)];
end

% For the zero mean and unit variance version
Auv = 1;
zmsunscore = zscore(sunspotdata);

for i = 1:10
    out = aryule(zmsunscore, i);
    Auv = [Auv out(i+1)];
end

figure;
hold on;;
stem(0:10, A)
stem(0:10, Auv, 'diamondr');
    xlabel('Lag');
    ylabel('Correlation');
    title('Partial Autocorrelation Function');
    legend('PCF (Partial Correlation Function)', 'PCF with Zero Mean, Unit Variance');
    grid on;



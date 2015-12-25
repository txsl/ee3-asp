close all; clear; clc;

load('vinyl.mat');

%% 5.5 Esimate the Model Order of the AR system

MDL = zeros(2,100);
AIC = zeros(2,100);
Error = zeros(2,100);

MDL = zeros(1,50);

N = length(s2h(:, 1));

% Run through 100 different filter lengths
for i = 1:100
    
   
   [~, E] = aryule(s2h(:, 1), i);
   MDL(1, i) = log(sum(E)) + i*log(N)/N;
   AIC(1, i) = log(E) + 2*i/N;
   Error(1, i) = log(E);
   
   % For channel 2
   [~, E] = aryule(s2h(:, 2), i);

   MDL(2, i) = log(sum(E)) + i*log(N)/N;
   AIC(2, i) = log(E) + 2*i/N;
   Error(2, i) = log(E);
   
   
end

% Plot the results
hold on;
plot(1:100, MDL(1,:), 1:100, MDL(2,:));
plot(1:100, AIC(1,:),'r', 1:100, AIC(2,:),'y');
plot(1:100, Error(1,:),'c', 1:100, Error(2,:),'m');
    grid on;
    xlabel('Model Order');
    ylabel('Model Error');
    title('Stairway to Heaven AR Model Order Estimation');
    legend('MDL Channel 1', 'MDL Channel 2', 'AIC Channel 1', 'AIC Channel 2', 'Cumulative Squared Error Channel 1', 'Cumulative Squared Error Channel 2');
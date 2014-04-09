close all; clear; clc;

%% 1.1


X1 = rand(1000, 1);

% Calculating our 1000 sample mean and std dev for 1.1.1 and 1.1.2
m1 = mean(X1);
s1 = std(X1);


%% 1.1.3
% Ensemble of 10 1000 sample sets
X = rand(1000, 10);

% To get non SI x labels
%set(gca, 'XTickLabel', num2str(get(gca, 'XTick'))) 

m10 = mean(X);
s10 = std(X);

figure;
subplot(1,2,1)
stem(1:10, 0.5-m10);
title('Mean Bias');
xlabel('Ensemble Iteration');
ylabel('Bias');

subplot(1,2,2)
stem(1:10, 0.2887 - s10);
title('Standard Deviation Bias');
xlabel('Ensemble Iteration');
ylabel('Bias');

%% 1.1.4

% The hist function puts the data in to bins
a = hist(X(:,1));

% Normalise the histogram based on our sample size (to create a p.d.f.)
a = a/1000;

figure;

subplot(1,2,1)
bar(0.1:0.1:1 , a); % We set our x axis correctly
xlim([0 1.1])  % Set the x axis limits correctly
hline = refline([0 0.1]); % Add the theoretical line
set(hline,'Color','r')
title('pdf of 1000 samples, in 10 bins');
xlabel('x');
ylabel('Density');
legend('Actual pdf', 'Theoretical pdf', 'Location', 'SouthEast');


% This time we are splitting the pdf in to 50 bins
a = hist(X1(:,1), 50);
a = a/1000;

subplot(1,2,2)
bar(0.02:0.02:1, a);
xlim([0 1.02]);
hline = refline([0 0.02]);
set(hline,'Color','r')
title('pdf of 1000 samples, in 50 bins');
xlabel('x');
ylabel('Density');
legend('Actual pdf', 'Theoretical pdf', 'Location', 'SouthEast');


% This time, we are just using 100 samples
figure
a = hist(X(1:100,1), 10);
a = a/100; % Normalised by 100 samples this time
bar(0.1:0.1:1, a); 
xlim([0 1.1]); 
hline = refline([0 0.1]);
set(hline,'Color','r')
title('pdf of 100 samples, in 10 bins');
xlabel('x');
ylabel('Density');
legend('Actual pdf', 'Theoretical pdf');


%% 1.1.5 

Xg = randn(1000, 10);
mg = mean(Xg);
sg = std(Xg);

figure;
subplot(1,2,1)
stem(1:10, 0-mg);
title('Mean Bias');
xlabel('Ensemble Iteration');
ylabel('Bias');

subplot(1,2,2)
stem(1:10, sg - 1);
title('Standard Deviation Bias');
xlabel('Ensemble Iteration');
ylabel('Bias');


figure;
subplot(1,2,1);
[a, bins] = hist(Xg(:,1));

% Normalise the histogram based on our sample size (to create a p.d.f.)
a = a/1000;

bar(bins, a);
title('pdf of 1000 samples, in 10 bins');
xlabel('x');
ylabel('Density');

% Now let's have 30 bins.
subplot(1,2,2);
[a, bins] = hist(Xg(:,1), 30);
a = a/1000;

bar(bins, a);
title('pdf of 1000 samples, in 30 bins');
xlabel('x');
ylabel('Density');

% This time with fewer samples
figure;
[a, bins] = hist(Xg(1:100, 1));
a = a/100;
bar(bins, a);
title('pdf of 100 samples');
xlabel('x');
ylabel('Density');
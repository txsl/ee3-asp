%% 1.1.5 

% Generate 10 ensembles of 1000 sample Guassian noise
Xg = randn(1000, 10);

% Then take the mean and std dev of each ensemble
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
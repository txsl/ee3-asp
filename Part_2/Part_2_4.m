clear all; close all;

%% 2.4.1

a1 = -2.5 + 5*rand(1000,1);
a2 = -1.5 + 3*rand(1000,1);

a1stable = [];
a2stable = [];
a1unstable = [];
a2unstable = [];

for i = 1:length(a1)
    w = randn(1000, 1);
    x = zeros(1000, 1);
    x(1) = w(1);
    x(2) = w(2);
    for j = 3:1000
        x(j) = a1(i)*x(j-1) + a2(i)*x(j-2);
    end
    if(abs(x(1000)) < 10)
        a1stable = [a1stable a1(i)];
        a2stable = [a2stable a2(i)];
    else
        a1unstable = [a1unstable a1(i)];
        a2unstable = [a2unstable a2(i)];
    end
end
subplot (1,2,1);
plot(a1stable, a2stable, '^r')
hold on;
plot(a1unstable, a2unstable, '+')
hold off;
legend('Convergent', 'Non-Convergent');
xlabel('a1');
ylabel('a2');
title('Randomly generated processes to show the stability triangle');


%  We don't need to define a1 as we are using it build in to the for loop
a2 = -1.5:0.1:1.5;

a1stable = [];
a2stable = [];
a1unstable = [];
a2unstable = [];

for a1 = -2.5:0.1:2.5
    for k = 1:length(a2)
        w = randn(1000, 1);
        x = zeros(1000, 1);
        x(1) = w(1);
        x(2) = w(2);
        for j = 3:1000
            x(j) = a1*x(j-1) + a2(k)*x(j-2);
        end
        if(abs(x(1000)) < 10)
            a1stable = [a1stable a1];
            a2stable = [a2stable a2(k)];
        else
            a1unstable = [a1unstable a1];
            a2unstable = [a2unstable a2(k)];
        end
    end
end


subplot (1,2,2);
plot(a1stable, a2stable, '^r')
hold on;
plot(a1unstable, a2unstable, '+')
hold off;
legend('Convergent', 'Non-Convergent');
xlabel('a1');
ylabel('a2');
title('Series generated processes to show the stability triangle');

%% 2.4.2 Sunspot Models
load('sunspot.dat')
sunspotdata = sunspot(:, 2);
figure;

N5 = xcorr(sunspotdata(50:55));
subplot(3, 1, 1);
plot(N5);
title('Sunspots Autocorrelation, N=5');
xlabel('Correlation Lag');
ylabel('Correlation');

subplot(3, 1, 2)
N20 = xcorr(sunspotdata(50:69));
plot(N20);
title('Sunspots Autocorrelation, N=20');
xlabel('Correlation Lag');
ylabel('Correlation');

subplot(3, 1, 3)
N250 = xcorr(sunspotdata(1:250));
plot(N250)
title('Sunspots Autocorrelation, N=250');
xlabel('Correlation Lag');
ylabel('Correlation');

% Here we take the zero mean version
sm = mean(sunspotdata);
zms = sunspotdata - sm;

figure;
N5 = xcorr(zms(50:55));
figure;
subplot(3, 1, 1)
plot(N5)
title('Zero Mean Sunspots Autocorrelation, N=5');
xlabel('Correlation Lag');
ylabel('Correlation');

subplot(3, 1, 2)
N20 = xcorr(zms(50:69));
plot(N20)
title('Zero Mean Sunspots Autocorrelation, N=20');
xlabel('Correlation Lag');
ylabel('Correlation');


subplot(3, 1, 3)
N250 = xcorr(zms(1:250));
plot(N250)
title('Zero Mean Sunspots Autocorrelation, N=250');
xlabel('Correlation Lag');
ylabel('Correlation');


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
hold on;
stem(1:11, A)
stem(1:11, Auv, 'diamondr')
legend('PCF (Partial Correlation Function)', 'PCF with Zero Mean, Unit Variance')


%% 2.4.4

N = length(sunspotdata);

MDL = [];
AIC = [];
Error = [];

for i = 1:50
    % We can use E as the square of the 
   [a, E] = aryule(sunspotdata, i);
   MDL = [MDL (log(E) + (i*log(N)/N))];
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



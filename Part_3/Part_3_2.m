clear all; close all; clc;


% Generate random samples
x = randn(1,1064);

% Filter them with given coefficients
y = filter(1, [1, 0.9], x);

% Cut off the first 40 samples (affected by transients in the filter)
x = x(41:end);
y = y(41:end);

subplot(1,2,1);
plot(x);
    xlim([0 1024])
    grid on;
    title('Original (unfiltered) signal');
    xlabel('Sample number (n)');
    ylabel('Amplitude');

subplot(1,2,2);
plot(y, 'red');
    xlim([0 1024])
    grid on;
    title('Filtered signal');
    xlabel('Sample number (n)');
    ylabel('Amplitude');


%% 3.2.1
    
figure;
[h,w] = freqz([1], [1 0.9], 512);
py = pgm(y);


%% 3.2.2
subplot(2,1,1);

plot(w/(2*pi),abs(h).^2)
hold on;

plot(w/(2*pi), py(1:512).', 'r');

% plot(w/(2*pi),abs(Pesty).^2, 'g');

    legend('Theoretical PSD', 'Periodogram', 'Location', 'NorthWest')
    grid on;
    xlabel('Normalised Frequency');
    ylabel('Amplitude');


%% 3.2.3
subplot(2,1,2)

plot(w/(2*pi),abs(h).^2)
hold on;

plot(w/(2*pi), py(1:512).', 'r');

% plot(w/(2*pi),abs(Pesty).^2, 'g');
legend('Theoretical PSD', 'Periodogram', 'Location', 'NorthWest')
    xlim([.4 .5]);
    grid on;
    xlabel('Normalised Frequency');
    ylabel('Amplitude')


%% 3.2.4

% Let's get our autocorrelation series
R = xcorr(y, 'unbiased');

% These are the two equations we need to work out our filter coefficients
% based on the sampele size, 1025 and 1024 are the right lag indexes
a1 = -R(1025)/R(1024);
var1 = R(1024) + a1*R(1025);

% Now we run a freq sweep with these parameters
P_est = freqz(var1, [1, a1], 512);

% and plot
figure;
plot(w/(2*pi),abs(P_est).^2, 'r', w/(2*pi), abs(h).^2)
    grid on
    xlabel('Normalised Frequency');
    ylabel('Amplitude');
    legend('Estimated PSD', 'Theoretical PSD', 'Location', 'NorthWest');

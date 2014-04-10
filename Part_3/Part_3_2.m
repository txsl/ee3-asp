clear all; close all; clc;

x = randn(1,1064);
y = filter(1, [1, 0.9], x);

x = x(41:end);
y = y(41:end);

subplot(2,1,1);
plot(x);
xlim([0 1024])
grid on;
title('Original (unfiltered) signal');
xlabel('Sample number (n)');
ylabel('Amplitude');

subplot(2,1,2);
plot(y);
xlim([0 1024])
grid on;
title('Filtered signal');
xlabel('Sample number (n)');
ylabel('Amplitude');

%% 3.2.1
figure;
[h,w] = freqz([1], [1 0.9], 512);
py = pgm(y);


%% 3.2.4

% figure;
R = xcorr(y, 'unbiased');
% plot(R)

a1 = -R(1025)/R(1024);
var1 = R(1024) + a1*R(1025);

f = w/(2*pi);

% Pesty = (var1)/abs(1+a1*exp(-1i*2*pi*f)).^2;
Pesty = freqz(var1, [1, a1], 512);
% figure;
% plot(w/(2*pi),abs(Pesty).^2, 'r', w/(2*pi), abs(h).^2)
% 
% grid on
% xlabel('Normalised Frequency');
% ylabel('Amplitude');
% legend('Theoretical PSD', 'Modelled PSD', 'Location', 'NorthWest');


%% 3.2.2
subplot(2,1,1);

plot(w/(2*pi),abs(h).^2)
hold on;

plot(w/(2*pi), py(1:512).', 'r');

plot(w/(2*pi),abs(Pesty).^2, 'g');

legend('Theoretical PSD', 'Periodogram', 'Estimated PSD', 'Location', 'NorthWest')
grid on;
xlabel('Normalised Frequency');
ylabel('Amplitude');


%% 3.2.3
subplot(2,1,2)

plot(w/(2*pi),abs(h).^2)
hold on;

plot(w/(2*pi), py(1:512).', 'r');

plot(w/(2*pi),abs(Pesty).^2, 'g');
legend('Theoretical PSD', 'Periodogram', 'Estimated PSD', 'Location', 'NorthWest')
xlim([.4 .5]);
grid on;
xlabel('Normalised Frequency');
ylabel('Amplitude')
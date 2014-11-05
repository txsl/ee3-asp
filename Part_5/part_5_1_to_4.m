close all; clear; clc;

load('vinyl.mat');

%% 5.1

[bad_1, f] = periodogram(s2h(:, 1).', [], [], FS);
[bad_2, ~] = periodogram(s2h(:, 2).', [], [], FS);

subplot(2,1,1);
stem(f, bad_1, 'Marker', 'None');
    xlim([0 2500]);
    grid on;
    title('Periodogram for the left Channel');
    xlabel('Frequency /Hz');
    ylabel('Power');

subplot(2,1,2);
stem(f, bad_2, 'Marker', 'None');
    xlim([0 2500]);
    grid on;
    title('Periodogram for the right Channel');
    xlabel('Frequency /Hz');
    ylabel('Power');    

%% 5.2

[good_1, ~] = periodogram(s2h_original(:, 1).', [], [], FS);
[good_2, ~] = periodogram(s2h_original(:, 2).', [], [], FS);

figure;
subplot(2,1,1);
hold on;
stem(f, bad_1, 'r', 'Marker', 'None');
stem(f, good_1, 'Marker', 'None');
hold off;
    xlim([0 2500]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    legend('Corrupted recording', 'Clean recording');
    title('Periodogram for the left channel: a clean recording and the corrupted');
    
subplot(2,1,2);
hold on;
stem(f, bad_2, 'r', 'Marker', 'None');
stem(f, good_2, 'Marker', 'None');
hold off;
    xlim([0 2500]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    legend('Corrupted recording', 'Clean recording');
    title('Periodogram for the right channel: a clean recording and the corrupted');

% Let's try some spectral subtraction to see if we can spot the ticks
figure;
subplot(3,1,1);
stem(f, bad_1 - good_1, 'Marker', 'None');
    xlim([0 2500]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Spectrally subtracted left channel- corrupted signal');
    
    
subplot(3,1,2);
stem(f, bad_2 - good_2, 'Marker', 'None');
    xlim([0 2500]);
    grid on;
    ylabel('Power');
    xlabel('Frequency /Hz');
    title('Spectrally subtracted right channel- corrupted signal');

        
subplot(3,1,3);
stem(f, bad_2 - good_2, 'Marker', 'None');
    xlim([0 2500]);
    grid on;
    ylabel('Power');
    xlabel('Frequency /Hz');
    title('Spectrally subtracted right channel- corrupted signal');
    
%% 5.3

% Let's start with the 1500Hz tick. Split in case we want to 
[b1_1500, a1_1500] = butter(3, [1440/(FS/2), 1560/(FS/2)], 'stop');
[b2_1500, a2_1500] = butter(3, [1440/(FS/2), 1560/(FS/2)], 'stop');

% And the 200Hz tick
[b2_200, a2_200] = butter(3, [180/(FS/2), 220/(FS/2)], 'stop');

% Plot what the frequency response looks like
figure;
subplot(2,1,1);
[h, w] = freqz(b1_1500, a1_1500, 8192);
plot(w*FS/(2*pi), abs(h).^2);
    xlim([0 2500]);
    xlabel('Frequency');
    ylabel('Gain');
    title('1500Hz Butterworth Bandstop filter');
    grid on;

subplot(2,1,2);
[h, w] = freqz(b2_200, a2_200, 8192);
plot(w*FS/(2*pi), abs(h).^2);
    xlim([0 2500]);
    xlabel('Frequency');
    ylabel('Gain');
    title('200Hz Butterworth Bandstop filter');
    grid on;

% Let's actually do some filtering
filtered_1 = filter(b1_1500,a1_1500, s2h(:,1));

filtered_2 = s2h(:,2);
filtered_2 = filter(b2_200, a2_200, filtered_2);
filtered_2 = filter(b2_1500, a2_1500, filtered_2);

sound(filtered_2, FS)


%% 5.4

[filtered_1_pgm, f] = periodogram(filtered_1.', [], [], FS);
[filtered_2_pgm, ~] = periodogram(filtered_2.', [], [], FS);

figure;
subplot(2,3,1);
stem(f, good_1, 'Marker', 'none');
    xlim([0 2000]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Channel 1 Clean Signal');

subplot(2,3,2);
stem(f, bad_1, 'Marker', 'none', 'Color', 'r');
    xlim([0 2000]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Channel 1 Corrupted Signal');

subplot(2,3,3);
stem(f, filtered_1_pgm, 'Marker', 'none', 'Color', 'g');
    xlim([0 2000]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Channel 1 Filtered Signal');


subplot(2,3,4);
stem(f, good_2, 'Marker', 'none');
    xlim([0 2000]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Channel 2 Clean Signal');

subplot(2,3,5);
stem(f, bad_2, 'Marker', 'none', 'Color', 'r');
    xlim([0 2000]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Channel 2 Corrupted Signal');

subplot(2,3,6);
stem(f, filtered_2_pgm, 'Marker', 'none', 'Color', 'g');
    xlim([0 2000]);
    grid on;
    xlabel('Frequency /Hz');
    ylabel('Power');
    title('Channel 2 Filtered Signal');
    
error_1 = rel_error(good_1, filtered_1_pgm);

error_2 = rel_error(good_2, filtered_2_pgm);
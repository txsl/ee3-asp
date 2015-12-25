close all; clear; clc;

load('vinyl.mat');

%% 5.5 - testing final parameters

u = 1;
p = 8;


[bad_1, f] = periodogram(um(:, 1).', [], [], FS);
[bad_2, ~] = periodogram(um(:, 2).', [], [], FS);

[good_1, f] = periodogram(um_original(:, 1).', [], [], FS);
[good_2, ~] = periodogram(um_original(:, 2).', [], [], FS);

[ y1, a1, e1 ] = my_nlms(um(:, 1), um_original(:, 1), u, p);
[ y2, a2, e2 ] = my_nlms(um(:, 2), um_original(:, 2), u, p);

[filtered_1_pgm, f] = periodogram(y1, [], [], FS);
[filtered_2_pgm, f] = periodogram(y2, [], [], FS);



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


figure;
plot(a1.')
    title('Filter Coefficients for duration of track');
    xlabel('Sample number');
    ylabel('Estimated Value');
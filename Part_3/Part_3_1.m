close all; clear; clc;

%% 3.1.1

% Generate our WGN
x = randn(1,1024);

% Generate the starting point of the sum of our 8 windows
total = zeros(128,1);
stddev = zeros(8,1);

for i = 1:8
    
    % This variable 'point' is used to define where to take the window
    point = 128*(i-1);
    
    % take the psd from our current set of 128 values
    ps = pgm(x(point+1:point+128));
    
    % take the standard deviation to compare against the averaged
    % periodogram
    stddev(i) = std(ps);
    
    % Add them to the total (for use later)
    total = total + ps;
    
    % plot the results
    subplot(2,4,i);
    stem(ps, 'Marker', 'none');
        xlim([0 128]);
        xlabel('Frequency Bin');
        ylabel('Magnitude');
        t = sprintf('PSD of WGN, Window %i',i);
        title(t);
    
end

%% 3.1.2

% Plot the total/8 (ie the mean of each bin)
figure;

avstddev = std(total/8);

stem(total/8, 'Marker', 'none')
    xlim([0 128]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    title('Averaged Periodogram');
    
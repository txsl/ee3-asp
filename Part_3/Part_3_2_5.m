close all; clear; clc;

load('sunspot.dat')
sunspotdata = sunspot(:, 2);

%% 3.2.5

% Create the zero mean version of the data
zms = sunspotdata - mean(sunspotdata);

% Take the periodogram of our sunspot data
ssp = pgm(sunspotdata.');
zmssp = pgm(zms.'); % nb the periodograms should be the same regardless of zero mean. But in case they are not..

% Initialise our loop counting value
k = 1;

for i = [ 2, 9, 15 ] % <- our chosen Model Orders to test
    
    % Find the coefficients and compute the PSD. Same length as the sunspot
    % data
	[pxx, w] = pyulear(sunspotdata, i, 288);
    
    % Now plot the results (overlay with the Periodogram)
    subplot(2,3,k)
        hold on;
        plot(w/(2*pi), ssp(1:145));
        plot(w/(2*pi), pxx, 'r');
        hold off;
        xlim([0 0.25]); % Set this limit to view the area of interest
        xlabel('Normalised Frequency');
        ylabel('PSD (Magnitude)');
        t = sprintf('Sunspot estimation for AR(%i) process',i);
        title(t);
        legend('Sunspot Periodogram', 'Theoretical PSD')
        grid on;


    % Now for the zero mean version 
    [pxx, w] = pyulear(zms, i, 288);
   
    subplot(2,3,k+3)
        hold on;
        plot(w/(2*pi), zmssp(1:145));
        plot(w/(2*pi), abs(pxx), 'r'); % Theoretical PSD
        hold off;
        xlim([0 0.25]);
        xlabel('Normalised Frequency');
        ylabel('PSD (Magnitude)');
        t = sprintf('Zero Mean Sunspot estimation for AR(%i) process',i);
        title(t);
        legend('Sunspot Periodogram', 'Theoretical PSD')
        grid on;
    
    % Increment our loop counter, used for subplot indexing
    k = k + 1;

end
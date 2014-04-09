%% 3.2.5

close all; clear; clc;

load('sunspot.dat')
sunspotdata = sunspot(:, 2);
wgn = randn(1,1064);

k = 1;

for i = [ 2, 9, 15 ]
    coeffs = aryule(sunspotdata, i);
    [theor, w] = freqz(1, coeffs, 512);

    y = filter(1, coeffs, wgn);
    y = y(41:end);
    fout = pgm(y);
    
    subplot(2,3,k)
        hold on;
        plot(w/(2*pi), fout(1:512));
        plot(w/(2*pi), abs(theor).^2, 'r');
        hold off;
        xlabel('Normalised Frequency');
        ylabel('PSD (Magnitude)');
        t = sprintf('Sunspot estimation for AR(%i) process',i);
        title(t);
        legend('Sunspot Periodogram', 'Theoretical PSD')
        grid on;


    % Now for the zero mean version
    sm = mean(sunspotdata);
    zms = sunspotdata - sm;
    
    coeffs = aryule(zms, i);
    [theor, w] = freqz(1, coeffs, 512);

    y = filter(1, coeffs, wgn);
    y = y(41:end);
    fout = pgm(y);
    
    subplot(2,3,k+3)
        hold on;
        plot(w/(2*pi), fout(1:512)); % Periodogram
        plot(w/(2*pi), abs(theor).^2, 'r'); % Theoretical PSD
        hold off;
        xlabel('Normalised Frequency');
        ylabel('PSD (Magnitude)');
        t = sprintf('Zero Mean Sunspot estimation for AR(%i) process',i);
        title(t);
        legend('Sunspot Periodogram', 'Theoretical PSD')
        grid on;
        
    k = k + 1;

end
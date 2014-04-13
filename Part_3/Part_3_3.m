close all; clear; clc;

% This part of the project makes use of Mike Brookes' excellent VOICEBOX
% library. See link below for more details.

% web('http://j.mp/dmb_voicebox');

% Voicebox must be in the root of the project directly for this script to
% function correctly
path(path, '../voicebox');

%% 3.3.1

% A trial, know number was used at first to test against a known sound
% 0207 594 6271
% number = [ 0 2 0 7 5 9 4 6 2 7 1 ];

% We add a random 8 numbers. Multiplied by 9 so as to avoid 10 in the
% sequence as one number.
number = [ 0 2 0 round(rand(1,8)*9)];

% Set our sampling frequency
Fsamp = 32768;

% We define the different horizontal and vertical frequencies here
fh1 = 697; fv1 = 1209;
fh2 = 770; fv2 = 1336;
fh3 = 852; fv3 = 1477;
fh4 = 941;

% Now we define which numbers map to which pair of frequencies
freqs = [fh4 fv2; 
            fh1 fv1;
            fh1 fv2;
            fh1 fv3;
            fh2 fv1;
            fh2 fv2;
            fh2 fv3;
            fh3 fv1;
            fh3 fv2;
            fh3 fv3 ];
        

% ie half a second for each different tone        
N = .5*Fsamp;

% The number of samples in half an N (ie 250ms), time for the dial tone
n = 1:N/2;

% set up the variable which is the entire signal. 
% We subtract N/2 at the end since the last tone does not need a pause
% after it.
dial = zeros(1, (N*length(number)) - N/2); 

for i = 1:length(number)
    
    % Here for each time in the loop we get the necessary frequencies
    digit = number(i);
    tone = freqs(digit+1,:);
    f1 = tone(1);
    f2 = tone(2);
    
    % Then we generate the tone itself. And divide by 2 for unit amplitude
    signal = (sin((2*pi*f1*n)/Fsamp) + sin((2*pi*f2*n)/Fsamp))/2;
    
    % We add this signal in to the correct place in the entire 
    dial(((i*N) - N)+1:((i*N)-N/2)) = signal;
end

% Play the number to be dialled
% sound(dial.', Fsamp);

% Let's look at the entire signal
plot((1:length(dial))/Fsamp, dial)
    xlim([0 5.25])
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    number_s = sprintf('%d', number);
    regexprep(number_s,'\W','')
    t = sprintf('London DMTF Number %s being dialled', number_s);
    title(t);
    grid on;
    
% Now we can look at two particular instances and numebrs
figure;
subplot(1,2,1);
plot((1:length(dial))/Fsamp, dial)
    xlim([0 5.25])
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    title('0 tone, then deadtime');
    xlim([.24 .255]);
    grid on;
    
subplot(1,2,2);
plot((1:length(dial))/Fsamp, dial)
    xlim([0 5.25])
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    title('Deadtime, then 2 tone');
    xlim([.49 .52]);
    grid on;
  
    
%% 3.3.2


figure;

subplot(1,2,1);
spgrambw(dial, Fsamp, 'pJcwD', 200, 2000, 20);

subplot(1,2,2);
spgrambw(dial(1:2*N), Fsamp, 'pJcwD', 200, 2000, 20);

% We can look at the particular difference between the 0 and 2 keys

% Take the FFT
y0 = fft(dial(1:N), N)/N;
y2 = fft(dial(N+1:2*N), N)/N;

% Figure out the spacing on the frequency spectrum
f = ((Fsamp)*(1:N))/N;

% plot
figure;
plot(f, abs(y0), 'r', f, abs(y2));
    grid on;
    xlim([0 2500]);
    xlabel('Frequency [Hz]');
    ylabel('Magnitude');
    title('FFT of the 0 and 2 DTMF tone');
    legend('0 Spectra', '2 Spectra');
    
    
    
%% 3.3.4

% length of the entire number being dialled
len = length(dial);

% Different variance valeus to experiment with
var_coeffs = [.5 1.2 6];

% Save a copy of the clean sample to be able to reset the data with
clean_dial = dial;

figure;

for i = 1:3
    
    % Start with clean data
    dial = clean_dial;
    
    % Now add WGN, with variance defined from the vector above
    dial = dial + var_coeffs(i)*randn(1, len);
    
    % Plot the spectrogram of the signal
    subplot(2,3,i)
        spgrambw(dial, Fsamp, 'pJcwD', 200, 2000, 20);
        t = sprintf('Additional Noise \\sigma_1= %d',var_coeffs(i));
        title(t);
    
    % Repeat the analysis for looking at the freq of the 0 and 2 tone
%     y0 = fft(dial(1:N), N)/N;
%     y2 = fft(dial(N+1:2*N), N)/N;
    y0 = pgm(dial(1:N));
    y2 = pgm(dial(N+1:2*N));
    

    % plot
    subplot(2,3,i+3)
    plot(f, abs(y0), 'r', f, abs(y2));
        grid on;
        xlim([0 2500]);
        xlabel('Frequency [Hz]');
        ylabel('Magnitude');
        title('Periodogram of the 0 and 2 DTMF tone');
        legend('0 Spectra', '2 Spectra');
    
end

% Play the dial tone with the most noise. If you like white noise, you'll
% like this.
% sound(dial, Fsamp);


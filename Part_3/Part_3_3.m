close all; clear; clc;
path(path, '../voicebox');


%% 3.3.1
% 0207 594 6271

number = [ 0 2 0 7 5 9 4 6 2 7 1 ];

Fsamp = 32768;
nyq = (Fsamp/2)- 1;

fh1 = 697; fv1 = 1209;
fh2 = 770; fv2 = 1336;
fh3 = 852; fv3 = 1477;
fh4 = 941;

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

n = 1:N/2; % The number of 
dial = zeros(1, (N*length(number)) - N/2);

for i = 1:length(number)
    
    digit = number(i);
    tone = freqs(digit+1,:);
    f1 = tone(1);
    f2 = tone(2);
    
    signal = (sin((2*pi*f1*n)/Fsamp) + sin((2*pi*f2*n)/Fsamp))/2;
    dial(((i*N) - N)+1:((i*N)-N/2)) = signal;
end

sound(dial.', Fsamp);

plot((1:length(dial))/Fsamp, dial)
    xlim([0 5.25])
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    title('London DMTF Number being dialled');
    grid on;
    
figure;
subplot(2,1,1);
plot((1:length(dial))/Fsamp, dial)
    xlim([0 5.25])
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    title('0 dialtone, then deadtime');
    xlim([.23 .255]);
    grid on;
    
subplot(2,1,2);
plot((1:length(dial))/Fsamp, dial)
    xlim([0 5.25])
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    title('Deadtime, then 5 dialtone');
    xlim([1.99 2.01]);
    grid on;
  
    
%% 3.3.2

figure;
spgrambw(dial, Fsamp, 'pJcwD', 200, 2000, 20);

% figure;
% [t, f, p] = spgrambw(dial(1:N), Fsamp, 'pJcw', 200, 2000, 20);

figure;
% plot(f, p)

y0 = fft(dial(1:N), N)/N;
y2 = fft(dial(N+1:2*N), N)/N;

f = ((Fsamp)*(1:N))/N;

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
var_coeffs = [.5 1.2 3];
clean_dial = dial;


for i = 1:3
    dial = clean_dial;
    dial = dial + var_coeffs(i)*randn(1, len);
    
    subplot(2,3,i)
        spgrambw(dial, Fsamp, 'pJcwD', 200, 2000, 20);
        t = sprintf('Additional Noise \\sigma_1= %f',var_coeffs(i));
        title(t);
    
    y0 = fft(dial(1:N), N)/N;
    y2 = fft(dial(N+1:2*N), N)/N;
    
    subplot(2,3,i+3)
    plot(f, abs(y0), 'r', f, abs(y2));
        grid on;
        xlim([0 2500]);
        xlabel('Frequency [Hz]');
        ylabel('Magnitude');
        title('FFT of the 0 and 2 DTMF tone');
        legend('0 Spectra', '2 Spectra');
    
end
sound(dial, Fsamp);


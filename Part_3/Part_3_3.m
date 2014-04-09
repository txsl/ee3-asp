close all; clear; clc;


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
plot(dial)

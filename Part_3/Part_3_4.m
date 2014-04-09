close all; clear; clc;
path(path, '../voicebox');

Fsamp = 32768;
N = .25*Fsamp;
n = 1:N;

three_tone = (sin(697*2*pi*n/Fsamp) + sin(1477*2*pi*n/Fsamp))/2;
star_tone = (sin(941*2*pi*n/Fsamp) + sin(1209*2*pi*n/Fsamp))/2;

var_coeffs = [.5 1.2 3];

three_noise = zeros(3, N);
star_noise = zeros(3, N);

for i = 1:3
    three_noise(i,:) = three_tone + var_coeffs(i)*randn(1,N);
    star_noise(i,:) = star_tone + var_coeffs(i)*randn(1,N);    
end


three_error = zeros(3,100);
star_error = zeros(3,100);

for i = 1:3
    for k = 1:100
        [params E] = aryule(three_noise(i,:),k); 
        three_error(i,k) = E;
        [params E] = aryule(star_noise(i,:),k); 
        star_error(i,k) = E;
    end
end



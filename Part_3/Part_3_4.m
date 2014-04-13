close all; clear; clc;
path(path, '../voicebox');

Fsamp = 32768;
N = .25*Fsamp;
n = 1:N;

% Set up the actual signals
three_tone = (sin(697*2*pi*n/Fsamp) + sin(1477*2*pi*n/Fsamp))/2;
star_tone = (sin(941*2*pi*n/Fsamp) + sin(1209*2*pi*n/Fsamp))/2;

% The different variances 
var_coeffs = [.5 1.2 3];

three_noise = zeros(3, N);
star_noise = zeros(3, N);

% Different vectors of the different noise levels
for i = 1:3
    three_noise(i,:) = three_tone + var_coeffs(i)*randn(1,N);
    star_noise(i,:) = star_tone + var_coeffs(i)*randn(1,N);    
end


three_error = zeros(3,100);
star_error = zeros(3,100);

% Working out the MDL error for both tones, and for the three
% different noise levels
for i = 1:3
    for k = 1:100
        [~, E] = aryule(three_noise(i,:),k); 
        three_error(i,k) = log(E) + (k*log(N)/N);
        
        [~, E] = aryule(star_noise(i,:),k); 
        star_error(i,k) = log(E) + (k*log(N)/N);
    end
end


% Now we can our errors to work out which order model to use
for i = 1:3
    subplot(2,3,i);
    plot(1:100, three_error(i,:));
        xlabel('Model Order');
        ylabel('Model Error');
        grid on;
        title(sprintf('MLD Estimate for "three" tone with \\sigma=%1.1f', var_coeffs(i)));
    
    subplot(2,3,i+3);
    plot(1:100, star_error(i,:));
        xlabel('Model Order');
        ylabel('Model Error');
        grid on;
        title(sprintf('MLD Estimate for "star" tone with \\sigma=%1.1f', var_coeffs(i)));
end

% These are the chosen model orders (based on the MLD plots)
three_order = [ 45 42 42 ];
star_order = [ 18 18 38 ];

% Now we populate the arrays of filter parameters
for i = 1:3
    mo = three_order(i);
    three_params(i,1:mo+1) = aryule(three_noise(i,:), mo);
    
    mo = star_order(i);
    star_params(i,1:mo+1) = aryule(star_noise(i,:), mo);
end


figure;
for i = 1:3
   params = three_params(i,:);
   [ theor, w ]= freqz(1, params, 512);
   
   subplot(2,3,i);
   plot(w/(2*pi), abs(theor));
   grid on;
        xlabel('Normalised Frequency');
        ylabel('Magnitude');
        title(sprintf('AR Process for "three" tone with \\sigma=%1.1f', var_coeffs(i)));
        
   
   params = star_params(i,:);
   [ theor, w ]= freqz(1, params, 512);
   
   subplot(2,3,i+3);
   plot(w/(2*pi), abs(theor));
   grid on;
        xlabel('Normalised Frequency');
        ylabel('Magnitude');
        title(sprintf('AR Process for "star" tone with \\sigma=%1.1f', var_coeffs(i)));
end



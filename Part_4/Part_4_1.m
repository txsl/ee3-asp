close all; clear; clc;

%% 4.1.1

% Since this is a 4th order filter
Nw = 4;

% Generate our random sequence
x = randn(1,1000);

% Filter it with the given coefficients
y = filter([1, 2, 3, 2, 1], 1, x);

% Add more white noise to create z
n = 0.1*randn(1,1000);
z = y + n;

% Time to start cross correlating
R_zx = xcorr(z, x, 'unbiased');

% Readying the p_zx vector
p_zx = zeros(Nw, 1);

% Populating it from the centre of the correlation
for i = 1:Nw+1
    p_zx(i) = R_zx(999+i);
end

% Autocorrelation of x
r_xx = xcorr(x, 'unbiased');

% we are using a toeplitz matrix, and MATLAB has a function to make it
% easier
R_xx = toeplitz(r_xx(1000:1000+Nw));
 
% Now we find our w_opt values
w_opt = inv(R_xx)*p_zx;

stored_snr = 10*log(var(z)/0.1);
my_snr = snr(y, n);

%% 4.1.2

% Let's experiment with double the necessary cofficients
p_zx = zeros(2*Nw, 1);

for k = 1:2*Nw+1
    p_zx(k) = R_zx(999+k);
end

R_xx = toeplitz(r_xx(1000:1000+(2*Nw)));    

double_w_opts = inv(R_xx)*p_zx;
    

Nw = 4;

%Vector of noise variance to experiment with
variance = [ 0.5, 1, 3, 6, 8, 10];

% Matrices ready to store data in
recorded_snr = zeros(1,6);
w_opts = zeros(6,Nw+1);

for i = 1:6
    
    x = randn(1,1000);
    y = filter([1, 2, 3, 2, 1], 1, x);

    
    n = (variance(i))*randn(1,1000);
    z = y + n;
    
    R_zx = xcorr(z, x, 'unbiased');
    p_zx = zeros(Nw, 1);

    for k = 1:Nw+1
        p_zx(k) = R_zx(999+k);
    end
    
    % Autocorrelation of x
    r_xx = xcorr(x, 'unbiased');
    R_xx = toeplitz(r_xx(1000:1000+Nw));

    % Now we find our w_opt values
    w_opts(i,:) = inv(R_xx)*p_zx;

    recorded_snr(i) = snr(y, n);
    
end


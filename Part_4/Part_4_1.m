close all; clear; clc;

%% 4.1.1

% Since this is a 4th order filter
Nw = 4;

% Generate our random sequence
x = randn(1,1000);

% Filter it with the given coefficients
y = filter([1, 2, 3, 2, 1], 1, x);

% Add more white noise to create z
z = y + 0.1*randn(1,1000);

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

snr = 10*log(var(z)/0.1);

%% 4.1.2

variance = [ 0.5, 1, 3, 6, 8, 10];
snr = zeros(1,6);
w_opts = zeros(6,5);

for i = 1:6
    % Since this is a 4th order filter
    Nw = 4;

    % Generate our random sequence
    x = randn(1,1000);

    % Filter it with the given coefficients
    y = filter([1, 2, 3, 2, 1], 1, x);

    % Add more white noise to create z
    z = y + variance(i)*randn(1,1000);

    % Time to start cross correlating
    R_zx = xcorr(z, x, 'unbiased');

    % Readying the p_zx vector
    p_zx = zeros(Nw, 1);

    % Populating it from the centre of the correlation
    for k = 1:Nw+1
        p_zx(k) = R_zx(999+k);
    end

    % Autocorrelation of x
    r_xx = xcorr(x, 'unbiased');

    % we are using a toeplitz matrix, and MATLAB has a function to make it
    % easier
    R_xx = toeplitz(r_xx(1000:1000+Nw));

    % Now we find our w_opt values
    w_opts(i,:) = inv(R_xx)*p_zx;

    snr(i) = 10*log(var(z)/variance(i));
end
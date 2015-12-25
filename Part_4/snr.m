function [ snr ] = snr(sig, noise)
%Returns the SNR of a given signal and noise

% Compute the mean of the power of each signal
Psig = mean(sig.^2);
Pnoise = mean(noise.^2);

% Compute the SNR
snr = 10*log(Psig/Pnoise);


end


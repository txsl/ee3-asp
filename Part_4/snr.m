function [ snr ] = snr(sig, noise)
%Returns the SNR of a given signal and noise

N = length(sig);

Psig = mean(sig.^2);
Pnoise = mean(noise.^2);

snr = 10*log(Psig/Pnoise);


end


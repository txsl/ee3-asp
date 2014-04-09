close all; clear; clc;

[h,w] = freqz([1], [1 0.9], 512);
plot(w/(2*pi),abs(h).^2)
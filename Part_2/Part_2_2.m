clear all; close all;

x = randn(1, 1000);
y = filter(ones(9,1),[1],x);
ycorr = xcorr(y, 'unbiased');
figure;
stem(-20:20, ycorr(980:1020))

% Part 3

xycorr = xcorr(x, y, 'unbiased');

figure;
stem(-20:20, xycorr(980:1020))
figure;
stem(xycorr)
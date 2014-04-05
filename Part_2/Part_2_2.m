clear all; close all;

x = randn(1, 1000);
y = filter(ones(9,1),[1],x);
figure;
stem(xcorr(y, 'unbiased'))
zoom xon
zoom(50)
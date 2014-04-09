close all; clear all; clc;

M = 4;
N = 1000;

a = rp1(M,N);
assignin('base', 'a', a)
plot(mean(a))
figure;
b = rp2(M,N);
assignin('base', 'b', b)
plot(mean(b))
figure;
c = rp3(M,N);
assignin('base', 'c', c)
plot(mean(c))
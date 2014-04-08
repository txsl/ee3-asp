close all; clear; clc;

x = randn(1, 128);
p = pgm(x);
stem(p)
xlim([0 128]);

x = randn(1, 256);
p = pgm(x);
stem(p)
xlim([0 256]);

x = randn(1, 512);
p = pgm(x);
stem(p)
xlim ([0 512]);

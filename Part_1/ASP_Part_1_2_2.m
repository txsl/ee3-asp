close all; clear all; clc;

%% 1.2.2

M = 4;
N = 1000;

% rp1
a = rp1(M,N);
ma = mean(a.');
sa = std(a.');

% rp2
b = rp2(M,N);
mb = mean(b.');
sb = std(b.');

% rp3
c = rp3(M,N);
mc = mean(c.');
sc = std(c.');
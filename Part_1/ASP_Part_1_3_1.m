close all; clear all; clc;

%% 1.3.1

% Generate 500 random samples of WGN
v = randn(1, 500);

% Run it through the newly written pdf function
pdf(v);
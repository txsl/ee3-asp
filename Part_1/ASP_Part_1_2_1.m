close all; clear all; clc;

M = 1000;
N = 100;

%% Function RP1
subplot(2,3,1);
a = rp1(M,N);
plot(mean(a));
title('Mean for Process rp1');
xlabel('n');
ylabel('Mean amplitude');

subplot(2,3,4);
plot(std(a));
title('Standard Deviation for Process rp1');
xlabel('n');
ylabel('Standard deviation amplitude');

%% Function RP2
subplot(2,3,2);
b = rp2(M,N);
plot(mean(b));
title('Mean for Process rp2');
xlabel('n');
ylabel('Mean amplitude');

subplot(2,3,5);
plot(std(b));
title('Standard Deviation for Process rp2');
xlabel('n');
ylabel('Std dev amplitude');

%% Function RP3

subplot(2,3,3);
c = rp3(M,N);
plot(mean(c));
title('Mean for Process rp3');
xlabel('n');
ylabel('Mean amplitude');

subplot(2,3,6);
plot(std(b));
title('Standard Deviation for Process rp3');
xlabel('n');
ylabel('Standard Deviation amplitude');
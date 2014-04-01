close all;
clear;

x = rand(1000, 1);
% scatter(1:1000, x)
xlabel('Sample Number')
ylabel('Value')

m = mean(x(:,1))
s = std(x(:,1))

x = rand(1000, 10);

a = rand(1000,10);
m = zeros(10,1);
s = zeros(10,1);


m = mean(a);
s = std(a);

B = 0.5 - m

figure;
bar(1:10, m);
title('Mean')
hlin = refline(0,0.5)
set(hlin,'Color','r')
figure;
bar(1:10, s);
title('Standard Deviation');

figure;
a = hist(x(:,1));
a = a/1000
bar(a)

figure;
a = hist(x(:,1), 100);
a = a/1000
bar(a)
xlim([0 101])

figure
a = hist(x(1:100,1), 10);
a = a/100
bar(a)
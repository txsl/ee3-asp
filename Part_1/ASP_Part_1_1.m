close all;
clear;

X = rand(1000, 1);
% scatter(1:1000, x)
xlabel('Sample Number')
ylabel('Value')

m = mean(X(:,1))
s = std(X(:,1))

X = rand(1000, 10);

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
a = hist(X(:,1));
a = a/1000
bar(a)

figure;
a = hist(X(:,1), 100);
a = a/1000
bar(a)
xlim([0 101])

figure
a = hist(X(1:100,1), 10);
a = a/100
bar(a)



X = randn(1000, 1);
mean(X)
std(X)

X = randn(1000, 10);
m = mean(X);
s = std(X);

figure;
bar(m)

figure;
bar(s)
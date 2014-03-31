x = rand(1000, 1);
scatter(1:1000, x)
figure
plot(1:1000, x)
xlabel('Sample Number')
ylabel('Value')

mean = mean(x(:,1));
std = std(x(:,1));

x = rand(1000, 10);

a = rand(1000,10);
m = zeros(10,1);
s = zeros(10,1);

for i=1:10,
    m(i) = mean(a(:,i));
    s(i) = std(a(:,i));
end
figure;
scatter(1:10, m);
title('Mean')
figure;
scatter(1:10, m);
title('Standard Deviation');
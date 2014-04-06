clear all; close all;

a1 = -2.5 + 5*rand(1000,1);
a2 = -1.5 + 3*rand(1000,1);

a1stable = [];
a2stable = [];

for i = 1:length(a1)
    w = randn(1000, 1);
    x = zeros(1000, 1);
    x(1) = w(1);
    x(2) = w(2);
    for j = 3:1000
        x(j) = a1(i)*x(j-1) + a2(i)*x(j-2);
    end
    if(abs(x(1000)) < 10)
        a1stable = [a1stable a1(i)];
        a2stable = [a2stable a2(i)];
    end
end

plot(a1stable, a2stable, '*')



% a1 = -2.5:0.1:2.5;
a2 = -1.5:0.01:1.5;

a1stable = [];
a2stable = [];

for i = -2.5:0.01:2.5
    for k = 1:length(a2)
        w = randn(1000, 1);
        x = zeros(1000, 1);
        x(1) = w(1);
        x(2) = w(2);
        for j = 3:1000
            x(j) = i*x(j-1) + a2(k)*x(j-2);
        end
        if(abs(x(1000)) < 1000)
            a1stable = [a1stable i];
            a2stable = [a2stable a2(k)];
        end
    end
end

figure;
plot(a1stable, a2stable, '*')
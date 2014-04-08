%%  2.4.5

load('sunspot.dat')
sunspotdata = sunspot(:, 2);

a1 = aryule(sunspotdata,1);
a2 = aryule(sunspotdata,2);
a10 = aryule(sunspotdata,10);

for i = 2:length(a1)
    a1(i) = -a1(i);
end
for i = 2:length(a2)
    a2(i) = -a2(i);
end
for i = 2:length(a10)
    a10(i) = -a10(i);
end

x1 = sunspotdata(1:10);
x2 = sunspotdata(1:10);
x3 = sunspotdata(1:10);
x10 = sunspotdata(1:10);
actual = sunspotdata(1:20);
 
for i = 1:10
    x1(i+10) = a1(2)*x1(i+9);
    x2(i+10) = a2(2)*x2(i+9) + a2(3)*x2(i+8);
    x10(i+10) = a10(2)*x10(i+9) + a10(3)*x10(i+8) + a10(4)*x10(i+7) + a10(5)*x10(i+6) + a10(6)*x10(i+5) + a10(7)*x10(i+4) + a10(8)*x10(i+3) + a10(9)*x10(i+2) + a10(10)*x10(i+1) + a10(11)*x10(i);
end


figure;
hold on;
plot(x1);
plot(x2, 'c');
plot(x10, 'g');
plot(actual, 'r');
grid on;
legend('AR(1)', 'AR(2)', 'AR(10)', 'Actual', 'Location', 'North');
xlim([1 20]);
xlabel('Years');
ylabel('No of Sunspots');
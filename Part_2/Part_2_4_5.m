clear all; close all; clc;

load('sunspot.dat')
sunspotdata = sunspot(:, 2);

%%  2.4.5

% Take different order Yule Walker processes
a1 = aryule(sunspotdata,1);
a2 = aryule(sunspotdata,2);
a10 = aryule(sunspotdata,10);

% Due to the way MATLAB deals with filters, we have to sign reverse the
% coefficients before we can start (starting from 2 because coefficient 1 is always 1).
for i = 2:length(a1)
    a1(i) = -a1(i);
end
for i = 2:length(a2)
    a2(i) = -a2(i);
end
for i = 2:length(a10)
    a10(i) = -a10(i);
end

% We give our models the first 10 sets of data (or less for x1 and x2), but
% start from 10 and work back, so we can compare them all at the same point

x1 = sunspotdata(1:10);
x2 = sunspotdata(1:10);
x3 = sunspotdata(1:10);
x10 = sunspotdata(1:10);
actual = sunspotdata(1:20);

% In this for loop we apply our filters to the series of data

for i = 1:10
    x1(i+10) = a1(2)*x1(i+9);
    x2(i+10) = a2(2)*x2(i+9) + a2(3)*x2(i+8);
    x10(i+10) = a10(2)*x10(i+9) + a10(3)*x10(i+8) + a10(4)*x10(i+7) + a10(5)*x10(i+6) + a10(6)*x10(i+5) + a10(7)*x10(i+4) + a10(8)*x10(i+3) + a10(9)*x10(i+2) + a10(10)*x10(i+1) + a10(11)*x10(i);
end


figure;
hold on;
range = -9:10;
plot(range, x1);
plot(range, x2, 'c');
plot(range, x10, 'g');
plot(range, actual, 'r');
hold off;
    grid on;
    legend('AR(1)', 'AR(2)', 'AR(10)', 'Actual', 'Location', 'North');
    xlim([-9 10]);
    xlabel('Prediction Horizon (Years)');
    ylabel('No of Sunspots');
    title('Actual and Estimated Sunspots, based on varying order AR models');
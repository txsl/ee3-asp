close all; clear; clc;

x = randn(1,1024);

total = zeros(128,1);

for i = 1:8
    point = 128*(i-1);
    ps = pgm(x(point+1:point+128));
    total = total + ps;
    
    subplot(2,4,i);
    stem(ps);
    xlim([0 128]);
    xlabel('Frequency Bin');
    ylabel('Magnitude');
    t = sprintf('PSD of WGN, Window %i',i);
    title(t);
    
end

figure;
stem(total/8)
xlim([0 128]);
xlabel('Frequency Bin');
ylabel('Magnitude');
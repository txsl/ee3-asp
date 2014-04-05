function [] = pdf(v)
close all
hist(v,30)

figure;
[elements, centres] = hist(v, 30);

bar(centres, elements/length(v))
end


function [ d, bins ] = pdf(v)

% Use the histogram function to split the data in to 30 bins
[elements, centres] = hist(v, 30);

% Divide the different cumulatives by the number of samples
% This is what creates the 'density' rather than a histogram.
d = elements/length(v);
bins = centres;

% Now let's plot what we have computed
bar(bins, d, 'BarWidth', 1);
    xlabel('x');
    ylabel('Probability Density');

    
end


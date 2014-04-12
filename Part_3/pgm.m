function [ px ] = pgm( x )

% First get the length of our signal
N = length(x);

% This defines the series from 0/n, 1/n ... N-1/n used the the summing sequence 
% It's also transposed to set cur_exp in the correct dimension further down
% (which is in turn used to take an inner product).
frac = ((0:N-1)/N).';

% We prepare the matrix of results
px = zeros(N,1);

for i = 1:N
    
    % the frequency scales from 0 to N-1 (as a fraction)
    f = i-1/N;
    
    % we calculate a matrix of the coefficients from the frequency scaling
    cur_exp = exp(-1i*2*pi*f*frac);
    
    % Then multiplied with our signal, in an inner product multiplication
    sum = x*cur_exp;
    
    % Take the magnitude, and square the result
    res = (abs(sum))^2/N;
    
    % Save the result to the correct frequency bin
    px(i) = res;
end

end


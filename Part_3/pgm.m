function [ px ] = pgm( x )
%PGM Summary of this function goes here
%   Detailed explanation goes here

N = length(x);
frac = ((1:N)/N).';

px = zeros(N,1);

for i = 1:N
    f = i-1/N;
    cur_exp = exp(-1i*2*pi*f*frac);
    sum = x*cur_exp;
    res = (abs(sum))^2/N;
    px(i) = res;
end

end


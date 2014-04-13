function [ y, e, coeff_hist ] = lms( x, z, u, ord )

N = legnth(x);

x_prev = zeros(1,ord);
e = zeros(1,N)

coeff_hist = zeros(ord, N);

for i = ord+1:N
    x_prev = x(i-ord:i);
    y(i:i-ord) = *x;
    e(i-ord) = z(i-ord) - y(i-ord);
    
    
end


end


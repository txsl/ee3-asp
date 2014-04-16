function [ y, a, e ] = ar_est(x, u, ord)
% Function to estimate AR coefficients of a given model order and signal

%% INPUTS
% x: Filtered signal of unknown AR system
% u: adaptation gain
% ord: order of the system we are attempting to estimate parameters for

%% OUTPUTS
% y: the estimated output of the system
% a: the adaptive filter estimate, recorded at each iteration
% e: the error measured upon each iteration (given output - estimated)

N = length(x);

% Initialise our return variables
e = zeros(1,N);
y = zeros(1,N);

% We need space for all of the different coefficients, which is the order+1
a = zeros(ord,N);

% because this relies on historical data, we have to start at the index 
% of the model order we are estimating
for i = ord+1:N
    y(i) = a(:,i).'*x(i-1:-1:i-ord).';
    
    e(i) = x(i) - y(i); 
    
    a(:,i+1) = a(:,i) + u*e(i)*x(i-1:-1:i-ord).';
    
end

end


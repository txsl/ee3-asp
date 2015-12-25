function [ y_est, a, e ] = my_nlms(x, y, u, ord)
% Function to estimate AR coefficients of a given model order and signal
% called my_nlms to avoid clashing with MATLAB's nlms

%% INPUTS
% x: The original signal (the corrupted version)
% y: The good signal- the 'training' signal
% u: adaptation gain
% ord: order of the system we are attempting to estimate parameters for

%% OUTPUTS
% y_est: the estimated output of the system
% a: the adaptive filter estimate, recorded at each iteration
% e: the error measured upon each iteration (given output - estimated)

N = length(x);

% Initialise our return variables
e = zeros(1,N);
y_est = zeros(1,N);

% We need space for all of the different coefficients, which is the order+1
a = zeros(ord,N);

% because this relies on historical data, we have to start at the index 
% of the model order we are estimating
for i = ord+1:N
    y_est(i) = a(:,i).'*x(i-1:-1:i-ord);
    
    e(i) = y(i) - y_est(i); 

    if x(i-1:-1:i-ord).' == zeros(1,ord)
        a(:,i+1) = a(:,i) + u*e(i)*x(i-1:-1:i-ord);
    else
        a(:,i+1) = a(:,i) + u*e(i)*x(i-1:-1:i-ord)/norm(x(i-1:-1:i-ord))^2;
    end
end

end


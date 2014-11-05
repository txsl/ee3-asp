function [ w, w_sign_error, w_sign_reg, w_sign_sign ] = ar_est_signs( x, u, ord )
% This function computes estimated coefficients for a given signal
% adaptively, using least mean squares. It is also experimenting with
% different sign algorithms to reduce computational complexity

%% INPUTS
% x: Filtered signal of unknown AR system
% u: adaption gain
% ord: the order of the system we are attempting to estimate parameters for

%% OUTPUTS
% w: filter estimates, (each iteration), based on standard LMS algo
% w_sign_error: estimates based on sign - error algo
% w_sign_reg: estimates based on sign - regressor algo
% w_sign_sign: estimates based on sign - sign algo

%% The Function

N = length(x);

% Initialise our return variables
e = zeros(1,N);
e_sign_error = zeros(1,N);
e_sign_reg = zeros(1,N);
e_sign_sign = zeros(1,N);

y = zeros(1, N);
y_sign_error = zeros(1, N);
y_sign_reg = zeros(1, N);
y_sign_sign = zeros(1, N);

% We need space for all of the different coefficients, which is the order+1
w = zeros(ord,N);
w_sign_error = zeros(ord,N);
w_sign_reg = zeros(ord,N);
w_sign_sign = zeros(ord,N);


for i = ord+1:N
    
    % Note the use of -1 in the x vectors. This is to reverse their results,
    % in order to return the correct inner product (most recent
    % value times the lowest order coefficient value (ie b_0 * x(0), etc)

    % Compute the estimated y value
    y(i) = w(:,i).'*x(i-1:-1:i-ord).';
    y_sign_error(i) = w_sign_error(:,i).'*x(i-1:-1:i-ord).';
    y_sign_reg(i) = w_sign_reg(:,i).'*x(i-1:-1:i-ord).';
	y_sign_sign(i) = w_sign_sign(:,i).'*x(i-1:-1:i-ord).';
    
    % calculate the error (difference between actual and estimated)
    e(i) = x(i) - y(i);
    e_sign_error(i) = x(i) - y_sign_error(i);
    e_sign_reg(i) = x(i) - y_sign_reg(i);
    e_sign_sign(i) = x(i) - y_sign_sign(i);
    
    % Compute new w values based on the error and adaptation gain
    w(:,i+1) = w(:,i) +  u*e(i)*x(i-1:-1:i-ord).';
    w_sign_error(:,i+1) = w_sign_error(:,i) +  u*sign(e_sign_error(i))*x(i-1:-1:i-ord).';
    w_sign_reg(:,i+1) = w_sign_reg(:,i) +  u*e_sign_reg(i)*sign(x(i-1:-1:i-ord)).';
    w_sign_sign(:,i+1) = w_sign_sign(:,i) +  u*sign(e_sign_sign(i))*sign(x(i-1:-1:i-ord)).';
end


end
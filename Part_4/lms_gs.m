function [ y, e, w ] = lms_gs( x, z, umin, umax, ord )
% Modification of the lms function to incorporate basic gear shifting

%% INPUTS
% x: input vector of signal yet to be filtered by unknown system
% z: output of the unknown system (from x), plus WGN
% umin: adaptation gain to be used when we are converging on the steady state
% umax: adaptation gain to be used when quickly converging to steady state
% ord: the order of the system we are attempting to estimate parameters for

%% OUTPUTS
% y: the estimated output of the system
% e: the error measured upon each iteration (given output - estimated)
% w: the adaptive filter estimate, recorded at each iteration

%% The Function

N = length(x);

% Initialise our return variables
e = zeros(1,N);
y = zeros(1, N);

% We need space for all of the different coefficients, which is the order+1
w = zeros(ord+1,N);

% Set u to the maximum to start with
u = umax;

for i = ord+1:N
    
    % Note the use of -1 in the x vectors. This is to reverse their results,
    % in order to return the correct inner product (most recent
    % value times the lowest order coefficient value (eg b_0 * x(0), etc)
    
    % Compute the estimated y value
    y(i) = w(:,i).'*x(i:-1:i-ord).';
    
    % calculate the error (difference between actual and estimated)
    e(i) = z(i) - y(i);
    
    % Check if error is bigger or smaller than 15, and set u accordingly
    if (e(i)^2 > 15)
        u = umax;
    else
        u = umin;
    end

    % Compute new w values based on the error and adaptation gain
    w(:,i+1) = w(:,i) +  u*e(i)*x(i:-1:i-ord).';

end


end
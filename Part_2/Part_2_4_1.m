clear all; close all; clc;

%% 2.4.1

% define our a1 and a2 random processes
% The subtractions and multiplications provide the range and scaling needed
a1 = -2.5 + 5*rand(1000,1);
a2 = -1.5 + 3*rand(1000,1);

% Define some empty vectors to store our a1 and a2 values once we
% establish if they are stable or not
a1stable = [];
a2stable = [];
a1unstable = [];
a2unstable = [];

% for all of the length of the a1/a2 samples
for i = 1:length(a1)
    
    % our random process to filter
    w = randn(1000, 1);
    
    % where the output of our filter is going
    x = zeros(1000, 1);
    
    % the first two values need assinging so the process can start
    x(1) = w(1);
    x(2) = w(2);
    
    % Loop through to calculate our filtered signal
    for j = 3:1000
        x(j) = a1(i)*x(j-1) + a2(i)*x(j-2)+ w(j);
    end
    
    % to check if a series is convergent, we check to see if the absolute
    % value is greater than 10. If so, it is considered not convergent.
    
    % We then store the a1 and a2 pair of values in the appropriate vector
    if(abs(x(1000)) < 10)
        a1stable = [a1stable a1(i)];
        a2stable = [a2stable a2(i)];
    else
        a1unstable = [a1unstable a1(i)];
        a2unstable = [a2unstable a2(i)];
    end
    
end

% not plot the results
subplot (1,2,1);

plot(a1stable, a2stable, '^r')
hold on;
plot(a1unstable, a2unstable, '+')
hold off;

    legend('Convergent', 'Non-Convergent');
    xlabel('a1');
    ylabel('a2');
    title('Randomly generated processes to show the stability triangle');


%%% Now let's do the same again, but have uniformly distributed a1 and a2s.
    
%  We don't need to define a1 as we are using it built in to the 'for' loop
a2 = -1.5:0.1:1.5;

a1stable = [];
a2stable = [];
a1unstable = [];
a2unstable = [];

for a1 = -2.5:0.1:2.5 % this time the loop is running as our a1 coefficients
    
    for k = 1:length(a2) % and for each value of a1, we loop through all a2 values
        
        w = randn(1000, 1);
        x = zeros(1000, 1);
        
        x(1) = w(1);
        x(2) = w(2);
        
        for j = 3:1000
            x(j) = a1*x(j-1) + a2(k)*x(j-2) + w(j);
        end
        
        if(abs(x(1000)) < 10)
            a1stable = [a1stable a1];
            a2stable = [a2stable a2(k)];
        else
            a1unstable = [a1unstable a1];
            a2unstable = [a2unstable a2(k)];
        end
        
    end
end

% and plot the results
subplot (1,2,2);

plot(a1stable, a2stable, '^r')
hold on;
plot(a1unstable, a2unstable, '+')
hold off;

    legend('Convergent', 'Non-Convergent');
    xlabel('a1');
    ylabel('a2');
    title('Series generated processes to show the stability triangle');


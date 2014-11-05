close all; clear; clc;

load('vinyl.mat');

%% 5.5 Test different coefficients

pgm_good_1 = periodogram(s2h_original(:, 1), [], [], FS);
pgm_good_2 = periodogram(s2h_original(:, 2), [], [], FS);

ords = [1 2 5 8 10 15 ];
mus = [0.01 0.05 0.1 0.5 1];

for i = 1:length(ords)
   for k = 1:length(mus)
        
       [ y1, a1, e1 ] = my_nlms(s2h(:, 1), s2h_original(:, 1), mus(k), ords(i));
       [ y2, a2, e2 ] = my_nlms(s2h(:, 2), s2h_original(:, 2), mus(k), ords(i));
       
       [pgm_y1, f] = periodogram(y1, [], [], FS);
       [pgm_y2, f] = periodogram(y2, [], [], FS);
       
 
       er1 = rel_error(pgm_good_1, pgm_y1);
       er2 = rel_error(pgm_good_2, pgm_y2);
       
       er1_store(i, k) = er1;
       er2_store(i, k) = er2;
   end
end


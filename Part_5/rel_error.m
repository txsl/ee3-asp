function [ err ] = rel_error( clean_sig, est_sig )
%REL_ERROR Quick function to return the realtive error of 2 signals

 err = norm(clean_sig - est_sig)/norm(clean_sig);
 
end


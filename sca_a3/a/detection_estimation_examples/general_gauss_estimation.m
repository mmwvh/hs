clear all;
%estimating the template (mean_vector, Covariance matrix)

%the real parameters - which are unknown, yet we try to estimate them
mu=[ 4 5 6 ];
Sigma = [ 1.1 0.4 0.1 ; 0.4 1.2 0.5 ; 0.1 0.5 1]; 

%Experimental data generated from the real parameters

r = mvnrnd(mu,Sigma,100);

%The data consists of 3 POIs per trace, 100 traces in total

%Based on the experimental data, compute the template

mean_vector=mean(r);
cov_matrix=cov(r);
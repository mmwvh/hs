%univariate gaussian estimation using the method of maximum likelyhood 
%based on chapter 5 (Estimation) of Introduction to Mathematical statistics
%by Larsen-Marx

clear all;
close all;



iq=[62 164 75 138];

mu_e = mean(iq); % mu estimate
var_e = sum((iq-mu_e).^2)/length(iq); %variance estimate
std_e = power(var_e, 0.5); %standard deviation estimate


%Confidence interval for normal distribution parameter m (unknown), s known

alpha=0.01; %confidence level

mu = 0;
sigma = 1;
stdnorm = makedist('Normal',mu,sigma); % Z ~ N(0,1)

interval_left=mean(iq)-icdf(stdnorm,1-alpha/2) *std_e/sqrt(length(iq));
interval_right=mean(iq)+icdf(stdnorm,1-alpha/2) *std_e/sqrt(length(iq));
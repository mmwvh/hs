clear all;
close all;
%This code corresponds to chapter 2 of Harry van Trees book


% Binary Hypothesis testing for Univariate Gaussian distributions
% We focus on a single point of intererest
%We also assume that the attacker has extensively profiled the device so he
%has already formed 2 univariate gaussian distributions: 
%one for H0 (key0) and one for H1 (key1)


m0= 5;
var0=1.5;

m1=6.8;
var1=0.8;

%Plotting the two p.d.fs 
x = [0:.1:15];
F0= normpdf(x,m0,var0);
F1= normpdf(x,m1,var1);

plot(x,F0);hold on; plot(x,F1); hold on;

%Lets find the intersection of the two functions
focus=40:70;
[px py]=intersections(x(focus),F0(focus),x(focus),F1(focus),1);

point=plot(px,py,'.');
set(point,'Marker','square')


%Computing P_F, P_M, P_N, P_D
%We can also use the cummulative distribution function to compute the 
%Probability(x>=px) = P_F = 1-cdf(px) [try to remember the relation between
% the pdf and the cdf and how integration works]

cdf0 = normcdf(x,m0,var0);
%P_F is the area from (px, +infinity) for H0
P_F = 1-cdf0(find(x>px,1));

cdf1 = normcdf(x,m1,var1);
%P_M is the area (-infinity, px) for H1
P_M = cdf1(find(x>px,1));

%P_N is the area (-infinity,px) for H0
P_N= cdf0(find(x>px,1));
%also P_N=1-P_F

%P_D is the area (px,+infinity) for H1
P_D= 1-cdf1(find(x>px,1));
%also P_D=1-P_M


%Now, a new trace (single measurement) comes in and we need to decide if it verifies H0 or H1
test=6.1;
%COMPARISON
%First we compute the probability that it comes from H0
p_a=normpdf(test,m0,var0) ;

%Then we compute the probability that it comes from H1
p_b=normpdf(test,m1,var1) ;

%Computing the Lambda ratio for the Likelyhood ratio test
lamda_ratio=p_b/p_a;
heta=1; 

 

if (lamda_ratio>heta)
    disp('Match H1!');
else
    disp('Match H0!');
end



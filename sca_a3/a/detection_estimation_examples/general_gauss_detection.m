clear all;
close all;
%This code corresponds to chapter 3 of Harry van Trees book

%We assume that the POI (point of interest) detection is already done.
%We also assume that the attacker has extensively profiled the device so he
%has already formed 2 multivariate gaussian distributions: 
%one for H0 (key0) and one for H1 (key1)

m0 = [4,2]';
K0 = [2,1.8;1.8,2.5];


m1 = [3,3.5]';
K1 = [1,1.5;1.5,3];


%Lets plot them in the 2D space
x1 = -10:.2:10; x2 = -10:.2:10;
[X1,X2] = meshgrid(x1,x2); %make a 2D grid 

F0 = mvnpdf([X1(:) X2(:)],m0',K0); %compute the pdf0 in all grid spots
F0 = reshape(F0,length(x2),length(x1)); 
F1 = mvnpdf([X1(:) X2(:)],m1',K1); %compute the pdf1 in all grid spots
F1 = reshape(F1,length(x2),length(x1));


contour(x1,x2,F0); 
hold on;
contour(x1,x2,F1); 
axis([min(x1) max(x1) min(x2) max(x2) ]);
xlabel('x1'); ylabel('x2');

%You can already see that there exists overlap


%Now, a new trace (measurement) comes in and we need to decide if it verifies H0 or H1

trace_undertest_A=[4.6 1.4]'; %We can already see in the graph that this trace is closer to H0 compared to H1


%%

%COMPARISON. 
%First we compute the probability that it comes from H0
p0=mvnpdf(trace_undertest_A', m0',K0);
%Then we compute the probability that it comes from H1
p1=mvnpdf(trace_undertest_A', m1',K1);
%It is already visible that  p0 >> p1,  so H0 is a better match. Below we check  formally.
lamda_ratio= p1/p0; %from formula (2.13), page 23 and formula (2.57), page 31
p0_apriori=0.5;
p1_apriori=0.5; 
heta=p0_apriori/p1_apriori; 
%we see that heta = 1 often in the template scenario
%H0 and H1 are equipropable since P(Key=0)=P(key=1)=0.5
%C00=C11=0, C01=C10=1, i.e. false-positive is as bad as false-negative
%%
%Alternatively compute from formula (3.57), page 133
l= 0.5*(trace_undertest_A-m0)'*inv(K0)*(trace_undertest_A-m0) - ...
    0.5*(trace_undertest_A-m1)'*inv(K1)*(trace_undertest_A-m1);
gamma1=log(heta)+0.5*log(det(K1))-0.5*log(det(K0));
%%


if (lamda_ratio>heta)
    disp('Match H1!');
else
    disp('Match H0!');
end

if (l>gamma1)
    disp('Match H1!');
else
    disp('Match H0!');
end


%Now you can also try to see what happens with a point in the overlap 
%region of the contour plot

trace_undertest_B=[3.4 2.4]';

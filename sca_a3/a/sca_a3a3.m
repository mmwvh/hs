# Wesley van Hoorn  --  s4018044

clear all;
close all;

load dataset.mat
m = 248;

# part a
T0 = mean(train_set0);
T1 = mean(train_set1);
muT = 0.5 * (T0 + T1); 

# part b
function b = bf(test_set1, test_set2, muT)
    b = zeros(columns(test_set1), columns(test_set2));
    b = 0.5 * ...
    ((test_set1' - muT') * (test_set1' - muT')' + ...
    (test_set2' - muT') * (test_set2' - muT')');
endfunction

# part c
[u, s, v] = svd(bf(test_set0, test_set1, muT));

# part d
u_reduced = u(:, 1:m);

# part e
train_set0 = train_set0 * u_reduced;
test_set0  = test_set0  * u_reduced;
train_set1 = train_set1 * u_reduced;
test_set1  = test_set1  * u_reduced;

# part f
function lambda = lambdaf(train_set1, train_set2, test_set)
  T1 = mean(train_set1);
  covT1 = cov(train_set2);
  T2 = mean(train_set1);
  covT2 = cov(train_set2);
  
  # unable to find a solution to the matrix mismatch problem
  lambda = 0.5 * ...
  (test_set - T1)' * inv(covT1) * (test_set - T1) - 0.5 * ...
  (test_set - T2)' * inv(covT2) * (test_set - T2);
endfunction

lambda0 = lambdaf(train_set0, train_set1, test_set0);
lambda1 = lambdaf(train_set0, train_set1, test_set1);

gamma = 0.5 * ...
log2(det(cov(train_set1))) - 0.5 * ...
log2(det(cov(train_set0)));

# part g
function result = resultf(l, g)
  result = l - g;
  for idx = 1:numel(result)
    if result(idx) <= 0
      result(idx) = 0;
    else
      result(idx) = 1;
    endif
  endfor
endfunction

result0 = resultf(lambda0, gamma);
result1 = resultf(lambda1, gamma);

mis0 = sum(result0 == 1) / length(test_set0)
mis1 = sum(result1 == 0) / length(test_set1)
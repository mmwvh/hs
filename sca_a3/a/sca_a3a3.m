# Wesley van Hoorn  --  s4018044

clear all;
close all;

load dataset.mat

# reduced template building
T0 = mean(train_set0);
T1 = mean(train_set1);
muT = (T0 + T1)/2; 

# compute score 
function b = bf(test1, test2, muT)
  for idx = 1:rows(test1)
    b(idx,:) = ((test1(idx, :)' - muT')*(test1(idx, :)' - muT')' + ...
    (test2(idx, :)' - muT')*(test2(idx, :)' - muT')')/2;
  endfor
endfunction

[u, s, v] = svd(bf(test_set0, test_set1, muT));


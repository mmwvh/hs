# Wesley van Hoorn  --  s4018044

clear all;
close all;

load dataset.mat

# reduced template building
T0 = mean(train_set0);
T1 = mean(train_set1);

# variance
v0 = var(train_set0);
v1 = var(train_set1);

# POI selection
adT = abs(T0 - T1);
idx = find(adT == max(adT));
p0 = T0(idx);
p1 = T1(idx);

# POI 0 univariate normal distributions
p0t = normpdf(p0, T0, v0) ./ normpdf(p0, T1, v1);

# POI 1 univariate normal distributions
p1t = normpdf(p1, T0, v0) ./ normpdf(p1, T1, v1);

function t = testf(p)  
  t = p;
   for idx = 1:numel(t)
     if t(idx) > 1
       t(idx) = 1;
     else
       t(idx) = 0;
     endif
   endfor
endfunction

function result = resultf(p)
  if (sum(p == 1) > sum(p == 0))
    result = 1;
  else
    result = 0;
  endif
endfunction

testp0 = testf(p0t);
testp1 = testf(p1t);

printf("POI 0 matches key_%d.\n", resultf(testp0));
printf("POI 1 matches key_%d.\n", resultf(testp1));

# TODO compute false positives and negatives wrt uni-norm-dis

# mismatch
mis0 = sum(testp0 == 1) / length(test_set0)
mis1 = sum(testp1 == 0) / length(test_set1)
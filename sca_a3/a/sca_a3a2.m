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

# determine result for univariate template matching
function result = resultf(p)
  result = p;
  for idx = 1:numel(result)
    if result(idx) > 1
      result(idx) = 1;
    else
      result(idx) = 0;
    endif
  endfor
endfunction

result0 = resultf(p0t);
result1 = resultf(p1t);

# How do I compute false positives and distinguish false negatives from true 
# negatives wrt uni-norm-dis when I only know the end result?

# mismatch
mis0 = sum(result0 == 1) / length(test_set0)
mis1 = sum(result1 == 0) / length(test_set1)
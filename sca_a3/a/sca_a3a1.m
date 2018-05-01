# Wesley van Hoorn  --  s4018044

clear all;
close all;

load dataset.mat

# reduced template building
T0 = mean(train_set0);
T1 = mean(train_set1);

# compute score 
function score = scoref(test_set, T)
  for idx = 1:rows(test_set)
    score(idx,:) = (test_set(idx, :) - T)*(test_set(idx, :) - T)';
  endfor
endfunction

# determine result for reduced template matching
function result = resultf(score0, score1)
  result = score0 - score1;
  for idx = 1:numel(result)
    if result(idx) <= 0
      result(idx) = 0;
    else
      result(idx) = 1;
    endif
  endfor
endfunction

# reduced template matching
score0t0 = scoref(test_set0, T0);
score0t1 = scoref(test_set0, T1);
score1t0 = scoref(test_set1, T0);
score1t1 = scoref(test_set1, T1);

# prediction matrix
resultT0 = resultf(score0t0, score0t1);
resultT1 = resultf(score1t0, score1t1);

# mismatch
mis0 = sum(resultT0 == 1) / length(test_set0)
mis1 = sum(resultT1 == 0) / length(test_set1)
load dataset.mat

# reduced template building
T0 = mean(train_set0);
T1 = mean(train_set1);

# compute score 
function score = compScore(test_set, T)
  for idx = 1:rows(test_set)
    score(idx,:) = (test_set(idx, :) - T)*(test_set(idx, :) - T)';
  endfor
endfunction

# determine result for reduced template matching
function result = detResultRed(score0, score1)
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
score0t0 = compScore(test_set0, T0);
score1t0 = compScore(test_set0, T1);
score0t1 = compScore(test_set1, T0);
score1t1 = compScore(test_set1, T1);

# 
resultRedTest0 = detResultRed(score0t0, score1t0);
resultRedTest1 = detResultRed(score0t1, score1t1);

# TODO 3a1 mismatch
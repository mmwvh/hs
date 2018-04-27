# Aniek den Teuling - s1010747

load dataset.mat

# step 1
# Build reduced templates
t0 = mean(train_set0); 
t1 = mean(train_set1);

# Reduced template matching
# Test set 0
score0t0 = zeros(size(test_set0));
for idx = 1:rows(test_set0)
  score0t0(idx, :) = abs(test_set0(idx, :) - t0);
endfor

score0t1 = zeros(size(test_set0));
for idx = 1:rows(test_set0)
  score0t1(idx, :) = abs(test_set0(idx, :) - t1);
endfor

# Test set 1
score1t0 = zeros(size(test_set1));
for idx = 1:rows(test_set1)
  score1t0(idx, :) = abs(test_set1(idx, :) - t0);
endfor

score1t1 = zeros(size(test_set1));
for idx = 1:rows(test_set1)
  score1t1(idx, :) = abs(test_set1(idx, :) - t1);
endfor

# Determine scores
result0 = score0t0 - score0t1;
for idx = 1:numel(result0)
   if result0(idx) <= 0
     result0(idx) = 0;
   else 
     result0(idx) = 1;
   endif
endfor

result1 = score1t0 - score1t1;
for idx = 1:numel(result1)
  if result1(idx) <= 0
    result1(idx) = 0;
  else 
    result1(idx) = 1;
  endif
endfor

# Number of mismatches
mismatch_t0 = sum(result0(:) == 1)
mismatch_t1 = sum(result1(:) == 0)

# Misclassification rate
mis_clas_rate_t0 = mismatch_t0 / numel(result0)
mis_clas_rate_t1 = mismatch_t1 / numel(result1)
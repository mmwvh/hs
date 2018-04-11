# Aniek den Teuling - s1010747

load dataset.mat

# step 1
# Build reduced templates
o_0 = mean(train_set0); 
o_1 = mean(train_set1);

# Reduced template matching
score0 = zeros(size(test_set0));
#for idx = 1:rows(train_set0)
#  score0(idx, :) = abs(train_set0(idx, :) - o_0);
#endfor

for idx = 1:rows(test_set0)
  score0(idx, :) = (test_set0(idx, :) - o_0) * (test_set0(idx, :) - o_0)';
endfor 

score1 = zeros(size(test_set1));
#for idx = 1:rows(train_set1)
#  score1(idx, :) = abs(train_set1(idx, :) - o_1);
#endfor

for idx = 1:rows(test_set1)
  score1(idx, :) = (test_set1(idx, :) - o_1) * (test_set1(idx, :) - o_1)';
endfor

# Check whether score0 <= score 1
result = score0 - score1;
for idx = 1:numel(result)
   if result(idx) <= 0
     result(idx) = 0;
   else 
     result(idx) = 1;
   endif
endfor



# Aniek den Teuling - s1010747
# This is in Octave

load dataset.mat

# STEP 1
# Reduced template matching
# Build reduced templates
t0 = mean(train_set0); 
t1 = mean(train_set1);

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
mismatch_t0 = sum(result0(:) == 1);
mismatch_t1 = sum(result1(:) == 0);

# Misclassification rate
# misclassification rate t0 = 0.52625;
# misclassification rate t1 = 0.45915;
mis_clas_rate_t0 = mismatch_t0 / numel(result0);
mis_clas_rate_t1 = mismatch_t1 / numel(result1);

# STEP 2
# POI using difference of means
# Already computed the means of O_0 and O_1 in the beginning, namely t0 and t1
mean_0 = t0;
mean_1 = t1;
difference_means = abs(mean_0 - mean_1);
highest_difference = max(difference_means);

index_high_diff = find(difference_means == highest_difference);
poi_0 = t0(index_high_diff);
poi_1 = t1(index_high_diff);

var_0 = var(train_set0);
var_1 = var(train_set1);

# Check whether poi's match O_0 or O_1
# They both match O1.
# Probability poi_0 comes from O_0 
p_0_0 = normpdf(poi_0, mean_0, var_0);
# Probability poi_0 comes from O_1
p_0_1 = normpdf(poi_0, mean_1, var_1);

lambda_0 = p_0_0 / p_0_1
if lambda_0 > 1
  disp("POI_0 matches O1");
else 
  disp("POI_0 matches O0");
end
  
# Probability poi_1 comes from O_0
p_1_0 = normpdf(poi_1, mean_0, var_0);
# Probability poi_1 comes from O_1
p_1_1 = normpdf(poi_1, mean_1, var_1);

lambda_1 = p_1_0 / p_1_1
if lambda_1 > 1
  disp("POI_1 matches O1");
else
  disp("POI_1 matches O0");
end

# False positive / false negative
# TBD
# Misclassification rate
# TBD

# STEP 3
# (a) Compute mean of operation 0 and 1
mean_op = 0.5 * (mean_0 + mean_1);

# (b) Compute 1301 x 1301 matrix
# Transposed all individual means, otherwise would end up with 1x1 matrix (1x1301 * 1301x1 = 1x1)
b = 0.5 * (((mean_0.' - mean_op.') * (mean_0.' - mean_op.').') + ((mean_1.' - mean_op.') * (mean_1.' - mean_op.').'));

# (c) Compute singular value decomposition
[u,s,v] = svd(b);

# (d) Compute u reduced
# Chosen dimension: 30
m = 500;
u_reduced = u(:,1:m);

# (e) Project datasets
proj_test_0  = test_set0  * u_reduced;
proj_test_1  = test_set1  * u_reduced;
proj_train_0 = train_set0 * u_reduced;
proj_train_1 = train_set1 * u_reduced;

# (f) Compute multivariate templates of projected training sets
mean_proj_train_0 = mean(proj_train_0);
cov_train_0   = cov(proj_train_0);

mean_proj_train_1 = mean(proj_train_1);
cov_train_1   = cov(proj_train_1);

# (g) Compute misclassification rate
# My code does not work, I followed slide 37 from the FastTemplateTutorial pdf
# but get stuck at the computation of lambda and gamma. However, here's the code:
#{
lambda_proj_train_0 = 0.5 * (proj_test_0 - mean_proj_train_0).' * inv(cov_train_0) ...
          * (proj_test_0 - cov_train_0) - 0.5 * (proj_test_0 - mean_proj_train_1).' ...
          * inv(cov_train_1) * (proj_test_0 - cov_train_1);

lambda_proj_train_1 = 0.5 * (proj_test_1 - mean_proj_train_0).' * inv(cov_train_0) ...
          * (proj_test_1 - cov_train_0) - 0.5 * (proj_test_0 - mean_proj_train_1).' ...
          * inv(cov_train_1) * (proj_test_1 - cov_train_1);       

gamma = 0.5 * log(det(cov_train_1)) - 0.5 * log(det(cov_train_0));
#}
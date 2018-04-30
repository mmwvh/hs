# Aniek den Teuling - s1010747

load input.mat
load leakage_y0_y1.mat

# Pre-processing step 

# I use function nchoosek which gives all combinations of vector v, picking 2 values at a time.
# The vectors are the rows of the leakage matrix.
# Each nchoosek(v,2) gives a matrix of 45x2 combinations but these need to be multiplied
# to find the result of all combinations, which is a 45x1 vector, which I transpose to get 1x45 vectors.
# These 2000 vectors together form the 2000x45 matrix with all possible multiplications between the samples.

for idx = 1:rows(L)
  v = L(idx,:);
  comb_matrix = nchoosek(v,2);
  column1 = comb_matrix(:,1);
  column2 = comb_matrix(:,2);
  combinations = (column1 .* column2).';
  pre_pro(idx,:) = combinations;
endfor


# Value prediction matrix
# Compute all combinations of keys plus input values
key_can = cast(0:15, "uint8");

for idx = 1:sizeof(key_can)
  val_pred(:, idx) = bitxor(input, key_can(idx));
endfor

# Correlation power analysis
abs_corr_val = abs(corr(pre_pro, val_pred));
# Result key
key_can = cast(vertcat(0:15, max(abs_corr_val))', "single");
key_can = flipud(sortrows(key_can,2));
printf "Key candidate with highest "
correlation = result = key_can(1,1)

# Plot figure 
figure;
xlabel("Traces");
ylabel("Correlation");
title("Correlation of preprocessed traces and keys");

hold on
# Aniek den Teuling - s1010747

load input.mat
load leakage_y0_y1.mat

# Pre-processing step ????
pre_pro = zeros(2000,45);
for idx = 1:rows(L)
  pre_pro(idx, :) = nchoosek(1:columns(L), 2);
endfor

# Value prediction matrix
key_can = cast(0:15, "uint8");

for idx 1:sizeof(key_can)
  val_pred(:, idx) = bitxor(pre_pro, key_can(idx))+1);
endfor

# Correlation power analysis
abs_corr_val = abs(corr(pre_pro, val_pred));

key_can = cast(vertcat(0:15, max(abs_corr_val))', "single");
key_can = flipud(sortrows(key_can,2));
printf "Key candidate with highest "
correlation = result = key_can(1,1)
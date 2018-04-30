# Wesley van Hoorn  --  s4018044

load input.mat
load leakage_y0_y1.mat

order = 2;
dim = factorial(columns(L))/(factorial(columns(L) - order)*factorial(order));

# pre-processing
t = zeros(rows(L), dim);
for idx = 1:rows(t)
  tmp = nchoosek(L(idx, :), order);
  t(idx, :) = (tmp(:,1).*tmp(:,2))';
endfor

# key candidates
key_can = cast(0:15, "uint8");

# value-prediction matrix
for idx = 1:sizeof(key_can)
  y(:,idx) = bitxor(input,key_can(idx)); 
endfor

# correlation analysis
abs_cw_corr = abs(corr(t, y));
key_can = cast(vertcat(0:15, max(abs_cw_corr))', "single");
key_can = flipud(sortrows(key_can, 2));
printf "Key candidate with highest "
correlation = result = key_can(1,1)

# plot
figure;
xlabel("Traces");
ylabel("Correlation");
title("Correlation between processed traces and leakage");

hold on
for idx = 1:columns(abs_cw_corr)
  if(idx == result+1)
    plot(abs_cw_corr(:,idx), 'Color', [1 0 0]);
  else
    plot(abs_cw_corr(:,idx), 'Color', [0 0 0]+0.003*idx);
  endif
endfor
hold off  
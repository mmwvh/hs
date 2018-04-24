# Aniek den Teuling - s1010747

load input.mat
load leakage_y0_y1.mat

# Pre-processing step
for idx = 1:rows(L)
  prepro(idx, :) = bincoeff(L(idx), 2);
endfor

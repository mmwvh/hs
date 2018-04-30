# Aniek den Teuling - s1010747
# This is in Octave

load data.mat

# STEP 1
# S depends on the message and the 2 middle bits of K
# 4 possibilities for K:
keys = [0b0000,0b0010,0b0100,0b0110];

# Create matrix of messages * key possibilities
matrix = zeros(10000,4);
for idx = 1:length(keys)
  matrix(:, idx) = sbox(bitxor(messages, keys(idx))+1);
endfor

# Function S
# left bit = 4, middle bits = 3/2, right bit = 1
# so m0 = 4, m1 = 3, m2 = 2, m3 = 1
function s = selection(m,k)
  s = (bitget(m,3) + bitget(k,3))(bitget(m,2) + bitget(k,2))...
      + bitget(m,2) + bitget(m,1);
endfunction     

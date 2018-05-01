# Aniek den Teuling - s1010747
# This is in Octave

load data.mat

# STEP 1
# S depends on the message and the 2 middle bits of K
# 4 possibilities for K:
keys = [0b0000,0b0010,0b0100,0b0110];

# Create matrix of messages * key possibilities
matrix = zeros(10000,4);
for idx = 1:numel(keys)
  matrix(:, idx) = (bitxor(messages, keys(idx)));
endfor

# Function S
# when using bitget:
# m0 = 1, m1 = 2, m2 = 3, m3 = 4
# k0 = 1, k1 = 2, k2 = 3, k3 = 4
# Implement the last line of the S(M, K*) function  
function s = selection(m,k)
  s = gf((bitget(m,2) + bitget(k,2))(bitget(m,3) + bitget(k,3))...
      + bitget(m,3) + bitget(m,4));
endfunction   

# The intention is to create a matrix with all messages 
# and all 4 possible keys, with the S function applied.
# But it does not work (errors) and I do not know how to do it properly.
# After spending several hours on different days on this assignment part, 
# I decided to leave it with this

for idx = numel(keys)
  s(:,idx) = selection(messages,keys(idx));
endfor

# Skewness
# Instead of difference of means, here use difference of skewness
# Here the skewness should be computed as:
# skewness([(lowest bit message)(corresponding S)(corresponding trace)])


# STEP 2
# y1 = x0x2x1 + x0x3x1 + x3x1 + x1 + x0x2x3 + x2x3 + x3
# not completed because I got stuck with step 1
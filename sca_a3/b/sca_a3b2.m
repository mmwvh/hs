# Wesley van Hoorn  --  s4018044

clear all;
close all;

load data.mat

# key candidates
key_can = cast(0:3, "uint8");

# value-prediction matrix
for idx = 1:length(key_can)
  y(:,idx) = bitxor(messages,key_can(idx)); 
endfor

function s = selef(m,k)
  s = gf((bitget(m,2) + bitget(k,2)) .* (bitget(m,3) + bitget(k,3))...
      + bitget(m,3) + bitget(m,4));
endfunction  

for idx = 1:rows(y)
  s(idx,:) = selef(y(idx,:), key_can);
endfor

# I have problems with the make file for Octave Forge's communications package
# Therefore gf is unable to work
# I believe this implementation is the step into the right direction

# skewness([(lowest bit message)(corresponding S)(corresponding trace)])

# k0 & k3
# I attempted to rewrite ANF y1 into the same format as the selection function 
# but I was unable to find out what the previous register should be

# new selection function of which k1 and k2 are known
#{
=   (m0 + k0)(m2+k2)(m3+k3) + (m0 + k0)(m3+k3)(m1 + k1) + (m3 + k3)(m1 + k1) + 
    m1 + k1 + (m0 + k0)(m2 + k2)(m3 + k3) + (m2 + k2)(m3 + k3) + m3 + k3 
    + previous register
#}

# skewness([(lowest bit message)(corresponding S)(corresponding trace)])
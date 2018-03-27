load in.mat
load traces.mat

k = cast(0:15, "uint8")

for i = 1:rows(k')
  y(:,i) = sbox(bitxor(in,k(1,i))) 
endfor

function y = sbox(x)
  
endfunction

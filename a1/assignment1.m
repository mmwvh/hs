load in.mat
load traces.mat

k = cast(0:15, "uint8");

sbox = [12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2];

for i = 1:sizeof(k)
  y(:,i) = sbox(bitxor(in,k(1,i))+1); 
endfor


  pp = reshape(sum(dec2bin(y)' == '1'), rows(y), columns(y))
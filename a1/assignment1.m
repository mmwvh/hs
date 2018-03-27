load in.mat
load traces.mat

k = cast(0:15, "uint8")
sbox = cast([12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2], 'uint8')

for i = 1:columns(k)
  y(:,i) = bitxor(in,k(1,i)) 
endfor

for i = 1:rows(y)
  for j = 1:columns(y)
    y(i,j) = sbox(1, y(i,j)+1)
  endfor
endfor


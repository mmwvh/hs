# Aniek den Teuling --  s1010747
# Wesley van Hoorn  --  s4018044

# step 1
load in.mat
# step 4
load traces.mat

# step 2
hyp_key = cast(0:15, "uint8");

sbox = [12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2];

for idx = 1:sizeof(hyp_key)
  y(:,idx) = sbox(bitxor(in,hyp_key(1,idx))+1); 
endfor

# step 3
pow_pred = reshape(sum(dec2bin(y)' == '1'), rows(y), columns(y));
# step 5
abs_cw_corr = abs(corr(traces, pow_pred));
# step 6
[max_corr key] = max(max(abs_cw_corr));

# step 7
figure ;
hold on
xlabel("Traces");
ylabel("Correlation");
title("Correlation between measured traces and predicted powerconsumption");
for idx = 1:columns(abs_cw_corr)
  if(idx == key)
    plot(abs_cw_corr(:,idx), 'Color',[1 0 0]);pause(0.5);
  else
    plot(abs_cw_corr(:,idx), 'Color',[0 0 0]+0.03*idx);pause(0.5);
  endif
endfor
hold off

# step 8
# TODO
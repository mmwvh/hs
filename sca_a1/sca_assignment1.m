# Aniek den Teuling --  s1010747
# Wesley van Hoorn  --  s4018044

# step 1
load in.mat
# step 4
load traces.mat

# step 2
can_key = cast(0:15, "uint8");

sbox = [12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2];

for idx = 1:sizeof(can_key)
  y(:,idx) = sbox(bitxor(in,can_key(idx))+1); 
endfor

# step 3
pow_pred = reshape(sum(dec2bin(y)' == '1'), rows(y), columns(y));
# step 5
abs_cw_corr = abs(corr(traces, pow_pred));
# step 6
can_key = cast(vertcat(0:15, max(abs_cw_corr))', "single");
can_key = flipud(sortrows(can_key,2));
printf "Key candidate with highest "
correlation = result = can_key(1,1)

# step 7
figure;
xlabel("Traces");
ylabel("Correlation");
title("Correlation between measured traces and predicted powerconsumption");

hold on
for idx = 1:columns(abs_cw_corr)
  if(idx == result+1)
    plot(abs_cw_corr(:,idx), 'Color',[1 0 0]);
  else
    plot(abs_cw_corr(:,idx), 'Color',[0 0 0]+0.025*idx);
  endif
endfor
hold off

# step 8
nr_of_traces = [ 500, 1000, 2000, 4000, 8000, 12000];

figure;
for idx = 1:columns(nr_of_traces)
  subplot(3, 2, idx);
  sub_max_abs_cw_corr = max(abs(corr(traces(1:nr_of_traces(idx),:), pow_pred(1:nr_of_traces(idx),:))));
  sub_can_key = vertcat(0:15, sub_max_abs_cw_corr)';
  sub_can_key = flipud(sortrows(sub_can_key,2));
  
  bar(sub_can_key(:,2), 'facecolor', [0 0 0]);
  
  l = legend ("best candidate = 6");
  legend(l, "location", "southoutside");
  xt = get(gca, 'XTick');
  set(gca, 'XTick', xt, 'XTickLabel', sub_can_key(:,1));
  xlabel("Key candidates");
  ylabel("Correlation");
  title([num2str(nr_of_traces(idx)) " traces"]);
endfor
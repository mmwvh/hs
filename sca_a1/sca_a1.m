# Aniek den Teuling --  s1010747
# Wesley van Hoorn  --  s4018044

# step 1
load in.mat
# step 4
load traces.mat

# step 2
key_can = cast(0:15, "uint8");

sbox = [12, 5, 6, 11, 9, 0, 10, 13, 3, 14, 15, 8, 4, 7, 1, 2];

for idx = 1:sizeof(key_can)
  y(:,idx) = sbox(bitxor(in,key_can(idx))+1); 
endfor

# step 3
pow_pred = reshape(sum(dec2bin(y)' == '1'), rows(y), columns(y));
# step 5
abs_cw_corr = abs(corr(traces, pow_pred));
# step 6
key_can = cast(vertcat(0:15, max(abs_cw_corr))', "single");
key_can = flipud(sortrows(key_can,2));
printf "Key candidate with highest "
correlation = result = key_can(1,1)

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
# We had trouble coming up with a solution to color only one bar in the bar graph
# For instance the following should have colored the third bar red:
# 
# b = bar(sub_key_can(:,2), 'facecolor', [0 0 0]);
# set(b(3), 'facecolor', [1 0 0]); 
#
# but it did not because b would end up as a single double value instead of figure object.
# So we added a legend that would show the best candidate.
# This is not the most elegant way to do this, 
# therefore we would like to know what the best way was to represent this.

nr_of_traces = [ 500, 1000, 2000, 4000, 8000, 12000];

figure;
for idx = 1:columns(nr_of_traces)
  subplot(3, 2, idx);
  sub_max_abs_cw_corr = max(abs(corr(traces(1:nr_of_traces(idx),:), pow_pred(1:nr_of_traces(idx),:))));
  sub_key_can = vertcat(0:15, sub_max_abs_cw_corr)';
  sub_key_can = flipud(sortrows(sub_key_can,2));
  
  bar(sub_key_can(:,2), 'facecolor', [0 0 0]);
  
  l = legend ("best candidate = 6");
  legend(l, "location", "southeast");
  xt = get(gca, 'XTick');
  set(gca, 'XTick', xt, 'XTickLabel', sub_key_can(:,1));
  xlabel("Key candidates");
  ylabel("Correlation");
  title([num2str(nr_of_traces(idx)) " traces"]);
endfor
function diff = abs_diff_mean(p, a, b)
diff = 0;
for i = 1:a
    for j = 1:b
        diff = diff + (abs(i - j)) * p(i, j);
    end
end
end


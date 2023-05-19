function uni = uniformity(p, a, b)
uni = 0;
for i = 1:a
    for j = 1:b
        uni = uni + p(i, j) / (1 + abs(i - j));
    end
end
end

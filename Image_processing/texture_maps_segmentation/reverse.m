function res = reverse(p, a, b)
res = 0;
for i = 1:a
    for j = 1:b
        res = res + p(i, j) / (1 + ((i - j)^2));
    end
end
end

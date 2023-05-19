function contr = contrast(p, a, b)
contr = 0;
for i = 1:a
    for j = 1:b
        contr = contr + ((i - j)^2) * p(i, j);
    end
end
end

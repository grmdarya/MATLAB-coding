function ent = entropy(p, a, b)
ent = 0;
for i = 1:a
    for j = 1:b
        ent = ent + p(i, j) * log2(p(i, j));
    end
end
end
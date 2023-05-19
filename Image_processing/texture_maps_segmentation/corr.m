function res = corr(p, a, b, m_a, m_b, s_a, s_b)
res = 0;
for i = 1:a
    for j = 1:b
        res = res + i * j * p(i, j) - m_a * m_b;
    end
end
res = res / (s_a * s_b);
end

function cov = covariance(p, a, b, m_a, m_b)
cov = 0;
for i = 1:a
    for j = 1:b
        cov = cov + (i - m_a) * (j - m_b) * p(i, j);
    end
end
end

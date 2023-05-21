function i = bit_count(number)
    n = 1;
    i = 0;
    while n < number
        n = n * 2;
        i = i + 1;
    end

end
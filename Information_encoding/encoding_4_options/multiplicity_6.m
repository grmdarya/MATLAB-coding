function [mas_new, mas] = multiplicity_6(mas)
temp = size(mas, 2);

if (mod(temp,6) >= 3)
    temp = temp + mod(temp,6);
    for i = size(mas,2) : temp;
        mas(i) = '_';
    end
else
    temp = temp - mod(temp,6);
end

mas_new = cell(1,fix(temp/6));
i = 1;
for j = 1 : fix(temp/6)
	mas_new{ j } = strcat(mas(i),mas(i+1),mas(i+2),mas(i+3),mas(i+4),mas(i+5));
	i = i + 6;
end

end
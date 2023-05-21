function [P_1, P_2, P_3] = fun(mas, ax, Px, ay, Py, az, Pz)

P_1 = zeros(1,size(Px,2));
P_2 = zeros(1,size(Py,2));
P_3 = zeros(1,size(Pz,2));

for i = 1 : size(mas,2)
	for j = 1 : size(Px,2)
		if (char(mas(i)) == char(ax(j)))
			P_1(i) = Px(j);
			break
		end
	end
end

Temp = cell(1);

i = 1;
for k = 1 : size(mas,2)/2
	Temp{1} = strcat(mas(i),mas(i+1));
	for j = 1 : size(Py,2)
		if ( Temp{1} == ay{j})
			P_2(k) = Py(j);
			break
		end
	end
	i = i + 1;
end

i = 1;
for k = 1 : size(mas,2)/3
	Temp{1} = strcat(mas(i),mas(i+1), mas(i+2));
	for j = 1 : size(Pz,2)
		if (Temp{1} == az{j})
			P_3(k) = Pz(j);
			break
		end
	end
	i = i + 2;
end

end
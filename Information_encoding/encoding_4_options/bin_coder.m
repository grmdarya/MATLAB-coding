function [ bin_code ] = bin_coder ( chislo, max )

	bin_code = 0;
	temp = 1;	

	for i = 1 : max
		temp = temp * 10;
		chislo = chislo * 2;
		if (chislo >= 1)
			chislo = chislo - 1;
			bin_code = bin_code + 1 / temp;
		end 
	
	end
	%bin_code = bin_code + 2 / temp;
end
function [ mas ] = bin_coder_string ( chislo, max )

	mas = zeros(1, max);

	for i = 1 : max
		chislo = chislo * 2;
		if (chislo >= 1)
			chislo = chislo - 1;
            mas(i) = '1';
        else
            mas(i) = '0';
		end 
	
    end
end
function [ c, N, x, y, z] = ReadFromFile(~)
	
	fileID = fopen('input.txt','r');
	c = fscanf(fileID,['%s']);
	fclose(fileID);


	N = length(c);

	x = string('');
	y = cell( 1, (N - 1));
	z = cell( 1, (N - 2));

	for i = 1:N
		x(i) = c(i);
	end


	for i = 1:N-1
		y{ i } = string( strcat( string( c( i ) ), string( c( i + 1 ) ) ) );
    end


    for i = 1:N-2
        z{ i } = strcat(c(i),c(i+1),c(i+2));
    end

end

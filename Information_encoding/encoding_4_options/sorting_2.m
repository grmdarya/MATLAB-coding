function [ mas1 , mas2 ] = sorting_2 ( mas1 , mas2)

	for i = 1 : size ( mas1 , 2 )
		max = 0;
		for j = i : size ( mas1 , 2 )
           		if ( ( mas1( j ) > max ) )
               		max = mas1( j );
                	pos_max = j;
                end
        end
        
        temp = mas1( pos_max );
		mas1( pos_max ) = mas1( i );
		mas1( i ) = temp;
        
		temp = mas2{ pos_max };
		mas2{ pos_max } = mas2{ i };
		mas2{ i } = temp;

	end

end
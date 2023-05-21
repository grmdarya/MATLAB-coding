function [ ay, Ny, Py, Iy, PyIy ] = statistics_y(y,N)

    ay = unique (y);
    Ny = zeros( 1, size(ay,2));

    for i = 1:size(ay,2)
        for j = 1:N-1
            if( ay{i} == y{j} )
                Ny(i) = Ny(i)+1;
            end
        end
    end

    for i = 1 : size( ay, 2 )
        Py( i ) = Ny( i ) / (N - 1);
        Iy( i ) = -1 * log2( Py( i ) );
        PyIy( i ) = Py( i ) * Iy( i );
    end
    
end



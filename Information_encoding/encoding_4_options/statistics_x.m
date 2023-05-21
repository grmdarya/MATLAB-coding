function [ ax, Nx, Px, Ix, PxIx ] = statistics_x(x,N)
    ax = unique (x);
    Nx = zeros( 1, size(ax, 2));
    %j = char ( 0 );

    for i = 1:size(ax,2)
        for j = 1:N        
            if(ax(i) == x(j))
                Nx(i) = Nx(i)+1;
            end
        end
    end
    
    
    for i = 1 : size( ax, 2 )
        Px( i ) = Nx( i ) / N;
        Ix( i ) = -1 * log2( Px( i ) );
        PxIx( i ) = Px( i ) * Ix( i );
    end
end


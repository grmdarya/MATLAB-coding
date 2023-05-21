function [ az, Nz, Pz, Iz, PzIz ] = statistics_z(z,N)

    az = unique (z);
    Nz = zeros( 1, size(az,2) );

    for i = 1:size(az,2)
        for j = 1:N-2
            if(az{i} == z{j})
                Nz(i) = Nz(i)+1;
            end
        end
    end
    
    for i = 1 : size( az, 2 )
        Pz( i ) = Nz( i ) / (N - 2);
        Iz( i ) = -1 * log2( Pz( i ) );
        PzIz( i ) = Pz( i ) * Iz( i );
    end
end



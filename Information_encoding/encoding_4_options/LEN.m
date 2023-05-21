function [ L_x, e_x, R_x, L_y, e_y, R_y, L_z, e_z, R_z ] = LEN ( Xaffman_x, Xaffman_y, Xaffman_z, Nx, Px, e_x, R_x, Ny, Py, e_y, R_y, Nz, Pz, e_z, R_z )
    
    e_x = 0;
    e_y = 0;
    e_z = 0;
    
    for i = 1 : size( Nx, 2 )
        L_x(i) = round(log(Xaffman_x(i))/ log (10));
        e_x = e_x + L_x(i) * Px(i);
    end
    for i = 1 : size( Ny, 2 )
        L_y(i) = round(log(Xaffman_y(i))/ log (10));
        e_y = e_y + L_y(i) * Py(i);
    end
    for i = 1 : size( Nz, 2 )
        L_z(i) = round(log(Xaffman_z(i))/ log (10));
        e_z = e_z + L_z(i) * Pz(i);
    end
    R_x = e_x / 1;
    R_y = e_y / 2;
    R_z = e_z / 3;
end
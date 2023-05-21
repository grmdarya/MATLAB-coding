function WriteToFileGilbertMoor(Px, ax, X_l, Cx, Py, ay, Y_l, Cy, Pz, az, Z_l, Cz)

    e_x = 0;
    e_y = 0;
    e_z = 0;
    
    for i = 1 : size( Px, 2 )
        e_x = e_x + X_l(i) * Px(i);
    end
    for i = 1 : size( Py, 2 )
        e_y = e_y + Y_l(i) * Py(i);
    end
    for i = 1 : size( Pz, 2 )
        e_z = e_z + Z_l(i) * Pz(i);
    end
    R_x = e_x / 1;
    R_y = e_y / 2;
    R_z = e_z / 3;

fileID = fopen('GilbertMoor_x.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : size( Px, 2 )
        fprintf ( fileID, '%s : %3.3f : %d : %15.0f\r\n', ax(i), Px(i), X_l(i), (Cx(i)+2)*(power(10,X_l(i))));
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_x, R_x);
    fclose(fileID);
    
    
    fileID = fopen('GilbertMoor_y.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : size( Py, 2 )
        fprintf ( fileID, '%s : %3.3f : %d  : %15.0f\r\n', ay{i}, Py(i), Y_l(i), (Cy(i)+2)*(power(10,Y_l(i))));
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_y, R_y);
    fclose(fileID);
    
    
    fileID = fopen('GilbertMoor_z.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : size( Pz, 2 )
        fprintf ( fileID, '%s : %3.3f : %d : %15.0f\r\n', az{i}, Pz(i), Z_l(i), (Cz(i)+2)*(power(10,Z_l(i))));
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_z, R_z);
    fclose(fileID);

end


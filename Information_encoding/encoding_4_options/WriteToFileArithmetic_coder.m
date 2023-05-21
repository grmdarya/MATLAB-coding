function WriteToFileArithmetic_coder(C_1, C_2, C_3, e_x, e_y, e_z, R_x, R_y, R_z, N)

    fileID = fopen('Arithmetic_x.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : N
        fprintf ( fileID, '%s', C_1{i} );
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_x, R_x);
    fclose(fileID);
    
    
    fileID = fopen('Arithmetic_y.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : N
        fprintf ( fileID, '%s', C_2{i});
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_y, R_y);
    fclose(fileID);
    
    
    fileID = fopen('Arithmetic_z.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : N
        fprintf ( fileID, '%s', C_3{i});
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_z, R_z);
    fclose(fileID);

end


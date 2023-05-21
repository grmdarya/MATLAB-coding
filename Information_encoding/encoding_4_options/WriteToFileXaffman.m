function [ ] = WriteToFileXaffman ( Xaffman_x, Xaffman_y, Xaffman_z, ax, Px, L_x, e_x, R_x, ay, Py, L_y, e_y, R_y, az, Pz, L_z, e_z, R_z )

fileID = fopen('Xaffman_x.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : size( Xaffman_x, 2 )
        fprintf ( fileID, '%s : %3.3f : %d : %d\r\n', ax(i), Px(i), Xaffman_x(i), L_x(i));
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_x, R_x);

    fclose(fileID);
    
    
    fileID = fopen('Xaffman_y.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : size( Xaffman_y, 2 )
        %fprintf ( fileID, '%s : %3.3f : %d : %d\r\n', ay{i}, Py(i), Xaffman_y(i), L_y(i));
        fprintf ( fileID, '%s : %3.3f :  : %d\r\n', ay{i}, Py(i), L_y(i));
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_y, R_y);

    fclose(fileID);
    
    
    fileID = fopen('Xaffman_z.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    for i = 1 : size( Xaffman_z, 2 )
        fprintf ( fileID, '%s : %3.3f : %d : %d\r\n', az{i}, Pz(i), Xaffman_z(i), L_z(i));
    end
    fprintf ( fileID, '\r\ne = %f \r\nR = %f', e_z, R_z);

    fclose(fileID);
end


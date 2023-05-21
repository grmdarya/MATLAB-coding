function [  ] = WriteToFile_H( H_x, H_x_n, H_conv_x, H_y, H_y_n, H_conv_y, H_z, H_z_n, H_conv_z )

    fileID = fopen('H.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
    fprintf(fileID, 'H_x = %3.4f\r\nH_x_n = %3.4f\r\nH_conv_x = %3.4f\r\n', H_x, H_x_n, H_conv_x);
    fprintf(fileID, 'H_y = %3.4f\r\nH_y_n = %3.4f\r\nH_conv_y = %3.4f\r\n', H_y, H_y_n, H_conv_y);
    fprintf(fileID, 'H_z = %3.4f\r\nH_z_n = %3.4f\r\nH_conv_z = %3.4f\r\n', H_z, H_z_n, H_conv_z);
    
    fclose(fileID);
    
end


function [ ] = WriteToFileY( a, Ny, Py, Iy, PyIy )
  %{
   Ty = table( a', Ny', Py', Iy', PyIy' );
    writetable( Ty,'outY.xls' );
    %}
    
    fileID = fopen('output_y.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    fprintf( fileID, '--------------------------------------------\r\n' );
    fprintf( fileID, '\tID\t|\tA\t|\tNy\t|\tPy\t|\tIy\t|\tPyIy\t|\r\n' );
    for i = 1 : size( a, 2 )
        fprintf( fileID, '\t%d\t|\t%s\t|\t%3.3f\t|\t%3.3f\t|\t%3.3f\t|\t%3.3f\t|\r\n', i,  a{ i }, Ny( i ), Py( i ), Iy( i ), PyIy( i ) );
    end

    fclose(fileID);

end


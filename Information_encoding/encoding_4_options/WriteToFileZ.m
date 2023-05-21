function [ ] = WriteToFileZ( a, Nz, Pz, Iz, PzIz )
    %{
Tz = table( a', Nz', Pz', Iz', PzIz' );
    writetable( Tz,'outZ.xls' ); 
%}

    fileID = fopen('output_z.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    fprintf( fileID, '--------------------------------------------\r\n' );
    fprintf( fileID, '\tID\t|\tA\t|\tNz\t|\tPz\t|\tIz\t|\tPzIz\t|\r\n' );
    for i = 1 : size( a, 2 )
        fprintf( fileID, '\t%d\t|\t%s\t|\t%3.3f\t|\t%3.3f\t|\t%3.3f\t|\t%3.3f\t|\r\n', i,  a{ i }, Nz( i ), Pz( i ), Iz( i ), PzIz( i ) );
    end

    fclose(fileID);
end


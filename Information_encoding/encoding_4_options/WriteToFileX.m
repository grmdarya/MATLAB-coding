function [ ] = WriteToFileX( a, Nx, Px, Ix, PxIx )
%{
    Tx = table( a', Nx', Px', Ix', PxIx' );
    writetable( Tx,'outX.xls' );
%}
    fileID = fopen('output_x.txt','w');
    if ( fileID == -1 ) 
        error( 'File is not opened' );
    end
        
    fprintf( fileID, '--------------------------------------------\r\n' );
    fprintf( fileID, '\tID\t|\tA\t|\tNx\t|\tPx\t|\tIx\t|\tPxIx\t|\r\n' );
    for i = 1 : size( a, 2 )
        fprintf( fileID, '\t%d\t|\t%s\t|\t%3.3f\t|\t%3.3f\t|\t%3.3f\t|\t%3.3f\t|\r\n', i,  a( i ), Nx( i ), Px( i ), Ix( i ), PxIx( i ) );
    end

    fclose(fileID);

end


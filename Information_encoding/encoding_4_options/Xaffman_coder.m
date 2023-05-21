Nx=5;
  % Arr_Nx = zeros( 1, 1000 );
    Arr_Nx = [ Nx, zeros( 1, 1000 ) ];
    
    Arr_V = zeros( 1, 1000 );
    Arr_Numb = zeros( 1, 1000 );
    
    size_Nx = size( Nx, 2 );
    Elements = size_Nx;
    
    %while ( Arr_Nx( Elements ) < N )
    for j = 1 : size_Nx
        %---- find double minimal elements
        min1 = 99999;
        min2 = 99999;
        pos_min1 = -1;
        pos_min2 = -1;
        
        %----- find first minimal
        for i = 1:Elements
            if ( ( Arr_Nx( i ) <= min1 ) )
                min1 = Arr_Nx( i );
                pos_min1 = i;
            end
        end
            
        %----- find second minimal
        for i = 1:Elements
            if ( ( Arr_Nx( i ) <= min2 ) && ( i ~= pos_min1 ))
                min2 = Arr_Nx( i );
                pos_min2 = i;
            end
        end
        
        if((min1 == 99999) || (min2 == 99999)) break; end

        %---- rewrite old elements and create new element
        %------- calculated new Probability
        Elements = Elements + 1;
        Arr_Nx( Elements ) = min1 + min2;
        
        %-------- save edge
        Arr_V( pos_min1 ) = 0;
        Arr_V( pos_min2 ) = 1;
        
        %-------- save parents for minimals element
        Arr_Numb( pos_min1 ) = Elements;
        Arr_Numb( pos_min2 ) = Elements;
        
        %-------- rewrite old minimals elements
        Arr_Nx( pos_min1 ) = 99999;
        Arr_Nx( pos_min2 ) = 99999;
        
    end
    
    Tree = zeros( 3, 1000 );
    Tree( 1:1, 1:1000 ) = Arr_Nx( 1:1, 1:1000 );
    Tree( 2:2, 1:1000 ) = Arr_V( 1:1, 1:1000 );
    Tree( 3:3, 1:1000 ) = Arr_Numb( 1:1, 1:1000 );
    
    
    %---------- create table for coding
    Table_coding = zeros( 1, size_Nx );
    
    for i = 1 : size_Nx
       % Table_coding( 1, i ) = char( ax( i ) );
        
        Table_coding( 1, i ) = 2;
        buf = i;
        while ( buf ~= Elements )
            Table_coding( 1, i ) = Table_coding( 1, i ) * 10 + Arr_V( buf );
            buf = Arr_Numb( buf );
        end
    end


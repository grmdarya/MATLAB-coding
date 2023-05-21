function [ L, C ] = Gilber_Moor( Px ) 

    pr = 0;
    Q = zeros(1 , size( Px, 2));
    L = ceil((-1*(log10(Px)/log10(2)))+1);    
    for i = 1 : size (Px, 2)
        Q(i) = pr + Px(i)/2;
        pr = pr + Px(i);
    end
    
    for i = 1 : size (Px, 2)
        [ C(i) ] = bin_coder(Q(i), L(i));
    end
    
end

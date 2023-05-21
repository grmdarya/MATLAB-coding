function [ L, C ] = Shennon_coder( Px ) %, Arr_P, L, C
    
    Q = zeros(1 , size( Px, 2));
    L = ceil(-log2(Px));    
    Q(1) = 0;
    for i = 1 : (size (Px, 2) - 1)
        Q(i+1) = Q(i) + Px(i);
    end
    
    for i = 1 : size (Px, 2)
        [ C(i) ] = bin_coder(Q(i), L(i));
    end
    
end


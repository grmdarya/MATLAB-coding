function [ ] = Arithmetic_coder(c, ax, Px, ay, Py, az, Pz)

Qx = zeros(1 , size( Px, 2));
Qy = zeros(1 , size( Py, 2));
Qz = zeros(1 , size( Pz, 2));
e_x = 0;
e_y = 0;
e_z = 0;
p_1 = 1;
p_2 = 1;
p_3 = 1;

[ mas, mas_1 ] = multiplicity_6(c); 
K = length(mas)*6; 
N = size(mas,2);

Qx(1) = 0;
for i = 1 : (size (Px, 2) - 1)
        Qx(i+1) = Qx(i) + Px(i);
end
Qy(1) = 0;
for i = 1 : (size (Py, 2) - 1)
        Qy(i+1) = Qy(i) + Py(i);
end
Qz(1) = 0;
for i = 1 : (size (Pz, 2) - 1)
        Qz(i+1) = Qz(i) + Pz(i);
end

[P_1, P_2, P_3] = fun(mas_1, ax, Px, ay, Py, az, Pz);
[Q_1, Q_2, Q_3] = fun(mas_1, ax, Qx, ay, Qy, az, Qz);

    for i = 1 : N
        F = 0;
        G = 1;
        for j = 1 : 6
            F = F + G*Q_1(p_1);
            G = G * P_1(p_1);
            p_1 = p_1 + 1;    
        end
            e_x = e_x + ceil(-log2(G/2));
            [ C_1{i} ] = bin_coder_string((F+G/2), ceil(-log2(G/2)));
        F = 0;
        G = 1;
        for j = 1 : 3
            F = F + G*Q_2(p_2);
            G = G * P_2(p_2);
            p_2 = p_2 + 1;    
        end
            e_y = e_y + ceil(-log2(G/2));
            [ C_2{i} ] = bin_coder_string((F+G/2), ceil(-log2(G/2)));
        F = 0;
        G = 1;
        for j = 1 : 2
            F = F + G*Q_3(p_3);
            G = G * P_3(p_3);
            p_3 = p_3 + 1;    
        end
            e_z = e_z + ceil(-log2(G/2));
            [ C_3{i} ] = bin_coder_string((F+G/2), ceil(-log2(G/2)));
    end  
    
    e_x = e_x/K;
    e_y = e_y/(K/2);
    e_z = e_z/(K/3);
    R_x = e_x / 1;
    R_y = e_y / 2;
    R_z = e_z / 3;
    
    WriteToFileArithmetic_coder(C_1, C_2, C_3, e_x, e_y, e_z, R_x, R_y, R_z, N);

end


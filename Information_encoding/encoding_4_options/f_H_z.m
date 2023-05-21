function [ H_z H_z_n H_conv_z] = f_H_z(PzIz, H_conv_y, H_x)

    H_z = 0;
    for i = 1:size(PzIz, 2)
        H_z = H_z + PzIz(i);
    end
    
    H_z_n = H_z / 3;
    H_conv_z = H_z - H_conv_y - H_x;

end
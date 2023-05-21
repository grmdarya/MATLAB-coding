function [ H_x H_x_n H_conv_x] = f_H_x(PxIx)

    H_x = 0;
    for i = 1:size(PxIx, 2)
        H_x = H_x + PxIx(i);
    end
    
    H_x_n = H_x;
    H_conv_x = H_x;

end


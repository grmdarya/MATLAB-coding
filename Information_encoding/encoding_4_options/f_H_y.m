function [ H_y H_y_n H_conv_y] = f_H_y(PyIy, H_x)

    H_y = 0;
    for i = 1:size(PyIy, 2)
        H_y = H_y + PyIy(i);
    end
    
    H_y_n = H_y / 2;
    H_conv_y = H_y - H_x;

end
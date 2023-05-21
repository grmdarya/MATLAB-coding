function [R, G, B] = divide_rgb(file)
% Разделение на R, G, B
    R = file(1:2:end, 1:2:end);
    G = zeros(1024, 640, 'uint16');
    G(1:2:end) = file(1:2:end, 2:2:end);
    G(2:2:end) = file(2:2:end, 1:2:end);
    B = file(2:2:end, 2:2:end);
end


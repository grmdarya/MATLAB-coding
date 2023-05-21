function rggb_image = unite_rgb(R, G, B)

    rggb_image = zeros(1024, 1280, 'uint16');

    rggb_image(1:2:end, 1:2:end) = R;
    rggb_image(1:2:end, 2:2:end) = G(1:2:end, :);
    rggb_image(2:2:end, 1:2:end) = G(2:2:end, :);
    rggb_image(2:2:end, 2:2:end) = B;
    
end


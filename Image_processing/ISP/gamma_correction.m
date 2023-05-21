function image_gamma = gamma_correction(image)
% Gamma correction

%  gamma = 0.45;
%  image_gamma = (double(image) / (2^16-1)) .^ gamma;
%  image_gamma = uint16(image_gamma * (2^16-1));
 
 %file_gamma = adapthisteq(file,'clipLimit',0.004);
 
%  image_gamma = imadjust(image, stretchlim(image));

    image_gamma = zeros(size(image), 'uint16');
    image_gamma(:, :, 1) = histeq(image(:, :, 1));
    image_gamma(:, :, 2) = histeq(image(:, :, 2));
    image_gamma(:, :, 3) = histeq(image(:, :, 3));
 
end


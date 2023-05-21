function [main_P, im1_P, im2_P, im3_P, im4_P] = CART_TO_POLAR(main_A, im1_A, im2_A, im3_A, im4_A)
    % Перевод амплитуд в полярно-логарифмические координаты
    main_P = toPolarLog(main_A);
    im1_P = toPolarLog(im1_A);
    im2_P = toPolarLog(im2_A);
    im3_P = toPolarLog(im3_A);
    im4_P = toPolarLog(im4_A);
    
    figure, imshow(main_P, []), title('Polar main');
    figure, imshow(im1_P, []), title('Polar enlarge');
    figure, imshow(im2_P, []), title('Polar shift');
    figure, imshow(im3_P, []), title('Polar rotate');
    figure, imshow(im4_P, []), title('Polar dark');
end

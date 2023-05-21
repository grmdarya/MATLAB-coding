function [main_A, im1_A, im2_A, im3_A, im4_A] = FFT_GET_MAGNITUDE(main, im1, im2, im3, im4)
    % Получение амплитуд Фурье гармоник
    % Нормализация изображений
    main = double(main)/255.0;
    im1 = double(im1)/255.0;
    im2 = double(im2)/255.0;
    im3 = double(im3)/255.0;
    im4 = double(im4)/255.0;
 
    % Вычисление амплитуд Фурье-гармоник, сдвинутых в центр
    main_A = abs(fftshift(fft2(main)));
    im1_A = abs(fftshift(fft2(im1)));
    im2_A = abs(fftshift(fft2(im2)));
    im3_A = abs(fftshift(fft2(im3)));
    im4_A = abs(fftshift(fft2(im4)));
    
    figure, imshow(main_A, []), title('FFT magnitude main');
    figure, imshow(im1_A, []), title('FFT magnitude enlarge');
    figure, imshow(im2_A, []), title('FFT magnitude shift');
    figure, imshow(im3_A, []), title('FFT magnitude rotate');
    figure, imshow(im4_A, []), title('FFT magnitude dark');
end

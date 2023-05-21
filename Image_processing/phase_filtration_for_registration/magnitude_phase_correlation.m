% Амплитудно-фазовая корреляционная функция
% Вычисление обратного преобразования Фурье

Z = main_F2 .* conj(main_F2);
C = (1/512) * 2 * abs((ifftshift(ifft(Z))));
figure, imshow(C);
 
Z = main_F2 .* conj(im1_F2);
C = (1/512) * (1/512) * abs((ifftshift(ifft(Z))));
figure, imshow(C);
 
Z = main_F2 .* conj(im2_F2);
C = (1/512) * (1/512) * abs((ifftshift(ifft(Z))));
figure, imshow(C);
 
Z = main_F2 .* conj(im3_F2);
C = (1/512) * (1/512) * abs((ifftshift(ifft(Z))));
figure, imshow(C);
 
Z = main_F2 .* conj(im4_F2);
C = (1/512) * (1/512) * abs((ifftshift(ifft(Z))));
figure, imshow(C);

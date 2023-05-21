clear all
clc
%% Импорт фотографий
% Исследуемый эталон
main = rgb2gray(imread('im_1.png')); % Исходное изображение
% Измененные эталоны
im_enlarge = rgb2gray(imread('im_2.png'));  % Увеличенное 40%
im_shift = rgb2gray(imread('im_3.png'));  % Смещенное на 15%
im_rot = rgb2gray(imread('im_4.png'));  % Повернутое на 50 градусов
im_dark = rgb2gray(imread('im_5.png'));  % Затемненное
 
figure, imshow(main);
figure, imshow(im_enlarge);
figure, imshow(im_shift);
figure, imshow(im_rot);
figure, imshow(im_dark);
 
% Свёртка изображений с высокочастотным фильтром 
% kernel = [0, -1/4, 0; -1/4, 2, -1/4; 0, -1/4, 0];
% kernel = [0, 1, 0; 1, -4, 1; 0, 1, 0];
% kernel = [-1/9, -1/9, -1/9;
%           -1/9, 8/9, -1/9;
%           -1/9, -1/9, -1/9];
% main = conv2(main, kernel, 'same');
% im1 = conv2(im1, kernel, 'same');
% im2 = conv2(im2, kernel, 'same');
% im3 = conv2(im3, kernel, 'same');
%% Вычисление амплитуд Фурье-гармоник изображений и перевод их в полярно-логарифмическую систему
[main_A, im1_A, im2_A, im3_A, im4_A] = FFT_GET_MAGNITUDE(main, im_enlarge, im_shift, im_rot, im_dark);
[main_P, im1_P, im2_P, im3_P, im4_P] = CART_TO_POLAR(main, im1_A, im2_A, im3_A, im4_A);
 
%% Вычисление фазовой корреляции 
% Изображения квадратные
% Размеры массивов модулей спектров и образов в п.л.координатах одинаковы
% Вычисление двумерного преобразования Фурье для образов
[main_F2, im1_F2, im2_F2, im3_F2, im4_F2] = FOURIER_TRANSFORM(main_P, im1_P, im2_P, im3_P, im4_P);
 
% Амплитудно-фазовая корреляционная функция
% Вычисление обратного преобразования Фурье
[main_IF2, im1_IF2, im2_IF2, im3_IF2, im4_F2] = INV_FOURIER_TRANSFORM(main_F2, im1_F2, im2_F2, im3_F2, im4_F2);
 
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

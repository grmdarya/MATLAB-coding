% Имитация внутреннего алгоритма преобразования RAW -> sRGB изображения состоит из шагов:
% 1) Чтение сырого кадра
% 2) шумоподавление
% 3) баланс белого методом среднеквадратичного отклонения
% 4) демозайкинг
% 5) гамма коррекция
clc; clear all;

% Деление набора кадров (10 RAW кадров) на отдельные.
file_size = 1024 * 1280 * 2;
separate_file('dump_yellow/dump_yellow_color_10_frames.raw', 'im', file_size);

% Чтение какого-то определённого кадра	
file = read_image('im_4.raw', '*uint16', [1280 1024], 16);

% Получение R G B из rggb raw image
[R, G, B] = divide_rgb(file);

% Удаление шума
[R, G, B]    = denoise(R, G, B);
file_denoise = unite_rgb(R, G, B);

% Gray World
% [R, G, B] = divide_rgb(file_denoise);
% R_max = max(R, [],  'all');
% G_max = max(G, [],  'all');
% B_max = max(B, [],  'all');

% rgb_corr = [ G_max / R_max, 1, G_max / B_max];

% newR = R * rgb_corr(1);
% newG = G * rgb_corr(2);
% newB = B * rgb_corr(3);

% file_gw = unite_rgb(newR, newG, newB);


% Баланс белого по среднему отклонению
stdAvgR = std_avg(R, [5 4]);
stdAvgG = std_avg(G, [5 8]);
stdAvgB = std_avg(B, [5 4]);

stdAvgRGB = stdAvgR + stdAvgG + stdAvgB;

rgb_corr = [
     stdAvgRGB / (3 * stdAvgR)
     stdAvgRGB / (3 * stdAvgG)
     stdAvgRGB / (3 * stdAvgB)
 ];
 
R = R * rgb_corr(1);
G = G * rgb_corr(2);
B = B * rgb_corr(3);

file_wb = unite_rgb(R, G, B);

% Демозаикинг
file_demosaic = demosaic(file_wb, 'rggb');
file_wpr = WhitePatchRetinex(file_demosaic, 1);

% Гамма коррекция
file_gamma = gamma_correction(file_demosaic);

figure(1); imshow(file); title('Raw image');                % сырое
figure(2); imshow(file_denoise); title('Denoised');         % сглаженное
figure(3); imshow(file_wb); title('SDWGW');                 % баланс белого
% figure(3), imshow(file_gw); title('GRAY WORLD');          % GRAY WORLD ASSUMPTION
figure(4); imshow(file_demosaic); title('Demosaic image');  % деиозайка
figure(5); imshow(file_gamma); title('Gamma image');        % гамма коррекцияS

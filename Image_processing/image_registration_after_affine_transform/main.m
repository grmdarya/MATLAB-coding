clear all
img_num = 1;
im1 = imread('E:\APP\image_1_my.pcx');
im_unknown = imread('E:\APP\image_4_my.pcx'); %неизвестное изображение
 
%%Нормализация и вывод
newIm1 = normalize(im1);
newIm2 = normalize(im_unknown);
 
figure(1); imshow(im1);
figure(2); imshow(im_unknown);
figure(3); imshow(newIm1);
figure(4); imshow(newIm2);
 
%% Считаем амплитуду
A1=calc_magnitude(newIm1);
A2=calc_magnitude(newIm2);
 
imagesc(A1);
imagesc(A2);
 
%% Считаем расстояние
dist = norm(A1 - A2);
dist_default = Inf;
img_found = false;
if dist_default > dist
    dist_default = dist;
    img_found = true;
end
if img_found 
    fprintf("Distance between unknown and etalon = %d", dist_default);
end

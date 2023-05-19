clc, clear all, close('all');
%% Подготовка изображения
Img = imread('house.jpg');
[rows,cols,dims] = size(Img);
% Если цветное изображение, то перевести в полутона
if dims == 3
    Img = rgb2gray(Img);
end
Img = double(Img);
% Перевести в 8-битное
Img = uint8(255 * (Img - min(Img(:))) / (max(Img(:)) - min(Img(:)))); 
figure, imagesc(Img);title('Оригинал'),axis off, axis image, colormap(gray);
 
%% Сегментация методом Оцу
[Frequency,bins] = imhist(Img);
 
figure,stem(bins,Frequency);title('График частоты');xlabel('Уровень яркости'),ylabel('Частота');
 
mg = mean(Img(:)); % средняя яркость по всему изображению
 
hold on, line([mg mg],[0 max(Frequency)],'Color',[1 0 0]);

Sigma_B = zeros(1,256);
quality = Sigma_B;
NormalizedFreq = Frequency / (rows * cols); %нормированная частота
 
figure,stem(bins,NormalizedFreq);title('Нормированная частота');xlabel('Уровень яркости'),ylabel('Частота');
Sigma_G = var(double(Img(:))); %дисперсия яркости всех пикселей изображения
 
We are starting from k 1 till 254 because at k=0, P1 = 0 and at k = 255,
P1 = 1 therefore P2 = 1 - P1 = 0;
for k = 1:255-1
    P1 = sum(NormalizedFreq(1:k+1)); % вероятность появления класса С1
    mk = sum((NormalizedFreq(1:k+1) .* (0:k)')); % накопленная сумма до уровня яркости К включительно
    Sigma_B(k+1) = (mg * P1 - mk)^2 / (P1 * (1 - P1)); % межклассовая дисперсия
    quality(k+1) = Sigma_B(k+1) / Sigma_G; % качество порога
end

%% Это вариант для двух порогов
thresh = multithresh(Img,2);
seg_I = imquantize(Img,thresh);
figure;
imshow(seg_I, [])

%% Вывод
figure,plot(Sigma_B);xlabel('Пороговое значение'),ylabel('Межкластерная дисперсия');
[~,index]= max(Sigma_B); % оптимальное значение порога (его индекс)
hold on, line([index index],[0 max(Sigma_B)],'Color',[1 0 0]);
figure(2),hold on, line([index index],[0 max(Frequency)],'Color',[1 1 0]);
 
string = sprintf('Изображение с порогом k = %d ',index);
figure,imagesc(Img>index);title(string);axis off, axis image,colormap(gray);
 
figure,plot(bins,quality);title('График качества порога');xlabel('ПОроговое значение'),ylabel('Качество порога - 0 до 1');

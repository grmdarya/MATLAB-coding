clear all
clc
%% ������� �����������
img = imread ('house.png');
figure, imshow(img);
img = rgb2gray(img);
img = double (img);
%% �������� �������
T_Low = 0.075;
T_High = 0.175;
%% ����������� �������� ������
%FILTER_SIZE = 5;
%SIGMA = 1.4;
%gaussian_filter = fspecial('gaussian', FILTER_SIZE, SIGMA);
siz = 5;
siz = (siz-1)/2;
sigma = 2;
[x,y] = meshgrid(-siz:siz,-siz:siz);
arg = -(x.*x + y.*y)/(2*sigma*sigma);
h = exp(arg);
h(h<eps*max(h(:))) = 0;
sumh = sum(h(:));
if sumh ~= 0
    h  = h/sumh;
end
%% ������� �������� ������
A=conv2(img, h, 'same');
% ������ ��� �������������� � ������������ �����������
KGx = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
KGy = [1, 2, 1; 0, 0, 0; -1, -2, -1];
%% ������ ������� �����������
Filtered_X = conv2(A, KGx, 'same');
Filtered_Y = conv2(A, KGy, 'same');
%% ���������� �����������
arah = atan2(Filtered_Y, Filtered_X);
arah = arah*180/pi;
pan=size(A,1);
leb=size(A,2);
%% �������������� ������������� ���������� � �������������
for i=1:pan
    for j=1:leb
        if (arah(i,j)<0) 
            arah(i,j)=360+arah(i,j);
        end
    end
end
arah2=zeros(pan, leb);
%% ���������� ��������� � 0, 45, 90, 135 �������� ����
% ������������� ������������ 
for i = 1  : pan
    for j = 1 : leb
        if ((arah(i, j) >= 0 ) && (arah(i, j) < 22.5) || (arah(i, j) >= 157.5) && (arah(i, j) < 202.5) || (arah(i, j) >= 337.5) && (arah(i, j) <= 360))
            arah2(i, j) = 0;
        elseif ((arah(i, j) >= 22.5) && (arah(i, j) < 67.5) || (arah(i, j) >= 202.5) && (arah(i, j) < 247.5))
            arah2(i, j) = 45;
        elseif ((arah(i, j) >= 67.5 && arah(i, j) < 112.5) || (arah(i, j) >= 247.5 && arah(i, j) < 292.5))
            arah2(i, j) = 90;
        elseif ((arah(i, j) >= 112.5 && arah(i, j) < 157.5) || (arah(i, j) >= 292.5 && arah(i, j) < 337.5))
            arah2(i, j) = 135;
        end
    end
end
figure, imagesc(arah2); colorbar;
%% ��������� ���� ������� ����������
magnitude = (Filtered_X.^2) + (Filtered_Y.^2);
magnitude2 = sqrt(magnitude);
BW = zeros (pan, leb);
%% ���������� �� ���������� ��� �������� ��������
% ����������� ������������ ������ 
for i=2:pan-1
    for j=2:leb-1
        if (arah2(i,j)==0)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i,j+1), magnitude2(i,j-1)]));
        elseif (arah2(i,j)==45)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j-1), magnitude2(i-1,j+1)]));
        elseif (arah2(i,j)==90)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j), magnitude2(i-1,j)]));
        elseif (arah2(i,j)==135)
            BW(i,j) = (magnitude2(i,j) == max([magnitude2(i,j), magnitude2(i+1,j+1), magnitude2(i-1,j-1)]));
        end
    end
end
BW = BW.*magnitude2;
figure, imshow(BW);
%% �������������� ��������� �����
% ���������� ��������� �������� ��� ��������� ������ ������
T_Low = T_Low * max(max(BW));
T_High = T_High * max(max(BW));
T_res = zeros (pan, leb);
for i = 1  : pan
    for j = 1 : leb
        if (BW(i, j) < T_Low)
            T_res(i, j) = 0;
        elseif (BW(i, j) > T_High)
            T_res(i, j) = 1;
        elseif ( BW(i+1,j)>T_High || BW(i-1,j)>T_High || BW(i,j+1)>T_High || BW(i,j-1)>T_High || BW(i-1, j-1)>T_High || BW(i-1, j+1)>T_High || BW(i+1, j+1)>T_High || BW(i+1, j-1)>T_High)
            T_res(i,j) = 1;
        end
    end
end
edge_final = uint8(T_res.*255);
% �������� ���������
figure, imshow(edge_final);
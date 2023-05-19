clc, clear all, close('all');
%% ���������� �����������
Img = imread('house.jpg');
[rows,cols,dims] = size(Img);
% ���� ������� �����������, �� ��������� � ��������
if dims == 3
    Img = rgb2gray(Img);
end
Img = double(Img);
% ��������� � 8-������
Img = uint8(255 * (Img - min(Img(:))) / (max(Img(:)) - min(Img(:)))); 
figure, imagesc(Img);title('��������'),axis off, axis image, colormap(gray);
 
%% ����������� ������� ���
[Frequency,bins] = imhist(Img);
 
figure,stem(bins,Frequency);title('������ �������');xlabel('������� �������'),ylabel('�������');
 
mg = mean(Img(:)); % ������� ������� �� ����� �����������
 
hold on, line([mg mg],[0 max(Frequency)],'Color',[1 0 0]);

Sigma_B = zeros(1,256);
quality = Sigma_B;
NormalizedFreq = Frequency / (rows * cols); %������������� �������
 
figure,stem(bins,NormalizedFreq);title('������������� �������');xlabel('������� �������'),ylabel('�������');
Sigma_G = var(double(Img(:))); %��������� ������� ���� �������� �����������
 
We are starting from k 1 till 254 because at k=0, P1 = 0 and at k = 255,
P1 = 1 therefore P2 = 1 - P1 = 0;
for k = 1:255-1
    P1 = sum(NormalizedFreq(1:k+1)); % ����������� ��������� ������ �1
    mk = sum((NormalizedFreq(1:k+1) .* (0:k)')); % ����������� ����� �� ������ ������� � ������������
    Sigma_B(k+1) = (mg * P1 - mk)^2 / (P1 * (1 - P1)); % ������������ ���������
    quality(k+1) = Sigma_B(k+1) / Sigma_G; % �������� ������
end

%% ��� ������� ��� ���� �������
thresh = multithresh(Img,2);
seg_I = imquantize(Img,thresh);
figure;
imshow(seg_I, [])

%% �����
figure,plot(Sigma_B);xlabel('��������� ��������'),ylabel('������������� ���������');
[~,index]= max(Sigma_B); % ����������� �������� ������ (��� ������)
hold on, line([index index],[0 max(Sigma_B)],'Color',[1 0 0]);
figure(2),hold on, line([index index],[0 max(Frequency)],'Color',[1 1 0]);
 
string = sprintf('����������� � ������� k = %d ',index);
figure,imagesc(Img>index);title(string);axis off, axis image,colormap(gray);
 
figure,plot(bins,quality);title('������ �������� ������');xlabel('��������� ��������'),ylabel('�������� ������ - 0 �� 1');

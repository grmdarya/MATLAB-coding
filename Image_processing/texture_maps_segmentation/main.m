clear variables
%% Формируем мозаику 
 
img1 = imread('D1.png');
img2 = imread('D2.png');
img3 = imread('D3.png');
img4 = imread('D4.png');
 
mosaic = [
    img1 img2;
    img3 img4
];
 
figure;
imshow(mosaic);
title('Mosaic of images');
 
% Смещения
offsets = [
     0  5;
     5  5;
     5  0;
     5 -5;
     0 -5;
    -5 -5;
    -5  0;
    -5  5
] ;
 
EIGHT = 8;
 
%Nd1 = cell(1, EIGHT); Зачем нужен?
SI1 = cell(1, EIGHT);
list_vectors = cell(1 ,EIGHT);
 
% Матрица рассеяния
for i = 1 : EIGHT
    [list_vectors{i}, SI1{i}] ...
        = graycomatrix(mosaic, 'Offset', offsets(i, :));
end
 
COUNT_CELLS = size(list_vectors, 2);
 
p = cell(1, COUNT_CELLS);
 
for i = 1 : COUNT_CELLS
    temp = sum(sum(list_vectors{i}));
    p{i} = list_vectors{i} / temp; 
end
 
disp("passed 1");
 
ksi = cell(1, COUNT_CELLS);
a = size(list_vectors{1}, 1);
b = size(list_vectors{1}, 2);
 
for v = 1 : COUNT_CELLS
    
    temp = 0;
    temp_a = 0;
    temp_b = 0;
    
    for i = 1 : a
        
        for j = 1 : b
            
            temp_a = sum(p{v}(i, :));
            temp_b = sum(p{v}(:, j));
            
            if temp_a ~= 0 && temp_b ~= 0
                % критерий для нормированной таблицы рассеяния p 
                temp = temp + (p{v}(i, j)^2) / (temp_a * temp_b);
            end
            
        end
        
    end
    
    temp = temp - 1;
    ksi{v} = temp;
    
end
 
% ШАГ 1. оптимальный вектор смещения
[val, arg] = max(cell2mat(ksi)); 
m_a = {}; 
m_b = {};
 
% Расчитаем математическое ожидание
m_a{end + 1} = math_expt(p{arg}, a, b, 0);
m_b{end + 1} = math_expt(p{arg}, a, b, 1);
 
% Рассчитаем среднеквадратичное отклонение
sigma_a = {}; sigma_b = {};
sigma_a{end + 1} = deviant_std(p{arg}, a, b, 0, m_a{1});
sigma_b{end + 1} = deviant_std(p{arg}, a, b, 1, m_b{1});
 
% Характеристики, используемые в качестве в качестве признаков текстуры
param = {};
param{end + 1} = covariance(p{arg}, a, b, m_a{1}, m_b{1});
param{end + 1} = contrast(p{arg}, a, b);
param{end + 1} = abs_diff_mean(p{arg}, a, b);
param{end + 1} = energy(p{arg}, a, b);
param{end + 1} = entropy(p{arg}, a, b);
param{end + 1} = reverse(p{arg}, a, b);
param{end + 1} = uniformity(p{arg}, a, b);
param{end + 1} ...
    = corr(p{arg}, a, b, m_a{1}, m_b{1}, sigma_a{1}, sigma_b{1});
disp("passed 2");
 
% ШАГ 2. Матрицы рассеяния с оптимальным вектором смещения для эталонных образцов текстур
[matr_1, SI11] = graycomatrix(img1, 'Offset', offsets(arg, :));
[matr_2, SI22] = graycomatrix(img2, 'Offset', offsets(arg, :));
[matr_3, SI33] = graycomatrix(img3, 'Offset', offsets(arg, :));
[matr_4, SI44] = graycomatrix(img4, 'Offset', offsets(arg, :));
 
%  ШАГ 3. Нормированная матрица рассеяния для каждого эталонного браза текстуры
n_1 = matr_1 / sum(sum(matr_1));
n_2 = matr_2 / sum(sum(matr_2));
n_3 = matr_3 / sum(sum(matr_3));
n_4 = matr_4 / sum(sum(matr_4));
 
% Расчет набора признаков текстуры 1
m_11 = math_expt(n_1, a, b, 0);
m_12 = math_expt(n_1, a, b, 1);
sigma_11 = deviant_std(n_1, a, b, 0, m_11);
sigma_12 = deviant_std(n_1, a, b, 1, m_12);
param_1 = zeros(1, 8);
param_1(1) = covariance(n_1, a, b, m_11, m_12);
param_1(2) = contrast(n_1, a, b);
param_1(3) = abs_diff_mean(n_1, a, b);
param_1(4) = energy(n_1, a, b);
param_1(5) = entropy(n_1, a, b);
param_1(6) = reverse(n_1, a, b);
param_1(7) = uniformity(n_1, a, b);
param_1(8) = corr(n_1, a, b, m_11, m_12, sigma_11, sigma_12);
 
% Расчет набора признаков текстуры 2
m_21 = math_expt(n_2, a, b, 0);
m_22 = math_expt(n_2, a, b, 1);
sigma_21 = deviant_std(n_2, a, b, 0, m_21);
sigma_22 = deviant_std(n_2, a, b, 1, m_22);
param_2 = zeros(1, 8);
param_2(1) = covariance(n_2, a, b, m_21, m_22);
param_2(2) = contrast(n_2, a, b);
param_2(3) = abs_diff_mean(n_2, a, b);
param_2(4) = energy(n_2, a, b);
param_2(5) = entropy(n_2, a, b);
param_2(6) = reverse(n_2, a, b);
param_2(7) = uniformity(n_2, a, b);
param_2(8) = corr(n_2, a, b, m_21, m_22, sigma_21, sigma_22);
 
% Расчет набора признаков текстуры 3
m_31 = math_expt(n_3, a, b, 0);
m_32 = math_expt(n_3, a, b, 1);
sigma_31 = deviant_std(n_3, a, b, 0, m_31);
sigma_32 = deviant_std(n_3, a, b, 1, m_32);
param_3 = zeros(1, 8);
param_3(1) = covariance(n_3, a, b, m_31, m_32);
param_3(2) = contrast(n_3, a, b);
param_3(3) = abs_diff_mean(n_3, a, b);
param_3(4) = energy(n_3, a, b);
param_3(5) = entropy(n_3, a, b);
param_3(6) = reverse(n_3, a, b);
param_3(7) = uniformity(n_3, a, b);
param_3(8) = corr(n_3, a, b, m_31, m_32, sigma_31, sigma_32);
 
% Расчет набора признаков текстуры 4
m_41 = math_expt(n_4, a, b, 0);
m_42 = math_expt(n_4, a, b, 1);
sigma_41 = deviant_std(n_4, a, b, 0, m_41);
sigma_42 = deviant_std(n_4, a, b, 1, m_42);
param_4 = zeros(1, 8);
param_4(3) = abs_diff_mean(n_4, a, b);
param_4(4) = energy(n_4, a, b);
param_4(5) = entropy(n_4, a, b);
param_4(6) = reverse(n_4, a, b);
param_4(7) = uniformity(n_4, a, b);
param_4(8) = corr(n_4, a, b, m_41, m_42, sigma_41, sigma_42);
 
% ШАГ 4. В окне построить матрицы рассеяния и рассчитать набор признаков текстуры
N = 40;
mos_size_line = size(mosaic, 1);
mos_size_column = size(mosaic, 2);
 
r_l = fix(N / 2) - (1 - mod(N, 2));
r_r = fix(N / 2);
 
windowCenter = round(N /2);
 
w_line = mos_size_line - N + 1;
w_column = mos_size_column - N + 1;
w = cell(w_line, w_column);
 
for i = windowCenter : mos_size_line - r_r
    
    for j = windowCenter : mos_size_column - r_r
        
        w{i - windowCenter + 1, j - windowCenter + 1} ...
            = SI1{arg}(i - r_l : i + r_r, j - r_l : j + r_r);
        
    end
    
end
 
w_n = cell(w_line, w_column);
 
for i = 1 : w_line
    
    for j = 1 : w_column
        
        w_n{i, j} = w{i, j} / sum(sum(w{i, j}));
        
    end
    
end
 
P = cell(w_line, w_column);
 
for i = 1 : w_line
    
    for j = 1 : w_column
        
        m1 = math_expt(w_n{i, j}, N, N, 0);
        m2 = math_expt(w_n{i, j}, N, N, 1);
        s1 = deviant_std(w_n{i, j}, N, N, 0, m1);
        s2 = deviant_std(w_n{i, j}, N, N, 1, m2);
        p1 = covariance(w_n{i, j}, N, N, m1, m2);
        p2 = contrast(w_n{i, j}, N, N);
        p3 = abs_diff_mean(w_n{i, j}, N, N);
        p4 = energy(w_n{i, j}, N, N);
        p5 = entropy(w_n{i, j}, N, N);
        p6 = reverse(w_n{i, j}, N, N);
        p7 = uniformity(w_n{i, j}, N, N);
        p8 = corr(w_n{i, j}, N, N, m1, m2, s1, s2);
        P{i, j} = [p1 p2 p3 p4 p5 p6 p7 p8];
        
    end
    
end
 
% ШАГ 5. Сопоставление
T = zeros(w_line, w_column);
 
for i = 1 : w_line
    
    for j = 1 : w_column
        
         X1 = sqrt(sum(power(P{i, j} - param_1, 2)));
         X2 = sqrt(sum(power(P{i, j} - param_2, 2)));
         X3 = sqrt(sum(power(P{i, j} - param_3, 2)));
         X4 = sqrt(sum(power(P{i, j} - param_4, 2)));
         vubor = [X1 X2 X3 X4];
         [s, pos] = min(vubor);
         
         if(pos == 1)
             T(i, j) = 0;
         elseif(pos == 2)
             T(i, j) = 0.5;
         elseif(pos == 3)
             T(i, j) = 0.75;
         elseif(pos == 4)
             T(i, j) = 1;
         end
         
    end
    
end
 
figure;
imshow(T);

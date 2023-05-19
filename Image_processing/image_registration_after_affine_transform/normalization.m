function newIm1 = normalize(img)
Xc = 0;
Yc = 0;
sumT = sum(sum(img));
lengthM = length(img(1, :));
vecXY = 1 : lengthM;
i = 1;
while i <= lengthM
    Xc = Xc + sum(vecXY .* double(img(i, :)));
    Yc = Yc + sum(vecXY .* double(img(:, i)'));
    i = i + 1;
end
 
Xc = Xc / sumT;
Yc = Yc / sumT;
 
B = 0;
C = 0;
D = 0;
 
tmpVecX = vecXY - Xc;
tmpVecY = vecXY - Yc;
 
i = 1;
while i <= lengthM
    B = B + sum( double(img(i, :)) .* (tmpVecX.^2 - tmpVecY(i)^2));
    C = C + sum( tmpVecX .* double(img(i, :)) * 2 * tmpVecY(i));
    D = D + sum( double(img(i, :)) .* (tmpVecX.^2 + tmpVecY(i)^2));
    i = i + 1;
end
 
mi = D + sqrt(C * C + B * B);
mi = mi / (D - sqrt(C * C + B * B));
mi = sqrt(mi);
 
n = 1;
teta = 0.5 * atan2(C, B) + pi * n;
newIm1X = zeros(lengthM);
newIm1Y = zeros(lengthM);
 
M = 0;
 
i = 1;
while i <= lengthM
    j = 1;
    while j <= lengthM
        tmp1 = tmpVecX(j) * cos(-teta);
        tmp1 = tmp1 - tmpVecY(i) * sin(-teta);
        
        tmp2 = tmpVecX(j) * sin(-teta);
        tmp2 = tmp2 + tmpVecY(i) * cos(-teta);
        
        newIm1X(i, j) = tmp1 * cos(teta) / mi;
        newIm1X(i, j) = newIm1X(i, j) - tmp2 * sin(teta);
        
        newIm1Y(j, i) = tmp1 * sin(teta) / mi;
        newIm1Y(j, i) = newIm1Y(j, i) + tmp2 * cos(teta);
        
        tmp = newIm1X(i, j)^2 + newIm1Y(j, i)^2;
        tmp = sqrt(tmp);
        tmp = sum(tmp * double(img(i, j)));
 
        M = M + tmp;  
        j = j + 1;   
    end
    
    i = i + 1;
   
end
K = 10;
M = M / (K * sumT);
 
newIm1X = int32(newIm1X / M + Xc);
newIm1Y = int32(newIm1Y / M + Yc);
 
newIm1 = uint8(zeros(lengthM));
 
i = 1;
while i <= lengthM
    j = 1;
    while j <= lengthM
        newIm1(newIm1Y(j, i), newIm1X(i, j)) = img(i, j);
        j = j + 1;       
    end    
    i = i + 1;   
end

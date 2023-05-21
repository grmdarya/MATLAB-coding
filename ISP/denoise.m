function [newR, newG, newB] = denoise(R, G, B)
% Слабо убирает шум и мало размазывает    
%     newR = imgaussfilt(R);
%     newG = imgaussfilt(G);
%     newB = imgaussfilt(B);

% Guided filter
    newR = imguidedfilter(R);
    newG = imguidedfilter(G);
    newB = imguidedfilter(B);
%     newR = imbilatfilt(R);
%     patch = imcrop(R,[170, 35, 50 50]);
%     imshow(patch);
%     patchVar = std2(patch)^2;
%     DoS = 2*patchVar;
%     newR = imbilatfilt(R);
%     
%     newR = imbilatfilt(G);
%     patch = imcrop(G,[170, 35, 50 50]);
%     imshow(patch);
%     patchVar = std2(patch)^2;
%     DoS = 2*patchVar;
%     newG = imbilatfilt(G);
%     
%     newR = imbilatfilt(B);
%     patch = imcrop(B,[170, 35, 50 50]);
%     imshow(patch);
%     patchVar = std2(patch)^2;
%     DoS = 2*patchVar;
%    newB = imbilatfilt(B);
%    
%Лучше убирает шум, но слегка размазывает
%    newR = medfilt2(R);
%    newG = medfilt2(G);
%    newB = medfilt2(B);
    
end


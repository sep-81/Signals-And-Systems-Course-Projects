clc
close all
format long g

% PROJECT 01 / SIGNALS AND SYSTEMS / license plate identification
% SEPTEMBRE 2022 / IRAN ZARE & SEPEHR AZARDAR

A = imread('./images/image5.jpg');
figure(3)
imshow(A)
%% GRAY STYLE

aa = rgb2gray(A);
figure (1)
imshow(aa);

%% BLACK & WHITE STYLE

for i = 1 : size(aa,1)
    for j = 1 : size(aa,2)
        if aa(i,j) < 127
            aa(i,j) = 0;
        else
            aa(i,j) = 255;
        end
    end
end

figure (2)
aaa = imshow(aa);

%% SEGMENTATION
% 
% O = zeros(size(aa,1),size(aa,2));
% 
% for i = 1 : size(aa,1)- 1
%     for j = 1 : size(aa,2)-1
%         if aa(i+1,j) - aa(i,j) == 255
%            aa(i,j) = [];
%         end
%     end
% end
% aaaa = imshow(aa);
% 
% close all;
% 
% image_ref = imread('img/image_ref.jpg');
% filter = imread('img/filter.jpg');
% 
% image  = image_ref;
% 
% correlation = normxcorr2(filter(:,:), image(:,:));
% figure, imshow(correlation);
% title('Correlation image');
%     
% [maxCorrValue, maxIndex] = max(abs(correlation(:)));
% [yPeak, xPeak] = ind2sub(size(correlation), maxIndex(1));
% 
% corr_offset = [(xPeak - size(filter, 2)) (yPeak - size(filter, 2))];
% 
% if(corr_offset(1) < 0)
%    corr_offset(1) = corr_offset(1) * (-1); 
% end
% 
% if(corr_offset(2) < 0)
%    corr_offset(2) = corr_offset(2) * (-1); 
% end
% 
% axis on;
% hold on;
% figure, imshow(image);
% title('find area');
% boxRect = [corr_offset(1) corr_offset(2) 200, 200];
% rectangle('position', boxRect, 'edgecolor', 'r', 'linewidth', 2);
clc;           
clear;        
close all;  

% 
di=dir('Alefba');
st={di.name};
nam=st(3:end);
len=length(nam);
fout = [];
out = 'ب.png'
J = imread(['Alefba','\', out]); 
[L,Ne]=bwlabel(J);
[r,c] = find(L==1);
J=J(min(r):max(r),min(c):max(c));
J = imresize(J,[42,24]);
% J = ~J;
imshow(J);
imwrite(J, out);
% J = imread('Alefba\ن.png');
% J = bwareaopen(J,33);
% imshow(J);
% [L,Ne]=bwlabel(J);
% [r,c] = find(L==1);
% J=J(min(r):max(r),min(c):max(c));
% J = imresize(J,[42,24]);
% imshow(J);
% imwrite(J,'ن.png');

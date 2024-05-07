clc;           
clear;        
close all;  


di=dir('Alefba');
st={di.name};
nam=st(3:end);
len=length(nam);
fout = [];
for k=1:len
      out = cell2mat(nam(k)); 
    J = imread(['Alefba','\', out]);
    if class(J) == "logical"
        continue;
    end
    display(class(J));
    if class(J) ~= "uint8"
        J = rgb2gray(J);
    end
    threshold =  graythresh(J);
    picture = ~im2bw(J,threshold);

    [L,Ne]=bwlabel(picture);
    [r,c] = find(L==1);
    picture=picture(min(r):max(r),min(c):max(c));
    picture = imresize(picture,[42,24]);
    imshow(picture);
    imwrite(picture, out);
    %fout = [fout out];
    %fout = [fout "**"];
end
display(fout);
display(nam(20));
display(nam(2));

TRAIN=cell(2,len);
for i=1:len
   out = cell2mat(nam(i)); 
   TRAIN(1,i)={imread(['Alefba','\', out])};
   TRAIN(2,i)={out(1)};
end

save('TRAININGSET.mat','TRAIN');
clear;

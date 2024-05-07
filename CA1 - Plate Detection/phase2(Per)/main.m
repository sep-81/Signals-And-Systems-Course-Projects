clc
close all;
clear;
load TRAININGSET.mat;
totalLetters=size(TRAIN,2);
ty = TRAIN(1,10);
imshow(cell2mat(ty));
ty = TRAIN(1,8);
imshow(cell2mat(ty));

% SELECTING THE TEST DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[file,path]=uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Choose an image');
s=[path,file];
picture=imread(s);
figure
%figure%
subplot(1,2,1)
imshow(picture)
picture=imresize(picture,[300 500]);
subplot(1,2,2)
imshow(picture)


%RGB2GRAY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

picture=rgb2gray(picture);
figure
subplot(1,2,1)
imshow(picture)

% THRESHOLDIG and CONVERSION TO A BINARY IMAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
threshold = graythresh(picture);
min1 = min(picture);
min2 = min(min1,[],2);
max1 = max(picture);
max2 = max(max1,[],2);
picture1 =~im2bw(picture,threshold);
amp = 1.5;% or 1;
threshold = threshold/amp;
pictureAmp = ~im2bw(picture,threshold);
threshold = threshold * amp * amp
picture2 = ~im2bw(picture,threshold);
subplot(1,2,2)
imshow(picture1)
plate = cal_plate(picture1,TRAIN);
final_output = plate;
%if size(plate,2) ~= 8
plateAmp = cal_plate(pictureAmp,TRAIN);
plate2 = cal_plate(picture2, TRAIN);
%final_output = [final_output ' ** ' plateAmp ' ** ' plate2];
% sizes = [size(plate,2), size(plateAmp,2), size(plate2,2)];
% [maxV,maxIn] = max(sizes);
% if maxIn == 2
%     final_output = plateAmp;
% else
%     if maxIn == 3
%         final_output = plate2;
%     end
% end

% Printing the plate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = fopen('number_Plate.txt', 'wt+');
fprintf(file,'%s\n',final_output);
fprintf(file,'%s\n',plateAmp);
fprintf(file,'%s\n',plate2);
fclose(file);
winopen('number_Plate.txt')



function plate_name=cal_plate(picture, TRAIN)
    totalLetters=size(TRAIN,2);
    % Removing the small objects and background
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%
    figure
    % picture = bwareaopen(picture,30); % removes all connected components (objects) that have fewer than 30 pixels from the binary image BW
    picture = bwareaopen(picture,10); 
    subplot(1,3,1)
    imshow(picture)
    background=bwareaopen(picture,5500);
    subplot(1,3,2)
    imshow(background)
    picture2=picture-background;
    subplot(1,3,3)
    imshow(picture2)
    % picture2=bwareaopen(picture2,200);
    % subplot(1,4,4)
    % imshow(picture2)
    %%
    
    
    % Labeling connected components
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    imshow(picture2)
    [L,Ne]=bwlabel(picture2);
    propied=regionprops(L,'BoundingBox');
    hold on
    for n=1:size(propied,1)
        rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    end
    hold off
    
    
    
    % Decision Making
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure
    final_output=[];
    t=[];
    freq = [;];
    tresh = 0.5;
    %l,w;%
    flag = false;
    zero_pic = cell2mat(TRAIN(1,1));
    for n=1:Ne
     [r,c] = find(L==n);
        length = max(r) - min(r);
        %thresh = length * 0.15;%
        for i=1:size(freq, 1)
            flag = false;
            cur_len = freq(i,1);
            lim = cur_len * tresh;
            cur_base = freq(i, 2);
            if abs(cur_base - max(r)) < lim && freq(4) <= min(c)
                if  abs(cur_len - length) < lim
                    freq(i,5) = freq(i,5) + 1;
                    freq(i,4) = max(c);
                    flag = true;
                else
                    Y=picture2(min(r):max(r),min(c):max(c));
                    Y=imresize(Y,[42,24]);
                    if corr2(zero_pic, Y) > 0.4
                        freq(i,5) = freq(i,5) + 1;
                        freq(i,4) = max(c);
                        flag = true;
                    end
                end
            end
        end
        if ~flag

            freq = [freq; [length, max(r), min(c), max(c), 1]];
        end
    end
    for e=1:5
        final_output = [];
        wids = {};
        [~,maxI] = max(freq(:,5));
        freq(maxI,5) = 0;
        plate = freq(maxI, :);
        lim = plate(1) * tresh;
        cur_base = plate(2);
        min_w = plate(3) - plate(1) * (tresh);
        min_w = floor(min_w) ;
        max_w = plate(4) + plate(1) * (tresh);
        max_w = floor(max_w);
        max_l = plate(2) + plate(1) * (tresh);
        max_l = floor(max_l);
        min_l = plate(2) -  plate(1) * (1+tresh);
        min_l = floor(min_l);
        
        % L = L(min_l:max_l, min_w:max_w);
        % picture2 = picture2(min_l:max_l, min_w:max_w);
        per_max_width = min_w;
        for n=1:Ne
            [r,c] = find(L==n);
            p_min_r = min(r);
            p_max_r = max(r);
            p_min_c = min(c);
            p_max_c = max(c);
            Y=picture2(min(r):max(r),min(c):max(c));
            figure(5);
            hold on
            rectangle('Position',propied(n).BoundingBox,'EdgeColor','r','LineWidth',2)
            hold off
            figure(6);
            imshow(Y)
            Y=imresize(Y,[42,24]);
            if max(r) < max_l && min(r) > min_l && max(c) < max_w && min(c) > per_max_width ...
                  && ( (abs(cur_base - max(r)) < lim) || (corr2(zero_pic, Y) > 0.4) )
                
                length = max(r) - min(r);
                %thresh = length * 0.15;%
            %     for i=1:size(freq, 1)
            %         flag = false;
            %         cur_len = freq(i,1);
            %         lim = cur_len * tresh;
            %         cur_base = freq(i, 2);
            %         if abs(cur_base - min(r)) < lim && abs(cur_len - length) < lim
            %             freq(i,3) = freq(i,3) +1;
            %             flag = true;
            %         end
            %     end
            %     if ~flag
            %         freq = [freq; [length, min(r), 1]];
            %     end
                
                imshow(Y)
                pause(0.2)
                
                
                ro=zeros(1,totalLetters);
                for k=1:totalLetters   
                    ro(k)=corr2(TRAIN{1,k},Y);
                end
                [MAXRO,pos]=max(ro);
                if MAXRO>.45
                    dig_w = max(c) - min(c);
                    
                    per_max_width = max(c);
            %         if pos == 1 || pos == 25 || pos == 51
            %             pos = 1;         
            %         end
                    %imshow(Y);
                    imshow(cell2mat(TRAIN(1,pos)));
                    out=cell2mat(TRAIN(2,pos));
                    if out == '1'
                        dig_w = dig_w *2;
                    end
                    if out == '0'
                        dig_w = dig_w * 3;
                    end
                    flag = false;
                    for r=1:size(wids)
                        wid_1 = cell2mat(wids(r,1));
                        if (-dig_w + wid_1<  0.66 * wid_1) ...
                                && (dig_w - wid_1 <  0.66 * dig_w) 
                            wids{r,2} = cell2mat(wids(r,2)) + 1;
                            wids{r,3} = [cell2mat(wids(r,3)) size(final_output+1,2)+1];
                            flag =true;
                            break;
                        end
                    end
                    if ~flag
                        wids = [wids; {dig_w 1 size(final_output,2)+1}];
                    end

                    final_output=[final_output out];
                end
            end
        end
        display(freq);
        if size(wids)
            [~,ind] = max(cell2mat(wids(:,2)));
            inds = cell2mat(wids(ind,3));
            temp = [];
            for j=1:size(inds,2)
                 temp = [temp final_output(j)];
            end
            final_output = temp;
        end
        display(size(final_output));
        display(final_output);
       if size(final_output,2) >= 5
            break;
       end
    end
    plate_name = final_output;
end


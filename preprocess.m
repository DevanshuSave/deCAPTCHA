close all
clear all
clc

% read the input image
inpImage =imread('51.jpg');

% size of image
[rows cols dims] = size(inpImage);

% check if rgb
if dims==3
    i1=double(rgb2gray(inpImage));
else
    i1=double(inpImage);
end

%thresholding
for i=1:rows
    for j=1:cols
        if(i1(i,j)<127)
           o1(i,j)=0;
        else
            o1(i,j)=255;
        end
    end
end

%applying median filter only for ez gimpy very thin noise
%o2=o1;
%for i=1:2
%    o2=medfilt2(o2);
%end
%o2=~o2;
o1=~o1;

% removing all connected components with no of pixels less than x
x=2;
o3=o1;
o3=bwareaopen(o3,x);

%thinning
o4=o3;
for i=1:3
    o4 = bwmorph(o4,'thin',Inf);
end

%linear segmentation
BW=o4;
BW = bwlabel(BW);
stats = regionprops(BW);
for index=1:length(stats)
if stats(index).Area > 30
x = ceil(stats(index).BoundingBox(1))
y= ceil(stats(index).BoundingBox(2))
widthX = floor(stats(index).BoundingBox(3)-1)
widthY = floor(stats(index).BoundingBox(4)-1)
subimage(index) = {BW(y:y+widthY,x:x+widthX)};
figure, imshow(subimage{index})
end
end



%imwrite(o2,'ez11.jpg','jpg');
%imwrite(o3,'ez12.jpg','jpg');

figure,imshow(inpImage);
figure,imshow(o1);
%figure,imshow(o2);
figure,imshow(o3);
figure,imshow(o4);

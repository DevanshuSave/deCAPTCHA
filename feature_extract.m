function [features]=feature_extract(subimage_index)
% subimage_index =imread('4 (61).png');

%--------------------------------------feature xtraction 1-----------------------------------------
[rows cols dims] = size(subimage_index);
xyratio=rows/cols;
subimage_index1 = imresize(subimage_index,[30 24],'bicubic');
[rows cols dims] = size(subimage_index1);
binarysubimage_index1 = subimage_index1 > 0.02;
fv1(6)= xyratio;
if(fv1(6)>4)  
    fv1(6)=1;
else
    fv1(6)=fv1(6)/4;
end
for i=1:rows
    for j=1:cols
        if(binarysubimage_index1(i,j)~=0)
            fv1(1)=fv1(1)+1;
            if(j<=cols/2)
                fv1(2)=fv1(2)+1;
            else
                fv1(3)=fv1(3)+1;
            end
            if(i<=rows/2)
                fv1(4)=fv1(4)+1;
            else
                fv1(5)=fv1(5)+1;
            end
        end
    end
end
% for i=2:5
%     fv1(i)=fv1(i)/fv1(1);
% end
% fv1(1)=fv1(1)/180;

%-----------------------------------------feature xtraction 2----------------------------------------- 
subimage_index2 = imresize(subimage_index,[12 9],'bicubic');
[rows cols dims] = size(subimage_index2);
binarysubimage_index2 = subimage_index2 > 0.02;
%figure , imshow(binarysubimage_index2);
%f(7)=bweuler(binarysubimage_index,8);  
nop=1;
for i=1:12
    for j=1:9
        fv2(nop)=binarysubimage_index2(i,j);
        nop=nop+1;
    end
end
%-----------------------------------------feature xtraction 3----------------------------------------- 
fv3=hu(binarysubimage_index1);
%-----------------------------------------feature xtraction 4----------------------------------------- 
fv4=zernike_moments(binarysubimage_index1);
%-----------------------------------------feature xtraction 5----------------------------------------- 
fv5=contour_moments(binarysubimage_index1);
%-----------------------------------------feature xtraction 6----------------------------------------- 
fv6=zoning(subimage_index);

fv7=zoning_new(subimage_index);      
fv8=regionprop(subimage_index);

% [fv3,PS3] = mapminmax(fv3);
% [fv4,PS4] = mapminmax(fv4);
% [fv5,PS5] = mapminmax(fv5);
% fv5=fv5(1,1:2);
% [fv6,PS6] = mapminmax(fv6);
% fv6=fv6';
%save fv6.mat fv6
% fv7=[fv1 fv2];  %no of pixels + all pixels
%save fv7.mat fv7
% fv8=[fv3 fv4 fv5]; %all moments
%save fv8.mat fv8
% fv9=[fv6 fv8]; % zoning + moments
features.fv1=fv1;
% features.fv2=fv2;
features.fv3=fv3;
features.fv4=fv4;
features.fv5=fv5;
features.fv6=fv6;
features.fv7=fv7;
features.fv8=fv8;
% features.fv9=fv9;
          
          

          

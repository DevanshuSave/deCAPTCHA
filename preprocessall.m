close all
clear all
clc

% read the input image
inpImage =imread('ez1.jpg');

% size of image
[rows cols dims] = size(inpImage);
s = size(inpImage);

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
o2=o1;
for i=1:2
    o2=medfilt2(o2);
end
o2=~o2;
o1=~o1;

% removing all connected components with no of pixels less than x
x=100;
o3=o1;
o3=bwareaopen(o3,x);


%edge detection
I=i1;
a=[-1 -1 -1 ; 0 0 0 ; 1 1 1]'
b=[a(1,2) a(1,3) a(2,3);a(1,1) a(2,2) a(3,3);a(2,1) a(3,1) a(3,2)]
c=[b(1,2) b(1,3) b(2,3);b(1,1) b(2,2) b(3,3);b(2,1) b(3,1) b(3,2)]
d=[c(1,2) c(1,3) c(2,3);c(1,1) c(2,2) c(3,3);c(2,1) c(3,1) c(3,2)]
e=[d(1,2) d(1,3) d(2,3);d(1,1) d(2,2) d(3,3);d(2,1) d(3,1) d(3,2)]
f=[e(1,2) e(1,3) e(2,3);e(1,1) e(2,2) e(3,3);e(2,1) e(3,1) e(3,2)]
g=[f(1,2) f(1,3) f(2,3);f(1,1) f(2,2) f(3,3);f(2,1) f(3,1) f(3,2)]
h=[g(1,2) g(1,3) g(2,3);g(1,1) g(2,2) g(3,3);g(2,1) g(3,1) g(3,2)]

for x=2:1:s(1)-1;
for y=2:1:s(2)-1;
A(x,y)=[a(1)*I(x-1,y-1)+a(2)*I(x-1,y)+a(3)*I(x-1,y+1)+a(4)*I(x,y-1)+a(5)*I(x,y)+a(6)*I(x,y+1)+a(7)*I(x+1,y-1)+a(8)*I(x+1,y)+a(9)*I(x+1,y+1)];
B(x,y)=[b(1)*I(x-1,y-1)+b(2)*I(x-1,y)+b(3)*I(x-1,y+1)+b(4)*I(x,y-1)+b(5)*I(x,y)+b(6)*I(x,y+1)+b(7)*I(x+1,y-1)+b(8)*I(x+1,y)+b(9)*I(x+1,y+1)];
C(x,y)=[c(1)*I(x-1,y-1)+c(2)*I(x-1,y)+c(3)*I(x-1,y+1)+c(4)*I(x,y-1)+c(5)*I(x,y)+c(6)*I(x,y+1)+c(7)*I(x+1,y-1)+c(8)*I(x+1,y)+c(9)*I(x+1,y+1)];
D(x,y)=[d(1)*I(x-1,y-1)+d(2)*I(x-1,y)+d(3)*I(x-1,y+1)+d(4)*I(x,y-1)+d(5)*I(x,y)+d(6)*I(x,y+1)+d(7)*I(x+1,y-1)+d(8)*I(x+1,y)+d(9)*I(x+1,y+1)];
E(x,y)=[e(1)*I(x-1,y-1)+e(2)*I(x-1,y)+e(3)*I(x-1,y+1)+e(4)*I(x,y-1)+e(5)*I(x,y)+e(6)*I(x,y+1)+e(7)*I(x+1,y-1)+e(8)*I(x+1,y)+e(9)*I(x+1,y+1)];
F(x,y)=[f(1)*I(x-1,y-1)+f(2)*I(x-1,y)+f(3)*I(x-1,y+1)+f(4)*I(x,y-1)+f(5)*I(x,y)+f(6)*I(x,y+1)+f(7)*I(x+1,y-1)+f(8)*I(x+1,y)+f(9)*I(x+1,y+1)];
G(x,y)=[g(1)*I(x-1,y-1)+g(2)*I(x-1,y)+g(3)*I(x-1,y+1)+g(4)*I(x,y-1)+g(5)*I(x,y)+g(6)*I(x,y+1)+g(7)*I(x+1,y-1)+g(8)*I(x+1,y)+g(9)*I(x+1,y+1)];
H(x,y)=[h(1)*I(x-1,y-1)+h(2)*I(x-1,y)+h(3)*I(x-1,y+1)+h(4)*I(x,y-1)+h(5)*I(x,y)+h(6)*I(x,y+1)+h(7)*I(x+1,y-1)+h(8)*I(x+1,y)+h(9)*I(x+1,y+1)]; 
end
end
W=max(max(max(max(max(max(max(A,B),C),D),E),F),G),H);

o4 = bwmorph(o3,'remove');
o5=o3;
for i=1:3
    o5 = bwmorph(o5,'thin',Inf);
end


imwrite(o5,'ez11.jpg','jpg');
%imwrite(o3,'ez12.jpg','jpg');

figure(1),imshow(inpImage);
figure(2),imshow(o1);
figure(3),imshow(o2);
figure(4),imshow(o3);
figure(5),imshow(o4);
figure(6),imshow(o5);
figure(7),imshow(uint8(W));
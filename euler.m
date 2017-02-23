clear all
close all
a=imread('0.jpg');
figure,imshow(a);
display(a);
no=bweuler(a,8);
display(no);
[rows cols dims] = size(a);
for i=1:rows
    for j=1:cols
        if(a(i,j)<127)
           a(i,j)=0;
        else
            a(i,j)=255;
        end
    end
end
figure,imshow(a);
display(a);
no=bweuler(a,8);
display(no);

% for i=1:rows
%     if (a(i,1)==255)
%         a(i,2)=255;
%     end
%     if (a(i,cols)==255)
%         a(i,cols-1)=255;
%     end
%     a(i,1)=0;
%     a(i,cols)=0;
% end
% 
% 
% for j=1:cols
%     if(a(1,j)==255)
%         a(2,j)=255;
%     end
%     if(a(rows,j)==255)
%         a(rows-1,j)=255;
%     end
%     a(1,j)=0;
%     a(rows,j)=0;
% end
% 
% figure,imshow(a);
% display(a);
% no=bweuler(a,8);
% display(no);
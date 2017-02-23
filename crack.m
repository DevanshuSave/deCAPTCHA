close all
imtool close all
clear all
clc


% read the input image
path='O:\full code\mp3raid\49.jpg';
captchas={'authorize' 'iimk' 'ezgimpy' 'gojiyo' 'passport' 'paypal' 'register' 'vodafone' 'wikipedia' 'mp3raid'};
for i=1:10
    k = strfind(path, char(captchas(i)));
    if isempty(k) == 1
        i=i+1;
    else
        captcha=captchas(i);
    end
end
display(captcha);
i=1;
op='';
inpImage =imread(path);
figure,imshow(inpImage);
ppImage=preprocessing(inpImage,captcha);
imshow(ppImage);
[subimages count]=segment1(ppImage);
while(i<=count)
    %figure, imshow(cell2mat(subimages(i)));
    each_char=cell2mat(subimages(i));
    e_no=bweuler(each_char,8);
    display(e_no);
    if(e_no==0)
        op=strcat(op,net0(each_char));
        display(op);
    end
    if(e_no==1)
        op=strcat(op,net1(each_char));
    end
    if(e_no==-1)
        op=strcat(op,net_1(each_char));
    end
    if(e_no~=0 || e_no~=1 || e_no~=-1)
        op=strcat(op,net_gen(each_char));
    end
    i=i+1;
    
end
display(op);

close all
clear all
clc

fv1=zeros(40,6);
fv2=zeros(40,108);
fv3=zeros(40,7);
fv4=zeros(40,4);
fv5=zeros(40,4);
fv6=zeros(40,32);
%do1=zeros(960,7);
%do2=eye(960,16);

count=1;
for k = 1:20
    for m = 0:1
        s=strcat('C:\Users\admin\Documents\DECAPTCHER\workspace\testings\DATABASE COLLECTION\all captcha database\code\61-80 db\en_-1\',int2str(m),'\','*','.png');
        files=dir(s); 
        s1= strcat(int2str(m),'\',files(k).name);
        %display(files(k).name);
        subimage_index =imread(s1);

        %--------------------------------------feature xtraction 1--------------------------------------
        [rows cols dims] = size(subimage_index);
        xyratio=rows/cols;
        subimage_index1 = imresize(subimage_index,[15 12],'bicubic');
        [rows cols dims] = size(subimage_index1);
        binarysubimage_index1 = subimage_index1 > 0.02;
        fv1(count,6)= xyratio;
        if(fv1(count,6)>4) 
            fv1(count,6)=1;
        else
            fv1(count,6)=fv1(count,6)/4;
        end
        for i=1:rows
            for j=1:cols
                if(binarysubimage_index1(i,j)~=0)
                    fv1(count,1)=fv1(count,1)+1;
                    if(j<=cols/2)
                        fv1(count,2)=fv1(count,2)+1;
                    else
                        fv1(count,3)=fv1(count,3)+1;
                    end
                    if(i<=rows/2)
                        fv1(count,4)=fv1(count,4)+1;
                    else
                        fv1(count,5)=fv1(count,5)+1;
                    end
                end
            end
        end
        for i=2:5
            fv1(count,i)=fv1(count,i)/fv1(count,1);
        end
        fv1(count,1)=fv1(count,1)/180;

    %-----------------------------------------feature xtraction 2-------------------------------------- 
        subimage_index2 = imresize(subimage_index,[12 9],'bicubic');
        [rows cols dims] = size(subimage_index2);
        binarysubimage_index2 = subimage_index2 > 0.02;
        nop=1;
        for i=1:12
            for j=1:9
                fv2(count,nop)=binarysubimage_index2(i,j);
                nop=nop+1;
            end
        end
        op=dec2bin(files(k).name(1),7);
         for i=1:7
             do1(count,i)=op(i)-48;
         end

        %--------------------------feature extraction 3--------------------------------------               
        fv3(count,:)=hu_moments(binarysubimage_index1);
        %--------------------------feature extraction 4--------------------------------------
        fv4(count,:)=zernike_moments(binarysubimage_index1);
        %--------------------------feature extraction 5--------------------------------------
        fv5(count,:)=contour_moments(binarysubimage_index1);
        %--------------------------feature extraction 6--------------------------------------
        fv6(count,:)=zoning(binarysubimage_index1);

        count=count+1;
    end
end
%[fv3,PS3] = mapminmax(fv3);
%[fv4,PS4] = mapminmax(fv4);
%[fv5,PS5] = mapminmax(fv5);
%fv5=fv5(:,1:2);
%[fv6,PS6] = mapminmax(fv6); % zoning
fv7=[fv1 fv2];  %no of pixels + all pixels 
fv8=[fv3 fv4 fv5]; %all moments
fv9=[fv6 fv8]; % zoning + moments
% save 60n-fv_nop.mat fv1
% save 60n-fv_allp.mat fv2
% save 60n-fv_hu.mat fv3
% save 60n-fv_zer.mat fv4
% save 60n-fv_cont.mat fv5
save t20-en-1-fv_zone.mat fv6
save t20-en-1-nop+allp.mat fv7
save t20-en-1-fv_moments.mat fv8
save t20-en-1-fv_zone+fv_moments.mat fv9
% save en0_do1.mat do1
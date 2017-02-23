function fv_con = contour_moments(F)
%   close all
%   clear all
%  subimage_index =imread('0 (8).png');
%  subimage_index1 = imresize(subimage_index,[15 12],'bicubic');
%  F=subimage_index1;
F=double(F);
[M,N]=size(F);
[x,y]=meshgrid(1:N,1:M);
x=x(:);
y=y(:);
F=F(:);
m.m00=sum(F);
m.m10=sum(x.*F);
m.m01=sum(y.*F);
m.m10=sum(x.*F);
m.m11=sum(x.*y.*F);
m.m20=sum(x.^2.*F);
m.m02=sum(y.^2.*F);
m.m30=sum(x.^3.*F);
m.m03=sum(y.^3.*F);
m.m12=sum(x.*y.^2.*F);
m.m21=sum(x.^2.*y.*F);
nContour=M*N;
xc=m.m10/m.m00;
yc=m.m01/m.m00;
for n=1:5
    for j=1:M
        for i=1:N
            ed(j,i)=sqrt(power(i-xc,2)+power(j-yc,2));
        end
    end
end
for n=1:5
    sums=0;
    for j=1:M
        for i=1:N
            sums=sums+power(ed(j,i),n);
        end
    end
    rMoment(n)=1/nContour*sums;
end
for n=1:5
    sums=0;
    for j=1:M
        for i=1:N
            sums=sums+power(ed(j,i)-rMoment(1),n);
        end
    end
    rCentralMoment(n)=1/nContour*sums;
end
con(1)=power(rCentralMoment(2),0.5)/rMoment(1);
con(2)=rCentralMoment(3)/power(rCentralMoment(2),1.5);
con(3)=rCentralMoment(4)/power(rCentralMoment(2),2);
con(4)=rCentralMoment(5)/power(rCentralMoment(2),2.5);
fv_con=con;
%display(con);
%[fv_con,PS] = mapminmax(con);
%display(fv_con);




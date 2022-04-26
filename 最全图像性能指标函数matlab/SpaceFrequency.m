
%计算空间频率
%=============================================
%空间频率反映了一幅图像空间域的总体活跃度
%=============================================

clear all
[filename,pathname]=uigetfile('*.*','图像');
A=imread([pathname,filename]);
%s=size(size(A));

%if s(2)==3
%    A=rgb2gray(A);
%end

A=double(A);
[M,N]=size(A);
sum1=0;
sum2=0;

%计算行频率
for i=1:M
    for j=2:N
        w=A(i,j)-A(i,j-1);
        sum1=sum1+w^2;
    end
end
RF=sqrt(sum1/(M*N));

%计算列频率
for j=1:N
    for i=2:M
        w=A(i,j)-A(i-1,j);
        sum2=sum2+w^2;
    end
end
CF=sqrt(sum2/(M*N));

SF=sqrt(RF^2+CF^2)
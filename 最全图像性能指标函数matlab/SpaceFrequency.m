
%����ռ�Ƶ��
%=============================================
%�ռ�Ƶ�ʷ�ӳ��һ��ͼ��ռ���������Ծ��
%=============================================

clear all
[filename,pathname]=uigetfile('*.*','ͼ��');
A=imread([pathname,filename]);
%s=size(size(A));

%if s(2)==3
%    A=rgb2gray(A);
%end

A=double(A);
[M,N]=size(A);
sum1=0;
sum2=0;

%������Ƶ��
for i=1:M
    for j=2:N
        w=A(i,j)-A(i,j-1);
        sum1=sum1+w^2;
    end
end
RF=sqrt(sum1/(M*N));

%������Ƶ��
for j=1:N
    for i=2:M
        w=A(i,j)-A(i-1,j);
        sum2=sum2+w^2;
    end
end
CF=sqrt(sum2/(M*N));

SF=sqrt(RF^2+CF^2)

%��������

%����ͼ�� 
clear all
[filename, pathname] = uigetfile('*.*','�ں�ͼ��');
image1=imread([pathname, filename]);
A=image1; 
A=double(A);
[filename, pathname] = uigetfile('*.*','����ͼ��');
image2=imread([pathname, filename]);
B=image2;
B=double(B);

[M,N]=size(A);
sum=0;

for i=1:M
    for j=1:N
        sum=sum+(B(i,j)-A(i,j))^2;
    end
end
y=sum/(M*N)
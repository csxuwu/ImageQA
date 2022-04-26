
%计算峰值信噪比
%输入图像 
clear all
[filename, pathname] = uigetfile('*.*','融合图像');
image1=imread([pathname, filename]);
A=image1; 
A=double(A);
[filename, pathname] = uigetfile('*.*','理想图像');
image2=imread([pathname, filename]);
B=image2;
B=double(B);

[M,N]=size(A);
sum=0;

%计算标准偏差
for i=1:M
    for j=1:N
        sum=sum+(B(i,j)-A(i,j))^2;
    end
end
RSME=sqrt(sum/(M*N));

%峰值信噪比
y=20*log(abs(max(max(A(:)))/RSME))
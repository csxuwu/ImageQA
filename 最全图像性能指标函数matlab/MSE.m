
%求均方误差

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

for i=1:M
    for j=1:N
        sum=sum+(B(i,j)-A(i,j))^2;
    end
end
y=sum/(M*N)